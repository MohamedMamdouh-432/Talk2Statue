import 'package:talk2statue/core/utilities/app_enums.dart';

class ApiConstants {
  static const String baseUrl = 'https://gpapp-s75tsx6xfa-as.a.run.app';
  static const String objRecEndPoint = 'obj';
  static const String objRecUrl = '$baseUrl/$objRecEndPoint';
  static const String openaikey =
      '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';
  static const String openaiTranscriptionUrl =
      'https://api.openai.com/v1/audio/transcriptions';
  static const String openaiSpeechUrl =
      'https://api.openai.com/v1/audio/speech';
  static const Map<SpeechModel, String> speechModels = {
    SpeechModel.tts1: "tts-1",
    SpeechModel.tts1HD: "tts-1-hd",
  };
  static const Map<SpeechVoice, String> voiceModels = {
    SpeechVoice.alloy: "alloy",
    SpeechVoice.echo: "echo",
    SpeechVoice.fable: "fable",
    SpeechVoice.onyx: "onyx",
    SpeechVoice.nova: "nova",
    SpeechVoice.shimmer: "shimmer",
  };
}
