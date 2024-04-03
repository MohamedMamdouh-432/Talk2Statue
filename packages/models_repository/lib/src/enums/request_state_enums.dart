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
  Initial,
  Initialized,
  OnProgress,
  SuccessfulInCapturing,
  SuccessfulInRecognizing,
  FailedInCapturing,
  FailedInRecognizing,
}