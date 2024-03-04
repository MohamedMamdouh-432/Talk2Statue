part of 'statue_recognition_bloc.dart';

class StatueRecognitionState extends Equatable {
  final Statue statue;
  final RequestState requestState;
  final String message;

  const StatueRecognitionState({
    this.statue = const Statue(name: '', gender: ''),
    this.requestState = RequestState.initialized,
    this.message = '',
  });

  StatueRecognitionState copyWith({
    Statue? statue,
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
        statue,
        requestState,
        message,
      ];
}
