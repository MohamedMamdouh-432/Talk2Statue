part of 'speech_transcription_bloc.dart';

sealed class SpeechTranscriptionEvent extends Equatable {
  const SpeechTranscriptionEvent();

  @override
  List<Object> get props => [];
}

class AudioTranscriptionEventRequested extends SpeechTranscriptionEvent {
  final TranscriptionParams transcriptionParams;
  const AudioTranscriptionEventRequested(this.transcriptionParams);

  @override
  List<Object> get props => [transcriptionParams];
}

class SpeechCreatingEventRequested extends SpeechTranscriptionEvent {
  final SpeechParams speechParams;
  const SpeechCreatingEventRequested(this.speechParams);

  @override
  List<Object> get props => [speechParams];
}
