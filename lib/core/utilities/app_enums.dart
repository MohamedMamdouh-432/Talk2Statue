enum SpeechModel {
  tts1,
  tts1HD,
}

enum SpeechVoice {
  alloy,
  echo,
  fable,
  onyx,
  nova, // for female
  shimmer, // for female
}

enum ConversationRequestState {
  Initialized,
  Prepared,
  RecordingStopped,
  RecordingStarted,
  RecordingCompleted,
  OnProgress,
  Successful,
  Failure,
  StatueTalking,
  Done,
  Failed,
}

enum RecongnitionRequestState {
  Declared,
  Initialized,
  OnProgress,
  SuccessfulInCapturing,
  SuccessfulInRecognizing,
  FailedInCapturing,
  FailedInRecognizing,
}
