import 'package:equatable/equatable.dart';

class ConversationData extends Equatable {
  final String text;
  final String filePath;

  const ConversationData({
    this.text = '',
    this.filePath = '',
  });

  @override
  List<Object> get props => [
        text,
        filePath,
      ];
}
