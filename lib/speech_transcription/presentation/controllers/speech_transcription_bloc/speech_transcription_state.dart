part of 'speech_transcription_bloc.dart';

class SpeechTranscriptionState extends Equatable {
  final SpeechTranscription? speechTranscription;
  final RequestState requestState;
  final String message;

  const SpeechTranscriptionState({
    this.speechTranscription,
    this.requestState = RequestState.requested,
    this.message = '',
  });

  SpeechTranscriptionState copyWith({
    SpeechTranscription? speechTranscription,
    RequestState? requestState,
    String? message,
  }) {
    return SpeechTranscriptionState(
      speechTranscription: speechTranscription ?? this.speechTranscription,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [
        speechTranscription!,
        requestState,
        message,
      ];
}
