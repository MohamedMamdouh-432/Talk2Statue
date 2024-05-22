part of 'recognition_bloc.dart';

sealed class StatueRecognitionEvent extends Equatable {
  const StatueRecognitionEvent();

  @override
  List<Object> get props => [];
}

class StatueCapturingEventRequested extends StatueRecognitionEvent {
  final ImageSource captureFrom;
  const StatueCapturingEventRequested(this.captureFrom);

  @override
  List<Object> get props => [captureFrom];
}

class StatueUndoCapturingEventRequested extends StatueRecognitionEvent {
  const StatueUndoCapturingEventRequested();

  @override
  List<Object> get props => [];
}

class StatueRecognitionEventRequested extends StatueRecognitionEvent {
  const StatueRecognitionEventRequested();

  @override
  List<Object> get props => [];
}
