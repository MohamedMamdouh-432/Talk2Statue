import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:talk2statue/conversation/domain/entities/audio_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/gpt_answer_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/speech_parameter.dart';
import 'package:talk2statue/conversation/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/conversation/domain/services/replay_visitor_question.dart';
import 'package:talk2statue/conversation/domain/services/transcribe_audio_to_text.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  late Directory appDir;
  late AudioPlayer statuePlayer;
  late AudioRecorder statueRecorder;
  final AudioTranscriptionService audioTranscriptionService;
  final SpeechCreatingService speechCreateService;
  final GPTReplayingVisitorQuestionService gptReplayingVisitorQuestionService;

  ConversationBloc({
    required this.audioTranscriptionService,
    required this.speechCreateService,
    required this.gptReplayingVisitorQuestionService,
  }) : super(const ConversationState()) {
    on<ConversationInitialEvent>(_onInitializeConversation);
    on<VisitorStartRecordingEventRequested>(_onStartRecordingVisitorVoice);
    on<VisitorStopRecordingEventRequested>(_onStopRecordingVisitorVoice);
    on<StatueReplayEventRequested>(_onStatueReplaying);
    on<StatueTalkingEventRequested>(_onStatueBeginTalking);
    on<ConversationDisposeEvent>(_onDisposeConversation);
  }

  Future<void> _onInitializeConversation(event, emit) async {
    try {
      statuePlayer = AudioPlayer();
      statueRecorder = AudioRecorder();
      appDir = await getApplicationDocumentsDirectory();
      emit(
        state.copyWith(
          requestState: RequestState.recordingOff,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          requestState: RequestState.failure,
        ),
      );
    }
  }

  Future<void> _onStartRecordingVisitorVoice(event, emit) async {
    try {
      if (await statueRecorder.hasPermission()) {
        await statueRecorder.start(
          const RecordConfig(),
          path: '${appDir.path}/visitor_speech.wav',
        );
        emit(
          state.copyWith(
            requestState: RequestState.recordingOn,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          requestState: RequestState.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onStopRecordingVisitorVoice(event, emit) async {
    try {
      final audioPath = await statueRecorder.stop();
      emit(
        state.copyWith(
          userAudioFilePath: audioPath,
          requestState: RequestState.recordingCompleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestState: RequestState.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onStatueReplaying(
      StatueReplayEventRequested event, emit) async {
    String error = '', data = '';

    // Emit Service is Started in Progress
    emit(state.copyWith(requestState: RequestState.onProgress));

    // Start to Call STT Service
    final sttResult =
        await audioTranscriptionService(AudioParams(state.userAudioFilePath));
    sttResult.fold(
        (l) => error = l.errorMessage, (r) => data = r.transcribedText);
    if (sttResult.isLeft()) {
      emit(
        state.copyWith(
          message: error,
          requestState: RequestState.failure,
        ),
      );
      return;
    }
    print('Trancribed Text: $data');
    // Start to Call GPT Service
    final gptResult =
        await gptReplayingVisitorQuestionService(GPTAnswerParams(data));
    gptResult.fold(
        (l) => error = l.errorMessage, (r) => data = r.gptAnswerText);
    if (sttResult.isLeft()) {
      emit(
        state.copyWith(
          message: error,
          requestState: RequestState.failure,
        ),
      );
      return;
    }
    print('GPT Answer: $data');
    // Start to Call TTS Service
    final ttsResult = await speechCreateService(
      SpeechParams(
        text: data,
        voiceModel: event.voiceModel,
      ),
    );
    ttsResult.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          requestState: RequestState.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestState: RequestState.successful,
          statueAudioFilePath: r.speechFilePath,
        ),
      ),
    );
  }

  Future<void> _onStatueBeginTalking(event, emit) async {
    try {
      await statuePlayer.setAudioSource(
          AudioSource.uri(Uri.parse(state.statueAudioFilePath)));
      await statuePlayer.play();
      emit(state.copyWith(
        requestState: RequestState.recordingOff,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          requestState: RequestState.failure,
        ),
      );
    }
  }

  Future<void> _onDisposeConversation(event, emit) async {
    statueRecorder.dispose();
  }
}
