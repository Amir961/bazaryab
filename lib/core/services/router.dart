

import 'package:fare/features/customer/bloc/list_customer_bloc.dart';
import 'package:fare/features/customer/pages/my_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/pages/login_screen.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/home/pages/home_screen.dart';
import '../../features/message/bloc/messages_bloc.dart';
import '../../features/message/pages/messages_screen.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../injection_container.dart';
import '../../main.dart';


final GoRouter router = GoRouter (
    navigatorKey: navigatorKey,
    initialLocation: SplashScreen.routeName,
  routes: <RouteBase>[


    GoRoute(
      path: SplashScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return  MultiBlocProvider(
          key: const ValueKey(3),
          providers: [

            BlocProvider<SplashBloc>(
              create: (context) => sl<SplashBloc>(),
            ),

          ],
          child: const SplashScreen(),
        );



      },
    ),

    GoRoute(
      path: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return  MultiBlocProvider(
          key: const ValueKey(3),
          providers: [

            BlocProvider<HomeBloc>(
              create: (context) => sl<HomeBloc>(),
            ),

          ],
          child: const HomeScreen(),
        );



      },
    ),



    GoRoute(
      path: LoginScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return  MultiBlocProvider(
          key: const ValueKey(3),
          providers: [

            BlocProvider<AuthBloc>(
              create: (context) => sl<AuthBloc>(),
            ),

          ],
          child: const LoginScreen(),
        );



      },
    ),

    GoRoute(
      path: MyCustomerScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
           return  BlocProvider.value(
          value: sl<ListCustomerBloc>(),
          child: MyCustomerScreen(),
        );





      },
    ),

    GoRoute(
      path: MessagesScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return  BlocProvider.value(
          value: sl<MessagesBloc>(),
          child: MessagesScreen(),
        );





      },
    ),







  ]);