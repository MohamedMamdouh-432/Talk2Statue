import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:models_repository/models_repository.dart';
import 'package:talk2statue/shared/data/functions.dart';

part 'recognition_event.dart';
part 'recognition_state.dart';

class RecognitionBloc
    extends Bloc<StatueRecognitionEvent, StatueRecognitionState> {
  final DataRepository _dataRepository;

  RecognitionBloc({
    required DataRepository dataRepo,
  })  : _dataRepository = dataRepo,
        super(StatueRecognitionState.initial) {
    on<StatueCapturingEventRequested>(_onCaptureStatue);
    on<StatueUndoCapturingEventRequested>(_onUndoCaptureStatue);
    on<StatueRecognitionEventRequested>(_onRecognizeStatue);
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
        statueImagePath: imagePath,
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
      statueImagePath: '',
      requestState: RecongnitionRequestState.Initial,
    ));
  }

  Future<void> _onRecognizeStatue(
      StatueRecognitionEventRequested event, emit) async {
    try {
      emit(state.copyWith(requestState: RecongnitionRequestState.OnProgress));
      final result =
          await _dataRepository.recognizeStatue(state.statueImagePath);
      result.fold(
        (left) => emit(
          state.copyWith(
            message: left.errorMessage,
            requestState: RecongnitionRequestState.FailedInRecognizing,
          ),
        ),
        (right) => emit(
          state.copyWith(
            message: '',
            statueName: right.name,
            statueGender: right.gender,
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
