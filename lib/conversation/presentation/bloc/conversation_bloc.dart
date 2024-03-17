import 'dart:developer';
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
    on<ConversationStatuePreperationEvent>(_onprepareStatue);
    on<VisitorStartRecordingEventRequested>(_onStartRecordingVisitorVoice);
    on<VisitorStopRecordingEventRequested>(_onStopRecordingVisitorVoice);
    on<ReinitializationRecordingEventRequested>(_onReinitializeRecording);
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
          requestState: ConversationRequestState.RecordingStopped,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: '_onInitializeConversation : $e',
          requestState: ConversationRequestState.Failure,
        ),
      );
    }
  }

  Future<void> _onprepareStatue(
      ConversationStatuePreperationEvent event, emit) async {
    String msg =
        "I'm a tourist in Egypt, please act as king ${event.statueName} and chat with me to know more about you, start with greeting word to me";
    log(msg);
    try {
      final gptResult =
          await gptReplayingVisitorQuestionService(GPTAnswerParams(msg));
      gptResult.fold(
          (l) => emit(state.copyWith(
                message: l.errorMessage,
                requestState: ConversationRequestState.Failure,
              )), (r) {
        log('ChatGPT Answer: ${r.gptAnswerText}');
        emit(
          state.copyWith(
            requestState: ConversationRequestState.Prepared,
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          requestState: ConversationRequestState.Failure,
          message: '_onprepareStatue : $e',
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
            requestState: ConversationRequestState.RecordingStarted,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          requestState: ConversationRequestState.Failure,
          message: '_onStartRecordingVisitorVoice : $e',
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
          requestState: ConversationRequestState.RecordingCompleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestState: ConversationRequestState.Failure,
          message: '_onStopRecordingVisitorVoice : $e',
        ),
      );
    }
  }

  Future<void> _onReinitializeRecording(event, emit) async {
    emit(
      state.copyWith(
        requestState: ConversationRequestState.RecordingStopped,
      ),
    );
  }

  Future<void> _onStatueReplaying(
      StatueReplayEventRequested event, emit) async {
    String error = '', data = '';

    // Emit Service is Started in Progress
    emit(state.copyWith(requestState: ConversationRequestState.OnProgress));

    // Start to Call STT Service
    final sttResult =
        await audioTranscriptionService(AudioParams(state.userAudioFilePath));
    sttResult.fold(
        (l) => error = l.errorMessage, (r) => data = r.transcribedText);
    if (sttResult.isLeft()) {
      emit(
        state.copyWith(
          message: error,
          requestState: ConversationRequestState.Failure,
        ),
      );
      return;
    }
    log('Trancribed Text: $data');
    // Start to Call GPT Service
    final gptResult =
        await gptReplayingVisitorQuestionService(GPTAnswerParams(data));
    gptResult.fold(
        (l) => error = l.errorMessage, (r) => data = r.gptAnswerText);
    if (sttResult.isLeft()) {
      emit(
        state.copyWith(
          message: error,
          requestState: ConversationRequestState.Failure,
        ),
      );
      return;
    }
    log('GPT Answer: $data');
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
          requestState: ConversationRequestState.Failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestState: ConversationRequestState.Successful,
          statueAudioFilePath: r.speechFilePath,
        ),
      ),
    );
  }

  Future<void> _onStatueBeginTalking(event, emit) async {
    try {
      emit(
          state.copyWith(requestState: ConversationRequestState.StatueTalking));
      await statuePlayer.setAudioSource(
          AudioSource.uri(Uri.parse(state.statueAudioFilePath)));

      if (statuePlayer.processingState != ProcessingState.ready) {
        await statuePlayer.processingStateStream
            .firstWhere((state) => state == ProcessingState.ready);
      }

      await statuePlayer.play();

      if (statuePlayer.processingState != ProcessingState.completed) {
        await statuePlayer.processingStateStream
            .firstWhere((state) => state == ProcessingState.completed);
      }

      emit(state.copyWith(requestState: ConversationRequestState.Done));
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          requestState: ConversationRequestState.Failed,
        ),
      );
    }
  }

  Future<void> _onDisposeConversation(event, emit) async {
    await statuePlayer.dispose();
    await statueRecorder.dispose();
  }
}
