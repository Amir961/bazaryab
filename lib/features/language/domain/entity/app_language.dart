import 'package:equatable/equatable.dart';

class AppLanguage extends Equatable {
  final String language;
  final String nameNative;
  final String nameEnglish;

  const AppLanguage({
    required this.language,
    required this.nameNative,
    required this.nameEnglish,
  });

  @override
  List<Object?> get props => [language, nameNative, nameEnglish];
}
