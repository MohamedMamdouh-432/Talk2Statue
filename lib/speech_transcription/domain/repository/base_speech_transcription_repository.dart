import 'package:dartz/dartz.dart';

import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';
import 'package:talk2statue/speech_transcription/domain/entities/transcription_parameter.dart';

abstract class BaseSpeechTranscriptionRepository {
  Future<Either<Failure, SpeechTranscription>> transcribeAudioFile(TranscriptionParams params);
  Future<Either<Failure, SpeechTranscription>> createTextSpeech(SpeechParams params);
}
