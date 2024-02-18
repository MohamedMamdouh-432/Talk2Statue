import 'package:talk2statue/speech_transcription/domain/entities/speech_transcription.dart';

class SpeechTranscriptionModel extends SpeechTranscription {
  const SpeechTranscriptionModel({
    super.text,
    super.filePath,
  });

  factory SpeechTranscriptionModel.textFromJson(Map<String, dynamic> jsonMap) {
    return SpeechTranscriptionModel(
      text: jsonMap['text'],
    );
  }
  
  factory SpeechTranscriptionModel.fileFromJson(Map<String, dynamic> jsonMap) {
    return SpeechTranscriptionModel(
      filePath: jsonMap['file_path'],
    );
  }
}
