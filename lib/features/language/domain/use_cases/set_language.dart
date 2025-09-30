import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../../../../core/usecases/usecases.dart';
import '../entity/app_language.dart';
import '../repository/language_repository.dart';

class SetLanguage extends UseCase<void, Params> {
  final LanguageRepository repository;
  const SetLanguage({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async =>
      Right(await repository.setLanguage(params.language));
}

class Params extends NoParams {
  final AppLanguage language;
  const Params({
    required this.language,
  });
  @override
  List<Object> get props => [
        language,
      ];
}
