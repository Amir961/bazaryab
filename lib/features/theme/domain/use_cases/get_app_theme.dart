import '../entity/app_theme.dart';
import '../repository/theme_repository.dart';

class GetAppTheme {
  final ThemeRepository repository;

  const GetAppTheme({
    required this.repository,
  });

  AppTheme call() => repository.getTheme;
}
