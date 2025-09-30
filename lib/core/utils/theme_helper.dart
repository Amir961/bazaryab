import 'package:flutter/material.dart';
import '../../features/theme/data/models/app_theme_model.dart';
import '../../features/theme/domain/entity/app_theme.dart';

abstract class ThemeHelper {
  AppTheme convertToAppTheme(ThemeMode mode);
}

class ThemeHelperImpl implements ThemeHelper {
  @override
  AppTheme convertToAppTheme(ThemeMode mode) =>
      AppThemeModel.fromThemeMode(mode);
}
