part of 'statue_recognition_bloc.dart';

sealed class StatueRecognitionEvent extends Equatable {
  const StatueRecognitionEvent();

  @override
  List<Object> get props => [];
}

class StatueRecognitionEventRequested extends StatueRecognitionEvent {
  final StatueParams statueParams;

  const StatueRecognitionEventRequested(this.statueParams);
  
   @override
  List<Object> get props => [statueParams];
}
