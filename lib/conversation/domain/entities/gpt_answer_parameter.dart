import 'package:equatable/equatable.dart';

class GPTAnswerParams extends Equatable {
  final String text;
  
  const GPTAnswerParams(this.text);

  @override
  List<Object> get props => [text];
}
