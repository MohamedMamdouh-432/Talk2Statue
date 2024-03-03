import 'package:dartz/dartz.dart';
import 'package:talk2statue/conversation/domain/entities/audio_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';
import 'package:talk2statue/conversation/domain/entities/speech_parameter.dart';
import 'package:talk2statue/core/error/failure.dart';

abstract class BaseConversationRepository {
  Future<Either<Failure, ConversationData>> transcribeAudioFile(
      AudioParams params);
  Future<Either<Failure, ConversationData>> createTextSpeech(
      SpeechParams params);
}
