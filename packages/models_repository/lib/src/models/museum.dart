import 'package:equatable/equatable.dart';

class Museum extends Equatable {
  final String name;
  final String desc;

  const Museum({
    required this.name,
    required this.desc,
  });

  factory Museum.fromJson(Map<String, dynamic> jsonMap) {
    return Museum(
      name: jsonMap['name'],
      desc: jsonMap['desc'],
    );
  }

  @override
  List<Object> get props => [
        name,
        desc,
      ];
}
