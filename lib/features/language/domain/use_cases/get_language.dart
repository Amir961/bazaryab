import '../entity/app_language.dart';
import '../repository/language_repository.dart';

class GetLanguage {
  final LanguageRepository repository;
  const GetLanguage({
    required this.repository,
  });

  AppLanguage call() => repository.getLanguage;
}
