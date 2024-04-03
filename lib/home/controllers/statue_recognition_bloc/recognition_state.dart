part of 'recognition_bloc.dart';

class StatueRecognitionState extends Equatable {
  final String statueName;
  final String statueGender;
  final String statueImagePath;
  final String message;
  final RecongnitionRequestState requestState;

  const StatueRecognitionState({
    required this.message,
    required this.statueName,
    required this.statueGender,
    required this.requestState,
    required this.statueImagePath,
  });

  static StatueRecognitionState initial = const StatueRecognitionState(
    message: '',
    statueName: 'UnKnown',
    statueGender: 'Unknown',
    statueImagePath: '',
    requestState: RecongnitionRequestState.Initial,
  );

  StatueRecognitionState copyWith({
    String? statueName,
    String? statueGender,
    String? statueImagePath,
    RecongnitionRequestState? requestState,
    String? message,
  }) {
    return StatueRecognitionState(
      statueName: statueName ?? this.statueName,
      message: message ?? this.message,
      statueGender: statueGender ?? this.statueGender,
      requestState: requestState ?? this.requestState,
      statueImagePath: statueImagePath ?? this.statueImagePath,
    );
  }

  @override
  List<Object> get props => [
        statueName,
        statueGender,
        requestState,
        message,
        statueImagePath,
      ];
}
