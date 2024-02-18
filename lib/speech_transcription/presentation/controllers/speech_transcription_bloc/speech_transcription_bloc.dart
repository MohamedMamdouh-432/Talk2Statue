import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';
import 'package:talk2statue/speech_transcription/domain/entities/transcription_parameter.dart';
import 'package:talk2statue/speech_transcription/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/speech_transcription/domain/services/transcribe_audio_to_text.dart';

part 'speech_transcription_event.dart';
part 'speech_transcription_state.dart';

class SpeechTranscriptionBloc
    extends Bloc<SpeechTranscriptionEvent, SpeechTranscriptionState> {
  final AudioTranscriptionService audioTranscriptionService;
  final SpeechCreatingService speechCreateService;

  SpeechTranscriptionBloc({
    required this.audioTranscriptionService,
    required this.speechCreateService,
  }) : super(const SpeechTranscriptionState()) {
    on<AudioTranscriptionEventRequested>(_onTranscripeAudio);
    on<SpeechCreatingEventRequested>(_onCreateSpeech);
  }

  Future<void> _onTranscripeAudio(
      AudioTranscriptionEventRequested event, emit) async {
    emit(state.copyWith(requestState: RequestState.onProgress));
    final result =
        await audioTranscriptionService(event.transcriptionParams);
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          requestState: RequestState.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          speechTranscription: r,
          requestState: RequestState.successful,
        ),
      ),
    );
  }

  Future<void> _onCreateSpeech(SpeechCreatingEventRequested event, emit) async {
    emit(state.copyWith(requestState: RequestState.onProgress));
    final result =
        await speechCreateService(event.speechParams);
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          requestState: RequestState.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          speechTranscription: r,
          requestState: RequestState.successful,
        ),
      ),
    );
  }
}
