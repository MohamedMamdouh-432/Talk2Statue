part of 'statue_recognition_bloc.dart';

class StatueRecognitionState extends Equatable {
  final String statueName;
  final String statueGender;
  final File? statueImage;
  final String message;
  final RecongnitionRequestState requestState;

  const StatueRecognitionState({
    required this.message,
    required this.statueName,
    required this.statueGender,
    required this.requestState,
    required this.statueImage,
  });

  static StatueRecognitionState initial = const StatueRecognitionState(
    message: '',
    statueName: 'UnKnown',
    statueGender: 'Unknown',
    statueImage: null,
    requestState: RecongnitionRequestState.Initial,
  );

  StatueRecognitionState copyWith({
    String? statueName,
    String? statueGender,
    File? statueImage,
    RecongnitionRequestState? requestState,
    String? message,
  }) {
    return StatueRecognitionState(
      statueName: statueName ?? this.statueName,
      message: message ?? this.message,
      statueGender: statueGender ?? this.statueGender,
      requestState: requestState ?? this.requestState,
      statueImage: statueImage ?? this.statueImage,
    );
  }

  @override
  List<Object> get props => [
        statueName,
        statueGender,
        requestState,
        message,
        statueImage!,
      ];
}
