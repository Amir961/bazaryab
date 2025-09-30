part of 'app_theme_bloc.dart';

class AppThemeState extends Equatable {
  final AppTheme theme;
  const AppThemeState({
    required this.theme,
  });

  @override
  List<Object> get props => [
        theme,
      ];

  List<AppTheme> get getThemeList => List.generate(
        ThemeMode.values.length,
        (index) => AppThemeModel.fromIndex(index),
      );
}
