import '../entity/app_theme.dart';

abstract class ThemeRepository {

  Future<void> setTheme(AppTheme theme);

  AppTheme get getTheme;
}