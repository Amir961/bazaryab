import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final String statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});
  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class TransactionBuilderException extends Equatable implements Exception {
  const TransactionBuilderException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
class NoLanguageSavedException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}
