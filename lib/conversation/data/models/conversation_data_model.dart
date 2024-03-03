import 'package:talk2statue/conversation/domain/entities/conversation_data.dart';

class ConversationDataModel extends ConversationData {
  const ConversationDataModel({
    super.text,
    super.filePath,
  });

  factory ConversationDataModel.textFromJson(Map<String, dynamic> jsonMap) {
    return ConversationDataModel(
      text: jsonMap['text'],
    );
  }

  factory ConversationDataModel.fileFromJson(Map<String, dynamic> jsonMap) {
    return ConversationDataModel(
      filePath: jsonMap['file_path'],
    );
  }
}
