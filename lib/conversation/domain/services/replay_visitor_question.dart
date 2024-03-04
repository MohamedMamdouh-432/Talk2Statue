import 'package:dartz/dartz.dart';
import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';
import 'package:talk2statue/conversation/domain/entities/gpt_answer_parameter.dart';
import 'package:talk2statue/conversation/domain/repository/base_conversation_repository.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/core/services/base_service.dart';

class GPTReplayingVisitorQuestionService
    extends BaseService<ConversationData, GPTAnswerParams> {
  final BaseConversationRepository baseCRepo;

  GPTReplayingVisitorQuestionService(this.baseCRepo);

  @override
  Future<Either<Failure, ConversationData>> call(GPTAnswerParams p) async {
    return await baseCRepo.replaytoVisitorQuestion(p);
  }
}
