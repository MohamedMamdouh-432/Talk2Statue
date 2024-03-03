import 'package:dartz/dartz.dart';
import 'package:talk2statue/conversation/data/datasource/conversation_remote_datasource.dart';
import 'package:talk2statue/conversation/domain/entities/audio_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';
import 'package:talk2statue/conversation/domain/entities/speech_parameter.dart';
import 'package:talk2statue/conversation/domain/repository/base_conversation_repository.dart';
import 'package:talk2statue/core/error/error_exceptions.dart';
import 'package:talk2statue/core/error/failure.dart';

class ConversationRepository implements BaseConversationRepository {
  final BaseConversationRemoteDataSources baseConversationRemoteDataSource;

  ConversationRepository(this.baseConversationRemoteDataSource);

  @override
  Future<Either<Failure, ConversationData>> createTextSpeech(
      SpeechParams params) async {
    try {
      final results =
          await baseConversationRemoteDataSource.createTextSpeech(params);
      return Right(results);
    } on ServerException catch (se) {
      return Left(ServerFailure(se.exceptionMessage));
    }
  }

  @override
  Future<Either<Failure, ConversationData>> transcribeAudioFile(
      AudioParams params) async {
    try {
      final results =
          await baseConversationRemoteDataSource.transcribeAudioFile(params);
      return Right(results);
    } on ServerException catch (se) {
      return Left(ServerFailure(se.exceptionMessage));
    }
  }
}
