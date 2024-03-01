import 'package:equatable/equatable.dart';

class StatueInfo extends Equatable {
  final String name;
  final String gender;

  const StatueInfo({
    required this.name,
    required this.gender,
  });

  @override
  List<Object> get props => [
        name,
        gender,
      ];
}
