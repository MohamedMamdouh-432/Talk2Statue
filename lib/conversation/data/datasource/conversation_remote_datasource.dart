import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/conversation/data/models/conversation_data_model.dart';
import 'package:talk2statue/conversation/domain/entities/audio_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';
import 'package:talk2statue/conversation/domain/entities/gpt_answer_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/speech_parameter.dart';
import 'package:talk2statue/core/error/error_exceptions.dart';
import 'package:talk2statue/core/utilities/api_constants.dart';

abstract class BaseConversationRemoteDataSources {
  final Dio _conversationDio;

  const BaseConversationRemoteDataSources(Dio dio) : _conversationDio = dio;

  Future<ConversationData> transcribeAudioFile(AudioParams params);
  Future<ConversationData> createTextSpeech(SpeechParams params);
  Future<ConversationData> replaytoVisitorQuestion(GPTAnswerParams params);
}

class ConversationRemoteDataSources extends BaseConversationRemoteDataSources {
  ConversationRemoteDataSources(super.dio);

  @override
  Future<ConversationData> transcribeAudioFile(AudioParams params) async {
    try {
      _conversationDio.options.headers["Authorization"] =
          "Bearer ${ApiConstants.openaikey}";

      var formData = FormData.fromMap({
        "model": "whisper-1",
        "language": "en",
        "file": await MultipartFile.fromFile(params.filePath),
      });

      final response = await _conversationDio
          .post(ApiConstants.openaiTranscriptionUrl, data: formData);
      if (response.statusCode == 200) {
        return ConversationDataModel.textFromJson(response.data);
      } else {
        throw ServerException(
          exceptionMessage: 'Error while Transcriping Audio File',
        );
      }
    } catch (e) {
      throw ServerException(
        exceptionMessage: 'Error while Handling Request',
      );
    }
  }

  @override
  Future<ConversationData> createTextSpeech(SpeechParams params) async {
    try {
      _conversationDio.options.headers = {
        'Authorization': 'Bearer ${ApiConstants.openaikey}',
        'Content-Type': 'application/json',
      };

      final response = await _conversationDio.post<List<int>>(
        ApiConstants.openaiSpeechUrl,
        data: {
          "model": 'tts-1',
          "input": params.text,
          "voice": params.voiceModel,
        },
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        const fileName = 'speech.mp3';
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(response.data!);
        return ConversationDataModel.fileFromJson({
          'file_path': filePath,
        });
      } else {
        throw ServerException(
          exceptionMessage: 'Error while Creating Speech Audio File',
        );
      }
    } catch (e) {
      throw ServerException(
        exceptionMessage: 'Error while Handling Request',
      );
    }
  }

  @override
  Future<ConversationData> replaytoVisitorQuestion(
      GPTAnswerParams params) async {
    List<Map<String, dynamic>> prevList = [];
    prevList.add({
      "role": "user",
      "content": params.text,
    });
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": prevList,
          "temperature": 0.7,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        prevList.add({
          "role": "assistant",
          "content": data['choices'][0]['message']['content'],
        });
        return ConversationDataModel.answerFromJson(data);
      } else if (response.statusCode == 429) {
        final retryAfterHeader = response.headers['Retry-After'];
        if (retryAfterHeader != null) {
          final retryAfterSeconds = int.tryParse(retryAfterHeader);
          if (retryAfterSeconds != null) {
            await Future.delayed(Duration(seconds: retryAfterSeconds));
            return await replaytoVisitorQuestion(params);
          }
        }
        throw ServerException(
            exceptionMessage:
                'Received a 429 error without a valid Retry-After header.');
      } else {
        throw ServerException(
            exceptionMessage:
                'Failed to send bot message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(exceptionMessage: e.toString());
    }
  }
}
