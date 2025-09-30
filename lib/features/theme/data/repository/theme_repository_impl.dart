import '../../domain/entity/app_theme.dart';


import '../../domain/repository/theme_repository.dart';

import '../data_sources/theme_data_source.darttheme_data_source.dart';
import '../models/app_theme_model.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDataSource dataSource;

  ThemeRepositoryImpl({
    required this.dataSource,
  });

  @override
  AppTheme get getTheme {
    try {
      return dataSource.getAppTheme;
    } on Exception {
      return AppThemeModel.defaultTheme();
    }
  }

  @override
  Future<void> setTheme(AppTheme theme) => dataSource.setTheme(theme);
}
