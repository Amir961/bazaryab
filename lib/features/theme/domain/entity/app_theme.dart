import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTheme extends Equatable {
  final int id;
  final ThemeMode theme;
  const AppTheme({
    required this.id,
    required this.theme,
  });

  @override
  List<Object?> get props => [
        id,
        theme,
      ];
}
