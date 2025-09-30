import '../entity/app_theme.dart';
import '../repository/theme_repository.dart';

class SetAppTheme {
  final ThemeRepository repository;

  const SetAppTheme({
    required this.repository,
  });

  Future<void> call(AppTheme theme) => repository.setTheme(theme);
}
