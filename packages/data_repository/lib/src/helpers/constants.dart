class ApiConstants {
  static const String openaikey =
      'sk-proj-G4RPCqFkRaQyykZxQH0HT3BlbkFJfFvb5znlHDiUygQjBwzK';
  static const String objRecUrl = 'https://srapi-ptjztkf3ba-ue.a.run.app/statue_recognition';
  static const String openaiTranscriptionUrl =
      'https://api.openai.com/v1/audio/transcriptions';
  static const String openaiSpeechUrl =
      'https://api.openai.com/v1/audio/speech';
  static const String openaiGPTCompletionUrl =
      'https://api.openai.com/v1/chat/completions';

  static const List<String> femaleVoices = [
    "nova",
    "shimmer",
  ];

  static const List<String> maleVoices = [
    "echo",
    "onyx",
    "fable",
    "alloy",
  ];
}
