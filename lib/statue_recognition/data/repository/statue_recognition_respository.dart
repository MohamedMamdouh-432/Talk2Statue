import 'package:dartz/dartz.dart';
import 'package:talk2statue/core/error/error_exceptions.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/statue_recognition/data/datasource/statue_recognition_remote_datasource.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';
import 'package:talk2statue/statue_recognition/domain/repository/base_statue_recognation_repository.dart';

class StatueRecognitionRepository implements BaseStatueRecognitionRepository {
  final BaseStatueRecognitionRemoteDataSource
      baseStatueRecognitionRemoteDataSource;

  StatueRecognitionRepository(this.baseStatueRecognitionRemoteDataSource);

  @override
  Future<Either<Failure, Statue>> recognizeStatue(StatueParams params) async {
    try {
      final results = await baseStatueRecognitionRemoteDataSource.recognizeStatue(params);
      return Right(results);
    } on ServerException catch (se) {
      return Left(ServerFailure(se.exceptionMessage));
    }
  }
}
