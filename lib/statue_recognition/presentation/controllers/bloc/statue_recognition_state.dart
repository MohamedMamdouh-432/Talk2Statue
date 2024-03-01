part of 'statue_recognition_bloc.dart';

class StatueRecognitionState extends Equatable {
  final StatueInfo? statue;
  final RequestState requestState;
  final String message;

  const StatueRecognitionState({
    this.statue,
    this.requestState = RequestState.requested,
    this.message = '',
  });

  StatueRecognitionState copyWith({
    StatueInfo? statue,
    RequestState? requestState,
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
        statue!,
        requestState,
        message,
      ];
}
