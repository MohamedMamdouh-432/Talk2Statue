import 'package:equatable/equatable.dart';

class AudioParams extends Equatable {
  final String filePath;

  const AudioParams(this.filePath);

  @override
  List<Object> get props => [filePath];
}
