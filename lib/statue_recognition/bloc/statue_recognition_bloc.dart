import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';
import 'package:talk2statue/statue_recognition/domain/services/recognize_statue.dart';

part 'statue_recognition_event.dart';
part 'statue_recognition_state.dart';

class StatueRecognitionBloc
    extends Bloc<StatueRecognitionEvent, StatueRecognitionState> {
  final StatueRecognitionService statueRecognitionService;

  StatueRecognitionBloc({
    required this.statueRecognitionService,
  }) : super(const StatueRecognitionState()) {
    on<StatueRecognitionEventRequested>(_onRecognizeStatue);
  }

  Future<void> _onRecognizeStatue(
      StatueRecognitionEventRequested event, emit) async {
    emit(state.copyWith(requestState: RequestState.onProgress));
    final result = await statueRecognitionService(event.statueParams);
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          requestState: RequestState.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          statue: r,
          requestState: RequestState.successful,
        ),
      ),
    );
  }
}
