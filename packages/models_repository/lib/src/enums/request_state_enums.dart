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
  ModelLoading,
  MuseumSuccess,
  MuseumFailure,
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