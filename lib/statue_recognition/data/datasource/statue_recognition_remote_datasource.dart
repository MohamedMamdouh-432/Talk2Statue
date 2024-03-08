import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:talk2statue/core/error/error_exceptions.dart';
import 'package:talk2statue/core/utilities/api_constants.dart';
import 'package:talk2statue/statue_recognition/data/models/statue_model.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';

abstract class BaseStatueRecognitionRemoteDataSource {
  final Dio _statueRecognitionDio;

  const BaseStatueRecognitionRemoteDataSource(Dio dio)
      : _statueRecognitionDio = dio;

  Future<Statue> recognizeStatue(StatueParams params);
}

class StatueRecognitionRemoteDataSource
    extends BaseStatueRecognitionRemoteDataSource {
  StatueRecognitionRemoteDataSource(super.dio);

  @override
  Future<Statue> recognizeStatue(StatueParams params) async {
    if (params.statueImg == null)
      log("It's Null");
    else
      log(params.statueImg);
    try {
      var formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(params.statueImg),
      });
      var response = await _statueRecognitionDio.post(
        ApiConstants.objRecUrl,
        data: formData,
      );
      if (response.statusCode == 200) {
        return StatueModel.fromJson(response.data);
      } else {
        throw ServerException(
          exceptionMessage: response.data['error'],
        );
      }
    } catch (e) {
      throw ServerException(
        exceptionMessage: 'Error while Handling Request => $e',
      );
    }
  }
}
