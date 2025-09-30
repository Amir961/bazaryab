import '../../features/language/data/models/app_language_model.dart';
import '../../features/language/domain/entity/app_language.dart';

abstract class LanguageHelper {
  AppLanguage convertToAppLanguage(String tag);
}

class LanguageHelperImpl implements LanguageHelper {
  @override
  AppLanguage convertToAppLanguage(String tag) =>
      AppLanguageModel.fromTag(tag, '', '');
}
