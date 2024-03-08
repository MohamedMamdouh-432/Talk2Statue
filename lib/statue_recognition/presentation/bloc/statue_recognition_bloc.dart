import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk2statue/core/data/functions.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';
import 'package:talk2statue/statue_recognition/domain/services/recognize_statue.dart';

part 'statue_recognition_event.dart';
part 'statue_recognition_state.dart';

class StatueRecognitionBloc
    extends Bloc<StatueRecognitionEvent, StatueRecognitionState> {
  String? imagePath;

  final StatueRecognitionService statueRecognitionService;

  StatueRecognitionBloc({
    required this.statueRecognitionService,
  }) : super(const StatueRecognitionState()) {
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
      imagePath = await saveFileLocally(pickedImage.path);
      log(imagePath!);
      emit(state.copyWith(
        message: '',
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
    imagePath = null;
    emit(state.copyWith(
      requestState: RecongnitionRequestState.Declared,
    ));
  }

  Future<void> _onRecognizeStatue(
      StatueRecognitionEventRequested event, emit) async {
    try {
      emit(state.copyWith(requestState: RecongnitionRequestState.OnProgress));
      if (imagePath == null)
        log('Image is Null');
      else
        log(imagePath!);
      final result = await statueRecognitionService(StatueParams(imagePath!));
      result.fold(
        (l) => emit(
          state.copyWith(
            message: '_onRecognizeStatue ${l.errorMessage}',
            requestState: RecongnitionRequestState.FailedInRecognizing,
          ),
        ),
        (r) => emit(
          state.copyWith(
            statue: r,
            requestState: RecongnitionRequestState.SuccessfulInRecognizing,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: '_onRecognizeStatue Error while Recognition Statue',
          requestState: RecongnitionRequestState.FailedInRecognizing,
        ),
      );
    }
  }
}
