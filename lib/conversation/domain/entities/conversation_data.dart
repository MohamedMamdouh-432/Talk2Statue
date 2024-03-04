import 'package:equatable/equatable.dart';

class ConversationData extends Equatable {
  final String transcribedText;
  final String speechFilePath;
  final String gptAnswerText;

  const ConversationData({
    this.transcribedText = '',
    this.speechFilePath = '',
    this.gptAnswerText = '',
  });

  @override
  List<Object> get props => [
        transcribedText,
        speechFilePath,
        gptAnswerText,
      ];
}
