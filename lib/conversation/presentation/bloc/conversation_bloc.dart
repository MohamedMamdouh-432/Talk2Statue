import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:talk2statue/conversation/domain/entities/audio_parameter.dart';
import 'package:talk2statue/conversation/domain/entities/speech_parameter.dart';
import 'package:talk2statue/conversation/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/conversation/domain/services/transcribe_audio_to_text.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  FlutterSoundRecorder? statueRecorder;
  final AudioTranscriptionService audioTranscriptionService;
  final SpeechCreatingService speechCreateService;

  ConversationBloc({
    required this.audioTranscriptionService,
    required this.speechCreateService,
  }) : super(const ConversationState()) {
    on<ConversationInitialEvent>(_onInitializeConversation);
    on<VisitorStartRecordingEventRequested>(_onStartRecordingVisitorVoice);
    on<VisitorStopRecordingEventRequested>(_onStopRecordingVisitorVoice);
    on<StatueReplayEventRequested>(_onStatueReplaying);
    on<ConversationDisposeEvent>(_onDisposeConversation);
  }

  Future<void> _onInitializeConversation(event, emit) async {
    try {
      statueRecorder = await FlutterSoundRecorder().openRecorder();
      if (statueRecorder == null)
        throw Exception('Cannot Open Conversation Session');
      emit(
        state.copyWith(
          requestState: RequestState.recordingOff,
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

  Future<void> _onStartRecordingVisitorVoice(event, emit) async {
    try {
      if (statueRecorder == null)
        throw Exception('Cannot Start Conversation Session');
      await statueRecorder!.startRecorder(
        toFile: 'visitor_record.mp3',
        codec: Codec.mp3,
      );
      emit(
        state.copyWith(
          requestState: RequestState.recordingOn,
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

  Future<void> _onStopRecordingVisitorVoice(event, emit) async {
    try {
      if (statueRecorder == null) throw Exception('Cannot Stop Recording Talk');
      final filePath = await statueRecorder!.stopRecorder();
      emit(
        state.copyWith(
          userAudioFilePath: filePath,
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
    sttResult.fold((l) => error = l.errorMessage, (r) => data = r.transcribedText);
    if (sttResult.isLeft()) {
      emit(
        state.copyWith(
          message: error,
          requestState: RequestState.failure,
        ),
      );
      return;
    }

    // Start to Call GPT Service

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

  Future<void> _onDisposeConversation(event, emit) async {
    statueRecorder?.closeRecorder();
    statueRecorder = null;
  }
}
