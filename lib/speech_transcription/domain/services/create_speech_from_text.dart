import 'package:dartz/dartz.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/core/services/base_service.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';
import 'package:talk2statue/speech_transcription/domain/repository/base_speech_transcription_repository.dart';

class SpeechCreatingService
    extends BaseService<SpeechTranscription, SpeechParams> {
  final BaseSpeechTranscriptionRepository baseSTRepo;

  SpeechCreatingService(this.baseSTRepo);

  @override
  Future<Either<Failure, SpeechTranscription>> call(SpeechParams p) async {
    return await baseSTRepo.createTextSpeech(p);
  }
}
