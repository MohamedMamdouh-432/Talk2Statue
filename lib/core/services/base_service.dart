import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:talk2statue/core/error/failure.dart';

abstract class BaseService<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters p);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}
