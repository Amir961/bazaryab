

import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/components/dialog/dialog_manager.dart';
import 'core/network/api_service.dart';
import 'core/network/network_info.dart';
import 'core/network/sharedPref_service.dart';
import 'core/utils/language_helper.dart';
import 'core/utils/theme_helper.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/customer/bloc/list_customer_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/language/data/data_sources/language_data_source.dart';
import 'features/language/data/repository/language_repository_impl.dart';
import 'features/language/domain/repository/language_repository.dart';
import 'features/language/domain/use_cases/get_language.dart';
import 'features/language/domain/use_cases/set_language.dart';
import 'features/language/presentation/bloc/app_language_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/message/bloc/messages_bloc.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'features/theme/data/data_sources/theme_data_source.darttheme_data_source.dart';
import 'features/theme/data/repository/theme_repository_impl.dart';
import 'features/theme/domain/repository/theme_repository.dart';
import 'features/theme/domain/use_cases/get_app_theme.dart';
import 'features/theme/domain/use_cases/set_app_theme.dart';
import 'features/theme/presentation/bloc/app_theme_bloc.dart';



final sl = GetIt.instance;
//inja
// final analytics = FirebaseAnalytics.instance;

Future<void> init() async {

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => http.Client());



  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(checker: sl()));
  sl.registerLazySingleton(() => SharedPrefService(sl()));
  sl.registerLazySingleton(() => ApiService(sl(), sl(),sl()));


 //
   sl.registerLazySingleton<DialogManager>(() => DialogManagerImpl());

  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(
    dataSource: sl(),
  ));
  // Data Sources
  sl.registerLazySingleton<ThemeDataSource>(() => ThemeDataSourceImpl(
    localStorage: sl(),
  ));
 //
  sl.registerLazySingleton(() => GetAppTheme(repository: sl()));
  sl.registerLazySingleton(() => SetAppTheme(repository: sl()));
  sl.registerLazySingleton<ThemeHelper>(() => ThemeHelperImpl());
 //
  sl.registerLazySingleton(() => GetLanguage(repository: sl()));
  sl.registerLazySingleton(() => SetLanguage(repository: sl()));

  // Repository
  sl.registerLazySingleton<LanguageRepository>(() => LanguageRepositoryImpl(
    dataSource: sl(),
  ));
  // Data Sources
  sl.registerLazySingleton<LanguageDataSource>(() => LanguageDataSourceImpl(
    sharedPreferences: sl(),
  ));

  sl.registerLazySingleton<LanguageHelper>(() => LanguageHelperImpl());
 //

   sl.registerLazySingleton(() => AppLanguageBloc(getLanguage: sl(), helper: sl(), setLanguage: sl()));
  sl.registerLazySingleton(() => AppThemeBloc(getAppTheme: sl(), setAppTheme: sl(), helper: sl()));
  sl.registerLazySingleton(() => AuthBloc( sl(),sl()));
  sl.registerLazySingleton(() => SplashBloc( sl(),));
  sl.registerLazySingleton(() => HomeBloc( sl(),sl()));
  sl.registerLazySingleton(() => ListCustomerBloc( sl()));
  sl.registerLazySingleton(() => MessagesBloc( sl()));




}