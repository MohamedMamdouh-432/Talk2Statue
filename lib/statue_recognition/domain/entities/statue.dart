import 'package:equatable/equatable.dart';

class Statue extends Equatable {
  final String name;
  final String gender;

  const Statue({
    required this.name,
    required this.gender,
  });

  @override
  List<Object> get props => [
        name,
        gender,
      ];
}
