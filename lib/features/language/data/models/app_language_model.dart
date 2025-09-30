

import '../../domain/entity/app_language.dart';

class AppLanguageModel extends AppLanguage {
  const AppLanguageModel({
    required String language,
    required String nameEnglish,
    required String nameNative,
  }) : super(
          language: language,
          nameEnglish: nameEnglish,
          nameNative: nameNative,
        );

  factory AppLanguageModel.fromTag(
          String tag, String nameEnglish, String nameNative) =>
      AppLanguageModel(
        language: tag,
        nameEnglish: nameEnglish,
        nameNative: nameNative,
      );

  String get tag => language;

  factory AppLanguageModel.defaultLanguage() =>
      // ServerHelper.instance.typeServer == TypeServer.salemsaz
      //     ?
      const AppLanguageModel(
              language: 'fa',
              nameEnglish: 'Farsi',
              nameNative: 'فارسی',
            )
      //     :
      // const AppLanguageModel(
      //         language: 'en',
      //         nameEnglish: 'English',
      //         nameNative: 'English',
      //       )
  ;

  factory AppLanguageModel.fromEntity(AppLanguage entity) => AppLanguageModel(
        language: entity.language,
        nameEnglish: entity.nameEnglish,
        nameNative: entity.nameNative,
      );
  factory AppLanguageModel.fromJson(Map<String, dynamic> json) =>
      AppLanguageModel(
        language: json['id'],
        nameEnglish: json['name_native'],
        nameNative: json['name_english'],
      );
}
