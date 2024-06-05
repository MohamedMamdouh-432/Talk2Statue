part of 'recognition_bloc.dart';

sealed class RecognitionEvent extends Equatable {
  const RecognitionEvent();

  @override
  List<Object> get props => [];
}

class CapturingEventRequested extends RecognitionEvent {
  final ImageSource captureFrom;
  const CapturingEventRequested(this.captureFrom);

  @override
  List<Object> get props => [captureFrom];
}

class UndoCapturingEventRequested extends RecognitionEvent {}

class RecognitionEventRequested extends RecognitionEvent {}
