import 'dart:developer';

import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:models_repository/models_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  // data repository dependency
  final DataRepository _dataRepository;

  // bloc controllers
  late AudioPlayer statuePlayer;
  late AudioRecorder statueRecorder;
  late UnityWidgetController unityController;

  // bloc helpers data
  bool isModelReady = false;
  Map<String, String> modelsData = {
    'Nefertiti': 'nefertitiQueen',
    // TODO: add Akhenaten GameObject name
    'Akhenaten': '',
  };

  ConversationBloc({
    required DataRepository dataRepo,
  })  : _dataRepository = dataRepo,
        super(ConversationState.initial) {
    on<ConversationInitialEvent>(_onInitializeConversation);
    on<ConversationStatuePreperationEvent>(_onprepareStatue);
    on<VisitorStartRecordingEventRequested>(_onStartRecordingVisitorVoice);
    on<VisitorStopRecordingEventRequested>(_onStopRecordingVisitorVoice);
    on<ResetRecordingEventRequested>(_onResetRecording);
    on<StatueReplayEventRequested>(_onStatueReplaying);
    on<StatueTalkingEventRequested>(_onStatueBeginTalking);
    on<ConversationDisposeEvent>(_onDisposeConversation);
  }

  Future<void> _onInitializeConversation(event, emit) async {
    try {
      statuePlayer = AudioPlayer();
      statueRecorder = AudioRecorder();
      emit(state.copyWith(
          requestState: ConversationRequestState.RecordingStopped));
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
        requestState: ConversationRequestState.Failure,
      ));
    }
  }

  Future<void> _onprepareStatue(
      ConversationStatuePreperationEvent event, emit) async {
    String msg =
        "I'm a tourist in Egypt, please act as king ${event.statueName} and chat with me to know more about you, start with greeting word to me";
    log(msg);
    try {
      isModelReady = modelsData.containsKey(event.statueName);
      final result = await _dataRepository.replaytoVisitorQuestion(msg);
      result.fold((l) {
        log(l.errorMessage.toString());
        emit(state.copyWith(
          message: l.errorMessage.toString(),
          requestState: ConversationRequestState.Failure,
        ));
      }, (r) {
        log('ChatGPT Answer: $r');
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
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onStartRecordingVisitorVoice(event, emit) async {
    try {
      if (await statueRecorder.hasPermission()) {
        final appDir = await getApplicationDocumentsDirectory();
        await statueRecorder.start(
          const RecordConfig(),
          path: '${appDir.path}/visitor_speech.mp3',
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

  Future<void> _onResetRecording(event, emit) async {
    emit(
      state.copyWith(
        requestState: ConversationRequestState.RecordingStopped,
      ),
    );
  }

  Future<void> _onStatueReplaying(
      StatueReplayEventRequested event, emit) async {
    emit(state.copyWith(requestState: ConversationRequestState.OnProgress));
    final result = await _dataRepository.makeStatueReplaying(
      state.userAudioFilePath,
      event.speechVoice,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage.toString(),
          requestState: ConversationRequestState.Failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestState: ConversationRequestState.Successful,
          statueAudioFilePath: r,
        ),
      ),
    );
  }

  Future<void> _onStatueBeginTalking(
      StatueTalkingEventRequested event, emit) async {
    try {
      emit(
          state.copyWith(requestState: ConversationRequestState.StatueTalking));

      if (isModelReady) {
        await unityController.postMessage(
          modelsData[event.statueName]!,
          'PlayAudioClip',
          state.statueAudioFilePath,
        );
      } else {
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
    unityController.dispose();
  }
}
