import 'package:equatable/equatable.dart';

import 'exception.dart';


abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});
  final String message;
  final dynamic statusCode;

  String get errorMessage => message;

  @override
  List<dynamic> get props => [message, statusCode];
}

// General failures
class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});
  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, required super.statusCode});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message, super.statusCode});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(
      {required super.message, required super.statusCode});
}
