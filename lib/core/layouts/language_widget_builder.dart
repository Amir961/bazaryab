

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/language/presentation/bloc/app_language_bloc.dart';
import '../utils/typdef.dart';

class LanguageWidgetBuilder extends StatelessWidget {
  final BlocStateBuilder<AppLanguageState> builder;

  const LanguageWidgetBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppLanguageBloc, AppLanguageState>(
        builder: (context, state) => builder(state),
      );
}