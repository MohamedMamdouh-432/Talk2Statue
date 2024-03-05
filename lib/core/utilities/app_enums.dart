enum SpeechModel {
  tts1,
  tts1HD,
}

enum SpeechVoice {
  alloy,
  echo,
  fable,
  onyx,
  nova,
  shimmer,
}

enum RequestState {
  initialized,
  prepared,
  recordingOff,
  recordingOn,
  recordingCompleted,
  onProgress,
  successful,
  failure,
  statueTalking,
  Done,
  Failed,
}
