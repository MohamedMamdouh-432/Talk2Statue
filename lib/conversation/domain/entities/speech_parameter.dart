import 'package:equatable/equatable.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';

class SpeechParams extends Equatable {
  final String text;
  final SpeechVoice voiceModel;

  const SpeechParams({
    required this.text,
    required this.voiceModel,
  });

  @override
  List<Object> get props => [
        text,
        voiceModel,
      ];
}
