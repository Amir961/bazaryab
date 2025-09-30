
import 'package:fare/core/components/text/text.dart';
import 'package:fare/core/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../core/components/button/button_widget.dart';
import '../../../core/components/dialog/dialog_manager.dart';
import '../../../core/components/input/input.dart';
import '../../../core/res/constant.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/enum.dart';
import '../../../injection_container.dart';
import '../../home/pages/home_screen.dart';
import '../../language/utils/strings.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final TextEditingController _userTextEditingController =
  TextEditingController();

  final TextEditingController _passwordTextEditingController =
  TextEditingController();

  final FocusNode _userNameFocusNode= FocusNode();
  final FocusNode _passwordFocusNode= FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: MyColors.primaryColor,
        child: Column(
          children: [
            Expanded(flex: 3,child: Container(
              alignment: Alignment.bottomRight,
              
              child: Padding(
                padding: const EdgeInsets.only(right: 18,bottom: 20),
                child: MyText(text: 'ورود به حساب کاربری',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),
              ),
            )),
            Expanded(flex: 7,child: Container(

              width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                color: MyColors.backgroundColor
              ),

              child: SingleChildScrollView(
                child: Column(


                  children: [
                    // تصویر با قوس رو به بالا


                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 70,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: MyText(text: 'نام کاربری',fontWeight: FontWeight.bold,),
                          ),

                          Input(
                            width: double.infinity,
                            controller: _userTextEditingController,

                             focusNode: _userNameFocusNode,
                            nextFocusNode: _passwordFocusNode,

                            maxLines: 1,
                            onChange: (value) {

                              BlocProvider.of<AuthBloc>(context).add(ChangeUserNameEvent(value));
                            },


                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,

                            textColor: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: Fonts.medium,
                            borderColor: MyColors.hintTextColor,
                            hintFontSize: 11,


                          ),

                          SizedBox(height: 10,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: MyText(text: 'رمز عبور',fontWeight: FontWeight.bold,),
                          ),

                          Input(
                            width: double.infinity,
                            controller: _passwordTextEditingController,

                            focusNode: _passwordFocusNode,


                            maxLines: 1,
                            onChange: (value) {

                              BlocProvider.of<AuthBloc>(context).add(ChangePasswordEvent(value));
                            },


                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,

                            textColor: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: Fonts.medium,
                            borderColor: MyColors.hintTextColor,
                            hintFontSize: 11,
                            isPassword: true,


                          ),

                          SizedBox(height: 50,),


                          Center(child: _button),
                          SizedBox(height: 7,),

                        ],
                      ),
                    ),





                  ],
                ),
              )

            ))
          ],
        ),
      ),
    );
  }

  Widget get _button => BlocConsumer<AuthBloc,AuthState>(
      listenWhen: (previous, current) => previous.statusButton != current.statusButton,


      listener: (context,state) {

        if(state.statusButton == StatusButton.success)
        {

          context.go(HomeScreen.routeName);

        }

        else if(state.statusButton== StatusButton.noInternet)
        {
          sl<DialogManager>().showNoNetDialog(
            context: context,
            onTryAgainClick: () {

              BlocProvider.of<AuthBloc>(context).add(LoginEvent());
            },
          );
        }

        else if(state.statusButton == StatusButton.failed)
        {
          debugPrint('error_is: statusLogin');
          toastification.show(
              type: ToastificationType.error,
              style: ToastificationStyle.minimal,
              backgroundColor: Colors.grey[100],
              //overlayState: globalNavigatorKey.currentState?.overlay,
              autoCloseDuration: const Duration(seconds: 3),
              title: MyText(text:Strings.of(context).failed_label,color: Colors.black87,fontWeight: FontWeight.bold,),
              description: MyText(text:state.message,color: Colors.black87,)
          );

        }


      },
      buildWhen: (previous, current) =>  previous.statusButton != current.statusButton || previous.password != current.password || previous.userName != current.userName ,
      builder: (context,state) {
        debugPrint('statusLogin: ${state.statusButton.name}');
        return

          ButtonWidget(

           // isEnable: true,
            isEnable: state.password.isNotEmpty && state.userName.length>2,


            onClick: () {



              BlocProvider.of<AuthBloc>(context).add(LoginEvent());



            },
            loading: state.statusButton==StatusButton.loading,
            text: 'ورود',
            width: MediaQuery.of(context).size.width-(2*horizontalPadding),
            height: 45,
          );
      }
  );
}
