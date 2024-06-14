import 'dart:convert';
import 'dart:io';

import 'package:data_repository/src/helpers/constants.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:models_repository/models_repository.dart';
import 'package:path_provider/path_provider.dart';

class DataRepository {
  final Dio dio;

  DataRepository({
    required this.dio,
  });

  Future<Either<Failure, Statue>> recognizeStatue(String statueImgPath) async {
    try {
      var response = await dio.post(
        ApiConstants.objRecUrl,
        data: FormData.fromMap({
          "file": await MultipartFile.fromFile(statueImgPath),
        }),
      );
      if (response.statusCode == 200) {
        return Right(Statue.fromJson(response.data));
      } else {
        return Left(Failure(response.data['error']));
      }
    } catch (e) {
      return Left(Failure('Error while Handling Request => $e'));
    }
  }

  Future<Either<Failure, String>> transcribeAudioFile(String filePath) async {
    try {
      dio.options.headers["Authorization"] = "Bearer ${ApiConstants.openaikey}";

      var formData = FormData.fromMap({
        "model": "whisper-1",
        "language": "en",
        "file": await MultipartFile.fromFile(filePath),
      });

      final response =
          await dio.post(ApiConstants.openaiTranscriptionUrl, data: formData);
      if (response.statusCode == 200) {
        return Right(response.data['text']);
      } else {
        return const Left(Failure('Error while Transcriping Audio File'));
      }
    } catch (e) {
      throw Left(Failure('Error in transcribeAudioFile $e'));
    }
  }

  Future<Either<Failure, String>> createTextSpeech(
    String text,
    String speechVoice,
  ) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${ApiConstants.openaikey}',
        'Content-Type': 'application/json',
      };

      final response = await dio.post<List<int>>(
        ApiConstants.openaiSpeechUrl,
        data: {
          "input": text,
          "model": 'tts-1',
          "voice": speechVoice,
          "response_format": 'wav',
        },
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        const fileName = 'statue_speech.wav';
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(response.data!);
        return Right(filePath);
      } else {
        return const Left(Failure('Error while Creating Speech Audio File'));
      }
    } catch (e) {
      return Left(Failure('Error in createTextSpeech $e'));
    }
  }

  Future<Either<Failure, String>> replaytoVisitorQuestion(
    String question,
  ) async {
    try {
      List<Map<String, dynamic>> prevList = [];
      prevList.add({
        "role": "user",
        "content": question,
      });
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.openaikey}',
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
        return Right(data['choices'][0]['message']['content']);
      } else if (response.statusCode == 429) {
        final retryAfterHeader = response.headers['Retry-After'];
        if (retryAfterHeader != null) {
          final retryAfterSeconds = int.tryParse(retryAfterHeader);
          if (retryAfterSeconds != null) {
            await Future.delayed(Duration(seconds: retryAfterSeconds));
            return await replaytoVisitorQuestion(question);
          }
        }
        return const Left(Failure(
            'Received a 429 error without a valid Retry-After header.'));
      } else {
        return Left(Failure(
            'Failed to send bot message. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('Error in replaytoVisitorQuestion $e'));
    }
  }

  Future<Either<Failure, String>> makeStatueReplaying(
      String audioFile, String speechVoice) async {
    try {
      // process 1: transcribe audio file
      final transcibeResult = await transcribeAudioFile(audioFile);
      if (transcibeResult.isLeft) return Left(transcibeResult.left);

      // process 2: get answer from gpt
      final gptResult = await replaytoVisitorQuestion(transcibeResult.right);
      if (gptResult.isLeft) return Left(gptResult.left);

      // process 3: convert text answer to voice file
      final speechResult = await createTextSpeech(
        gptResult.right,
        speechVoice,
      );
      if (speechResult.isLeft) return Left(speechResult.left);

      // return voice to tourist
      return Right(speechResult.right);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
