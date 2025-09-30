import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../../features/language/presentation/bloc/app_language_bloc.dart';
import '../../../../injection_container.dart';
import '../../../utils/assets.dart';
import 'app_provider_inherited.dart';

class AppProvider extends StatefulWidget {
  final Widget child;

  const AppProvider({
    Key? key,
    required this.child,
  }) : super(key: key);
  static AppProviderState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppProviderInherited>()!
        .data;
  }

  @override
  AppProviderState createState() => AppProviderState();
}

class AppProviderState extends State<AppProvider> {
  @override
  Widget build(BuildContext context) {
    return AppProviderInherited(
      data: this,
      child: widget.child,
    );
  }

  bool get hasAppleSignIn =>
      true
  ;

  bool get isTablet => false;
  // !(MediaQuery.of(context).size.shortestSide < 600);
  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  double getFontSize(double value) => getLocale == 'fa' ? value - 2 : value;
  String get getFontFamily =>
      getLocale == 'fa' ? Fonts.iranSans : Fonts.poppins;


  TextDirection get getTextDirection=>
      isRightToLeft ? TextDirection.rtl : TextDirection.ltr;

  String get getLocale =>
      BlocProvider.of<AppLanguageBloc>(context).state.language.language.toLowerCase();

  bool get isFA =>
      BlocProvider.of<AppLanguageBloc>(context).state.language.language.toLowerCase() ==
      'fa';
  bool get isRightToLeft =>
      BlocProvider.of<AppLanguageBloc>(context).state.language.language.toLowerCase() ==
      'fa';
}
