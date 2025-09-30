
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

import '../../domain/entity/app_language.dart';
import '../models/app_language_model.dart';

abstract class LanguageDataSource {
  /// save app language
  ///
  Future<bool> setLanguage(AppLanguageModel language);

  /// get app current language
  ///
  /// throw [NoLanguageSavedException] if nothing saved.
  ///
  AppLanguage get getLanguage;
}

const languageKey = 'Language';

class LanguageDataSourceImpl implements LanguageDataSource {
  final SharedPreferences sharedPreferences;

  const LanguageDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  AppLanguage get getLanguage {
    final tag = sharedPreferences.getString(languageKey);
     debugPrint('Language_is: ${tag.toString()}');
     if (tag == null) throw NoLanguageSavedException();

    return AppLanguageModel.fromTag(tag, '', '');
  }

  @override
  Future<bool> setLanguage(AppLanguageModel language) =>
      sharedPreferences.setString(languageKey, language.tag);
}
