import 'package:equatable/equatable.dart';

class SpeechTranscription extends Equatable {
  final String text;
  final String filePath;

  const SpeechTranscription({
    this.text = '',
    this.filePath = '',
  });

  @override
  List<Object> get props => [
        text,
        filePath,
      ];
}
