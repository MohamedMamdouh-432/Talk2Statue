import 'package:dartz/dartz.dart';
import 'package:talk2statue/conversation/domain/entities/audio_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';
import 'package:talk2statue/conversation/domain/repository/base_conversation_repository.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/core/services/base_service.dart';

class AudioTranscriptionService
    extends BaseService<ConversationData, AudioParams> {
  final BaseConversationRepository baseCRepo;

  AudioTranscriptionService(this.baseCRepo);

  @override
  Future<Either<Failure, ConversationData>> call(AudioParams p) async {
    return await baseCRepo.transcribeAudioFile(p);
  }
}
