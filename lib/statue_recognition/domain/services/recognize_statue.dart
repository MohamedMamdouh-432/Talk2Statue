import 'package:dartz/dartz.dart';
import 'package:talk2statue/core/error/failure.dart';
import 'package:talk2statue/core/services/base_service.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';
import 'package:talk2statue/statue_recognition/domain/repository/base_statue_recognation_repository.dart';

class StatueRecognitionService extends BaseService<Statue, StatueParams> {
  final BaseStatueRecognitionRepository baseSRRepo;

  StatueRecognitionService(this.baseSRRepo);

  @override
  Future<Either<Failure, Statue>> call(StatueParams p) async {
    return await baseSRRepo.recognizeStatue(p);
  }
}
