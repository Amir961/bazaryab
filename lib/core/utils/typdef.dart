import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../error/failure.dart';


typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;
typedef BlocStateBuilder<T> = Widget Function(T state);
