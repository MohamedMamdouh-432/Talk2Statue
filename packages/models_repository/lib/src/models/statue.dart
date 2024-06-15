import 'package:equatable/equatable.dart';

class Statue extends Equatable {
  final String name;
  final String gender;

  const Statue({
    required this.name,
    required this.gender,
  });
  
  factory Statue.fromJson(Map<String, dynamic> jsonData) {
    return Statue(
      name: jsonData['name'], 
      gender: jsonData['gender'] ?? 'male',
    );
  }

  @override
  List<Object> get props => [
        name,
        gender,
      ];
}
