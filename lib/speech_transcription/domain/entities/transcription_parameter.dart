import 'package:equatable/equatable.dart';

class TranscriptionParams extends Equatable {
  final String filePath;

  const TranscriptionParams(this.filePath);

  @override
  List<Object> get props => [filePath];
}
