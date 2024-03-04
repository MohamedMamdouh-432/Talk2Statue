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
  recordingOn,
  recordingOff,
  recordingCompleted,
  onProgress,
  successful,
  failure,
}
