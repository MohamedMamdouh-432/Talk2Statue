import 'package:dartz/dartz.dart';

import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/core/services/base_service.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';
import 'package:talk2statue/speech_transcription/domain/entities/transcription_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/repository/base_speech_transcription_repository.dart';

class AudioTranscriptionService
    extends BaseService<SpeechTranscription, TranscriptionParams> {
  final BaseSpeechTranscriptionRepository baseSTRepo;

  AudioTranscriptionService(this.baseSTRepo);

  @override
  Future<Either<Failure, SpeechTranscription>> call(TranscriptionParams p) async {
    return await baseSTRepo.transcribeAudioFile(p);
  }
}
