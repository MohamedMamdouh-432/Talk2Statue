class ApiConstants {
  static const String openaikey =
      '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';
  static const String objRecUrl = 'https://gpapp-s75tsx6xfa-as.a.run.app/obj';
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
