import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/core/error/error_exceptions.dart';
import 'package:talk2statue/core/utilities/api_constants.dart';
import 'package:talk2statue/speech_transcription/data/models/speech_transcription_model.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';
import 'package:talk2statue/speech_transcription/domain/entities/transcription_parameter.dart';

abstract class BaseSpeechTranscriptionRemoteDataSources {
  final Dio _speechTranscriptionDio;

  const BaseSpeechTranscriptionRemoteDataSources(Dio dio)
      : _speechTranscriptionDio = dio;

  Future<SpeechTranscription> transcribeAudioFile(TranscriptionParams params);
  Future<SpeechTranscription> createTextSpeech(SpeechParams params);
}

class SpeechTranscriptionRemoteDataSources
    extends BaseSpeechTranscriptionRemoteDataSources {
  SpeechTranscriptionRemoteDataSources(super.dio);

  @override
  Future<SpeechTranscription> transcribeAudioFile(
      TranscriptionParams params) async {
    try {
      _speechTranscriptionDio.options.headers["Authorization"] =
          "Bearer ${ApiConstants.openaikey}";

      var formData = FormData.fromMap({
        "model": "whisper-1",
        "language": "en",
        "file": await MultipartFile.fromFile(params.filePath),
      });

      final response = await _speechTranscriptionDio
          .post(ApiConstants.openaiTranscriptionUrl, data: formData);
      if (response.statusCode == 200) {
        return SpeechTranscriptionModel.textFromJson(response.data);
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
  Future<SpeechTranscription> createTextSpeech(SpeechParams params) async {
    try {
      _speechTranscriptionDio.options.headers = {
        'Authorization': 'Bearer ${ApiConstants.openaikey}',
        'Content-Type': 'application/json',
      };

      final response = await _speechTranscriptionDio.post<List<int>>(
        ApiConstants.openaiSpeechUrl,
        data: {
          "input": params.text,
          "model": params.modelType,
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
        return SpeechTranscriptionModel.fileFromJson({
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
}
