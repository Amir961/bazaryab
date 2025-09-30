

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';
import '../utils/typdef.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class UseCaseWithoutResultFuture<Type, Params> {
  const UseCaseWithoutResultFuture();

  Future<Type> call(Params params);
}

abstract class UseCaseWithoutResultFutureAndParams<Type> {
  const UseCaseWithoutResultFutureAndParams();

  Future<Type> call();
}

abstract class UseCase<Type, Params extends NoParams> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}
