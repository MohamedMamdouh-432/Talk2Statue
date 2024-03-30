import 'dart:io';

import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk2statue/core/data/functions.dart';
import 'package:talk2statue/core/utils/app_enums.dart';

part 'statue_recognition_event.dart';
part 'statue_recognition_state.dart';

class StatueRecognitionBloc
    extends Bloc<StatueRecognitionEvent, StatueRecognitionState> {
  final DataRepository _dataRepository;

  StatueRecognitionBloc({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(StatueRecognitionState.initial) {
    on<StatueStartCapturingEventRequested>(_onStartCapturing);
    on<StatueCapturingEventRequested>(_onCaptureStatue);
    on<StatueUndoCapturingEventRequested>(_onUndoCaptureStatue);
    on<StatueRecognitionEventRequested>(_onRecognizeStatue);
  }

  Future<void> _onStartCapturing(event, emit) async {
    emit(state.copyWith(
      requestState: RecongnitionRequestState.Initialized,
    ));
  }

  Future<void> _onCaptureStatue(
      StatueCapturingEventRequested event, emit) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: event.captureFrom);
      if (pickedImage == null)
        throw Exception("You Don't Pick any Statue Image");
      final imagePath = await saveFileLocally(pickedImage.path);
      emit(state.copyWith(
        message: '',
        statueImage: File(imagePath),
        requestState: RecongnitionRequestState.SuccessfulInCapturing,
      ));
    } catch (e) {
      emit(state.copyWith(
        message: e.toString().substring(11),
        requestState: RecongnitionRequestState.FailedInCapturing,
      ));
    }
  }

  Future<void> _onUndoCaptureStatue(event, emit) async {
    emit(state.copyWith(
      statueImage: null,
      requestState: RecongnitionRequestState.Initial,
    ));
  }

  Future<void> _onRecognizeStatue(
      StatueRecognitionEventRequested event, emit) async {
    try {
      emit(state.copyWith(requestState: RecongnitionRequestState.OnProgress));
      final result =
          await _dataRepository.recognizeStatue(state.statueImage!.path);
      result.fold(
        (l) => emit(
          state.copyWith(
            message: l.errorMessage,
            requestState: RecongnitionRequestState.FailedInRecognizing,
          ),
        ),
        (r) => emit(
          state.copyWith(
            message: '',
            statueName: r.name,
            statueGender: r.gender,
            requestState: RecongnitionRequestState.SuccessfulInRecognizing,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: 'Error while Recognition Statue',
          requestState: RecongnitionRequestState.FailedInRecognizing,
        ),
      );
    }
  }
}
