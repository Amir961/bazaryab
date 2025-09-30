import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/theme_helper.dart';
import '../../data/models/app_theme_model.dart';
import '../../domain/entity/app_theme.dart';
import '../../domain/use_cases/get_app_theme.dart';
import '../../domain/use_cases/set_app_theme.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  final GetAppTheme getAppTheme;
  final SetAppTheme setAppTheme;
  final ThemeHelper helper;
  AppThemeBloc(
      {
    required this.getAppTheme,
    required this.setAppTheme,
    required this.helper,
  }
 ) : super(AppThemeState(theme: getAppTheme())) {
 // ) : super(const AppThemeState(theme: AppThemeModel(id: 1, theme: ThemeMode.dark,))) {
    on<SetAppThemeEvent>(_onSetAppThemeEvent);
  }

  Future<void> _onSetAppThemeEvent(
    SetAppThemeEvent event,
    Emitter<AppThemeState> emit,
  ) async {
    final appTheme = helper.convertToAppTheme(event.themeMode);
    setAppTheme(appTheme);
    emit(AppThemeState(theme: appTheme));
  }
}
