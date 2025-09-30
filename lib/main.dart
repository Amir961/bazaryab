import 'dart:io';

import 'package:fare/features/language/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

import 'core/components/inherited/tablet_checker/app_provider.dart';
import 'core/layouts/dismiss_keyboard_layout.dart';
import 'core/layouts/language_widget_builder.dart';
import 'core/services/router.dart';
import 'core/utils/assets.dart';
import 'core/utils/values.dart';
import 'features/language/presentation/bloc/app_language_bloc.dart';
import 'features/theme/presentation/bloc/app_theme_bloc.dart';
import 'features/theme/presentation/widget/theme_widget_builder.dart';
import 'injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  runApp(
    MultiBlocProvider(
      providers: [


        BlocProvider<AppLanguageBloc>(
          create: (context) => sl<AppLanguageBloc>(),
        ),
        BlocProvider<AppThemeBloc>(
          create: (context) => sl<AppThemeBloc>(),
        ),



      ],
      child: DismissKeyboardLayout(
        child: LanguageWidgetBuilder(builder: (languageState) {
          String languageCode = languageState.language.language;
          debugPrint('languageCode: $languageCode ');
          return
            ThemeWidgetBuilder(
              builder: (themeState) {
                return ToastificationWrapper(
                  child: MaterialApp.router(

                    title: 'بازاریاب',
                    // key: globalNavigatorKey,
                    // locale: Locale(languageCode),
                    locale:  Locale(languageCode),
                    localizationsDelegates:  const [
                      LocaleNamesLocalizationsDelegate(),
                      ...AppLocalizations.localizationsDelegates
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,

                    localeResolutionCallback: (locale, supportedLocales) {
                      // final defaultLanguage = languageState.language;
                      //  final defaultLanguage = 'fa';
                      debugPrint('defaultLanguage: $languageCode : ${themeState.theme.theme}');

                      Intl.defaultLocale = languageCode;
                      return Locale(languageCode);
                    },
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      // fontFamily: AppProvider.of(context).getFontFamily,
                      fontFamily:
                     // languageState.language.language == 'fa' ?
                           Fonts.iranSans
                          //: Fonts.poppins
                      ,
                      brightness: Brightness.light,
                      primaryColor: MyColors.primaryColor,
                      dividerColor: MyColors.dividerColor,
                      focusColor: MyColors.primaryColor,
                      hintColor: MyColors.hintTextColor,
                      // errorColor: MyColors.errorColor,
                      dialogBackgroundColor: MyColors.backgroundColor,
                      cardColor: MyColors.cardColor,
                      shadowColor: MyColors.shadowColor,
                      disabledColor: MyColors.disableColor,
                      scaffoldBackgroundColor: MyColors.backgroundColor,
                      indicatorColor: MyColors.progressBackgroundColor,
                      colorScheme: ColorScheme.fromSwatch(
                        accentColor: MyColors.accentColor,
                        backgroundColor: MyColors.backgroundColor,
                        brightness: Brightness.light,
                        cardColor: MyColors.surfaceColor,
                        errorColor: MyColors.errorColor,
                      ),
                      cardTheme: const CardTheme(
                        shadowColor: MyColors.cardShadowColor,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: MyColors.accentColor,
                        selectionHandleColor: MyColors.accentColor,
                        selectionColor: MyColors.accentColor.withOpacity(0.4),
                      ),
                      textTheme: const TextTheme(
                        bodyLarge: TextStyle(
                          color: MyColors.textColor,
                        ),
                        bodyMedium: TextStyle(
                          color: MyColors.textColor2,
                        ),
                        titleLarge: TextStyle(
                          color: MyColors.subtitle1Color,
                        ),
                        titleMedium: TextStyle(color: MyColors.subtitleColor2),
                        headlineLarge: TextStyle(
                          color: MyColors.burndCaloriesColor,
                        ),
                        headlineMedium: TextStyle(
                          color: MyColors.progressLevelColor,
                        ),
                        headlineSmall: TextStyle(
                          color: MyColors.weightChangeColor,
                        ),
                      ),
                    ),
                    // darkTheme: ThemeData(
                    //   fontFamily: languageState.language.language == 'fa'
                    //       ? Fonts.iranSans
                    //       : Fonts.poppins,
                    //
                    //   //  AppProvider.of(context).getFontFamily,
                    //   brightness: Brightness.dark,
                    //   cardTheme: const CardTheme(
                    //     shadowColor: MyColors.darkCardShadowColor,
                    //   ),
                    //   indicatorColor: MyColors.darkProgressBackgroundColor,
                    //   scaffoldBackgroundColor: MyColors.darkBackgroundColor,
                    //   primaryColor: MyColors.darkPrimaryColor,
                    //   dividerColor: MyColors.darkDividerColor,
                    //   focusColor: MyColors.darkPrimaryColor,
                    //   hintColor: MyColors.darkHintTextColor,
                    //   // errorColor: MyColors.errorColor,
                    //   disabledColor: MyColors.darkDisableColor,
                    //   dialogBackgroundColor: MyColors.darkBackgroundColor,
                    //   cardColor: MyColors.darkCardColor,
                    //   shadowColor: MyColors.darkShadowColor,
                    //   colorScheme: ColorScheme.fromSwatch(
                    //     accentColor: MyColors.accentColor,
                    //     backgroundColor: MyColors.darkBackgroundColor,
                    //     brightness: Brightness.dark,
                    //     cardColor: MyColors.darkSurfaceColor,
                    //     errorColor: MyColors.errorColor,
                    //   ),
                    //   textSelectionTheme: TextSelectionThemeData(
                    //     cursorColor: MyColors.accentColor,
                    //     selectionHandleColor: MyColors.accentColor,
                    //     selectionColor: MyColors.accentColor.withOpacity(0.4),
                    //   ),
                    //   textTheme: const TextTheme(
                    //     bodyLarge: TextStyle(
                    //       color: MyColors.darkTextColor,
                    //     ),
                    //     bodyMedium: TextStyle(color: MyColors.darkTextColor2),
                    //     titleLarge: TextStyle(
                    //       color: MyColors.darkSubtitle1Color,
                    //     ),
                    //     titleMedium: TextStyle(color: MyColors.darkSubtitleColor2),
                    //     headlineLarge: TextStyle(
                    //       color: MyColors.darkBurndCaloriesColor,
                    //     ),
                    //     headlineMedium: TextStyle(
                    //       color: MyColors.darkProgressLevelColor,
                    //     ),
                    //     headlineSmall: TextStyle(
                    //       color: MyColors.darkWeightChangeColor,
                    //     ),
                    //   ),
                    // ),


                    builder: (context, child) {
                      final MediaQueryData data = MediaQuery.of(context);
                      return MediaQuery(
                        data: data.copyWith(
                          textScaleFactor: 1.1,
                          boldText: false,
                        ),
                        child: AppProvider(
                          child: AnnotatedRegion<SystemUiOverlayStyle>(
                            value: Theme.of(context).brightness == Brightness.light
                                ? SystemUiOverlayStyle.dark.copyWith(
                              statusBarColor: Colors.transparent,
                            )
                                : SystemUiOverlayStyle.light.copyWith(
                              statusBarColor:
                              const Color(0xFF00000a).withOpacity(.5),
                            ),
                            child: child!,
                          ),
                        ),
                      );
                    },
                    routerConfig: router,

                  ),
                );
              }
            );
        }),
      ),
    ),
  );
}


