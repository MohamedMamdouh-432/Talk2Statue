part of 'statue_recognition_bloc.dart';

class StatueRecognitionState extends Equatable {
  final Statue statue;
  final RecongnitionRequestState requestState;
  final String message;

  const StatueRecognitionState({
    this.statue = const Statue(name: 'None', gender: 'None'),
    this.requestState = RecongnitionRequestState.Declared,
    this.message = '',
  });

  StatueRecognitionState copyWith({
    Statue? statue,
    RecongnitionRequestState? requestState,
    String? message,
  }) {
    return StatueRecognitionState(
      statue: statue ?? this.statue,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        statue,
        requestState,
        message,
      ];
}
