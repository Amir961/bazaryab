part of 'app_theme_bloc.dart';

abstract class AppThemeEvent extends Equatable {
  const AppThemeEvent();

  @override
  List<Object> get props => [];
}

class SetAppThemeEvent extends AppThemeEvent {
  final ThemeMode themeMode;
  const SetAppThemeEvent({
    required this.themeMode,
  });

  @override
  List<Object> get props => [
        themeMode,
      ];
}
