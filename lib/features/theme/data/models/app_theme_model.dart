import 'package:flutter/material.dart';
import '../../domain/entity/app_theme.dart';

class AppThemeModel extends AppTheme {
  const AppThemeModel({
    required int id,
    required ThemeMode theme,
  }) : super(
          id: id,
          theme: theme,
        );

  factory AppThemeModel.fromIndex(int index) => AppThemeModel(
        id: index,
        theme: ThemeMode.values[index],
      );

  factory AppThemeModel.fromThemeMode(ThemeMode mode) => AppThemeModel(
        id: mode.index,
        theme: mode,
      );

  factory AppThemeModel.defaultTheme() => AppThemeModel(
        id: ThemeMode.dark.index,
        theme: ThemeMode.dark,
      );
}
