part of 'app_language_bloc.dart';

class AppLanguageState extends Equatable {
  final AppLanguage language;
  final List<AppLanguage> listLanguage;

  const AppLanguageState({
    required this.language,

    this.listLanguage = const [],
  });

  @override
  List<Object> get props => [language, listLanguage];

  List<AppLanguage> get getLanguageList =>

  //     language: 'fa',
  // nameEnglish: 'Farsi',
  // nameNative: 'فارسی',

  //         language: 'en',
  //         nameEnglish: 'English',
  //         nameNative: 'English',

      //listLanguage;

  [
   AppLanguageModel.fromTag('fa','Farsi','فارسی'),
   AppLanguageModel.fromTag('en','English','English'),
  ];
}

class LanguageInitial extends AppLanguageState {
  LanguageInitial(
      {required AppLanguage language, })
      : super(language: language, );
}

class LanguageLoadingState extends AppLanguageState {
  LanguageLoadingState(
      {required List<AppLanguage> list,
      required AppLanguage language,
      })
      : super(
            language: language,
            listLanguage: list,
            );
}

class LanguageSuccessState extends AppLanguageState {
  LanguageSuccessState(
      {required List<AppLanguage> list,
      required AppLanguage language,
      })
      : super(
            language: language,
            listLanguage: list,
            );
}

class ChangeSuccessState extends AppLanguageState {
  ChangeSuccessState(
      {required List<AppLanguage> list,
      required AppLanguage language,
      })
      : super(
            language: language,
            listLanguage: list,
            );
}

class ListStringSuccessState extends AppLanguageState {
  ListStringSuccessState(
      {required List<AppLanguage> list,
      required AppLanguage language,
      })
      : super(
            language: language,
            listLanguage: list,
           );
}

class LanguageFailureState extends AppLanguageState {
  final String? message;

  const LanguageFailureState(
      {this.message,
      required List<AppLanguage> list,

      required AppLanguage language})
      : super(
            language: language,
            listLanguage: list,
            );
  //
  // @override
  // List<Object?> get props => [
  //   message,
  //   language,
  //   listLanguage
  // ];
}

class LanguageUnAuthorizeState extends AppLanguageState {
  LanguageUnAuthorizeState(
      {required AppLanguage language, })
      : super(language: language, );
}

class LanguageNoNetFailureState extends AppLanguageState {
  LanguageNoNetFailureState(
      {required List<AppLanguage> list,
      required AppLanguage language,
      })
      : super(
            language: language,
            listLanguage: list,
            );
}
