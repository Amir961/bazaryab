

import 'dart:async';

import 'package:fare/core/utils/values.dart';
import 'package:fare/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/dialog/dialog_manager.dart';
import '../../../../core/res/media_res.dart';
import '../../../../injection_container.dart';
import '../../../auth/pages/login_screen.dart';
import '../../../home/pages/home_screen.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUpdateAndGoToOtherPage();
  }

  void checkUpdateAndGoToOtherPage() async {




   await Future.delayed(const Duration(seconds: 1));

    goToMain();
  }

  goToMain(){

    BlocProvider.of<SplashBloc>(context).add(GetDataEvent());

    //context.pushReplacement( LoginScreen.routeName);
 //  context.pushReplacement( '/home-screen',

   // context.pushReplacement( AddDashboardScreen.routeName

  //  );
   // BlocProvider<HomeBloc>(
   //   create: (context) => sl<HomeBloc>(),
   // ),
   // Navigator.push(
   //   context,
   //   MaterialPageRoute(
   //     builder: (context) {
   //       return BlocProvider(
   //         create: (_) => sl<HomeBloc>(),
   //         child: const HomeScreen(session: null),
   //       );
   //     },
   //   ),
   // );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc,SplashState>(
        listener: (BuildContext context, SplashState state) {
          if(state is GoToLogin)
            {
              context.go(LoginScreen.routeName);
            }
          else if(state is GoToMain)
            {
              context.go(HomeScreen.routeName);
            }
          else if(state is NoNetWork)
          {
            sl<DialogManager>().showNoNetDialog(
              context: context,
              onTryAgainClick: () {

                BlocProvider.of<SplashBloc>(context).add(GetDataEvent());
              },
            );
          }
          else if(state is ErrorNetwork)
          {
            sl<DialogManager>().showErrorDialog(
              context: context,
              onTryAgainClick: () {

                BlocProvider.of<SplashBloc>(context).add(GetDataEvent());
              }, message: state.message,
            );
          }
        },

           child: Container(
            color: MyColors.primaryColor,
            width: double.infinity,
            height: double.infinity,
           padding: EdgeInsets.symmetric(horizontal: 20),
           // color: Colors.blueGrey,
            child: Center(
              child: Image.asset(MediaRes.logo),
            ),
          ),

      ),
    );
  }
}


