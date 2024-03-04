import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';

class ConversationDataModel extends ConversationData {
  const ConversationDataModel({
    super.transcribedText,
    super.speechFilePath,
    super.gptAnswerText,
  });

  factory ConversationDataModel.textFromJson(Map<String, dynamic> jsonMap) {
    return ConversationDataModel(
      transcribedText: jsonMap['text'],
    );
  }

  factory ConversationDataModel.fileFromJson(Map<String, dynamic> jsonMap) {
    return ConversationDataModel(
      speechFilePath: jsonMap['file_path'],
    );
  }

  factory ConversationDataModel.answerFromJson(Map<String, dynamic> jsonMap) {
    return ConversationDataModel(
      gptAnswerText: jsonMap['choices'][0]['message']['content'],
    );
  }
}
