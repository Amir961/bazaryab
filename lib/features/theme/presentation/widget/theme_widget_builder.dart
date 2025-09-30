import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/utils/typdef.dart';
import '../bloc/app_theme_bloc.dart';

class ThemeWidgetBuilder extends StatelessWidget {
  final BlocStateBuilder<AppThemeState> builder;

  const ThemeWidgetBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, state) => builder(state),
      );
}
