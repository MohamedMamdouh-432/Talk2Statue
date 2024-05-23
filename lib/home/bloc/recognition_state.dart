part of 'recognition_bloc.dart';

class RecognitionState extends Equatable {
  final String statueName;
  final String statueGender;
  final String statueImagePath;
  final String message;
  final RecongnitionRequestState requestState;

  const RecognitionState({
    required this.message,
    required this.statueName,
    required this.statueGender,
    required this.requestState,
    required this.statueImagePath,
  });

  static RecognitionState initial = const RecognitionState(
    message: 'No Error',
    statueName: 'UnKnown',
    statueGender: 'Unknown',
    statueImagePath: 'none',
    requestState: RecongnitionRequestState.Initial,
  );

  RecognitionState copyWith({
    String? statueName,
    String? statueGender,
    String? statueImagePath,
    RecongnitionRequestState? requestState,
    String? message,
  }) {
    return RecognitionState(
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

  @override
  String toString() {
    return 'Statue Recognition State(\n'
        'requestState: $requestState\n'
        'statueName: $statueName\n'
        'statueGender: $statueGender\n'
        'statueImagePath: $statueImagePath\n'
        'Error Message: $message\n'
        ')';
  }
}
