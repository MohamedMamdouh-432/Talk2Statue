import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';

class StatueModel extends Statue {
  const StatueModel({
    required super.name,
    required super.gender,
  });

  factory StatueModel.fromJson(Map<String, dynamic> jsonData) {
    return StatueModel(
      name: jsonData['name'], 
      gender: jsonData['gender'],
    );
  }
}