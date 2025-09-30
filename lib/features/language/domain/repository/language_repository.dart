import '../entity/app_language.dart';

abstract class LanguageRepository {
  Future<void> setLanguage(AppLanguage language);
  AppLanguage get getLanguage;
}
