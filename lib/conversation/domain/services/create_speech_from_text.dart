import 'package:dartz/dartz.dart';
import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';
import 'package:talk2statue/conversation/domain/entities/speech_parameter.dart';
import 'package:talk2statue/conversation/domain/repository/base_conversation_repository.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/core/services/base_service.dart';

class SpeechCreatingService
    extends BaseService<ConversationData, SpeechParams> {
  final BaseConversationRepository baseCRepo;

  SpeechCreatingService(this.baseCRepo);

  @override
  Future<Either<Failure, ConversationData>> call(SpeechParams p) async {
    return await baseCRepo.createTextSpeech(p);
  }
}
