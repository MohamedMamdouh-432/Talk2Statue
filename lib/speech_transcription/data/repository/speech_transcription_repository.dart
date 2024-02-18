import 'package:dartz/dartz.dart';
import 'package:talk2statue/core/error/error_exceptions.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/speech_transcription/data/datasource/speech_transcription_remote_datasource.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';
import 'package:talk2statue/speech_transcription/domain/entities/transcription_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/repository/base_speech_transcription_repository.dart';

class SpeechTranscriptionRepository
    implements BaseSpeechTranscriptionRepository {
  final BaseSpeechTranscriptionRemoteDataSources baseSpeechTranscriptionRemoteDataSource;

  SpeechTranscriptionRepository(this.baseSpeechTranscriptionRemoteDataSource);
  
  @override
  Future<Either<Failure, SpeechTranscription>> createTextSpeech(
      SpeechParams params) async{
    try {
      final results = await baseSpeechTranscriptionRemoteDataSource.createTextSpeech(params);
      return Right(results);
    } on ServerException catch (se) {
      return Left(ServerFailure(se.exceptionMessage));
    }
  }

  @override
  Future<Either<Failure, SpeechTranscription>> transcribeAudioFile(
      TranscriptionParams params) async{
    try {
      final results = await baseSpeechTranscriptionRemoteDataSource.transcribeAudioFile(params);
      return Right(results);
    } on ServerException catch (se) {
      return Left(ServerFailure(se.exceptionMessage));
    }
  }
}
