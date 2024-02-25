import 'package:dartz/dartz.dart';

import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';

abstract class BaseStatueRecognitionRepository {
  Future<Either<Failure, Statue>> recognizeStatue(StatueParams params);
}
