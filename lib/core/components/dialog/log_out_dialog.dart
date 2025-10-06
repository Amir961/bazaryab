
  import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../features/auth/bloc/auth_bloc.dart';
import '../../../features/language/utils/strings.dart';
import '../../../injection_container.dart';
import '../../utils/assets.dart';
import '../../utils/enum.dart';
import '../../utils/values.dart';
import '../button/button_widget.dart';

import '../text/text.dart';
import 'dialog_manager.dart';

class LogOutDialog extends StatelessWidget {
  final String description;
  final String? yesLabel;
  final String? noLabel;
  final Function() yesClick;
  final Function()? noClick;
  const LogOutDialog({super.key,required this.description,required this.noClick,required this.noLabel,required this.yesClick,required this.yesLabel});

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Widget get _body => Material(
    color: Colors.transparent,
    child: Builder(
      builder: (context) => Blur(
        blurColor: MyColors.darkCardColor.withOpacity(0.4),
        overlay: Center(
          child: Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: 24,
            ),
            padding: const EdgeInsets.only(
              bottom: 16,
              top: 8,
              left: 4,
              right: 4,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),


                _descriptionView,

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ButtonWidget(

                        onClick: () {
                          if( noClick==null)
                          {
                            Navigator.of(context).pop();
                          }
                          else
                          {
                            noClick!.call();
                          }
                        },
                        loading: false,
                        text:noLabel?? Strings.of(context)
                            .no_label,
                        width: 100,
                        height: 35,
                      ),
                      const SizedBox(width: 10,),

                      _button
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    ),
  );


  Widget get _button => BlocConsumer<AuthBloc,AuthState>(
      listenWhen: (previous, current) => previous.statusLogOut != current.statusLogOut,


      listener: (context,state){

        if(state.statusLogOut == StatusButton.success)
        {
          // toastification.show(
          //     type: ToastificationType.success,
          //     style: ToastificationStyle.minimal,
          //     backgroundColor: Colors.grey[100],
          //     //overlayState: globalNavigatorKey.currentState?.overlay,
          //     autoCloseDuration: const Duration(seconds: 3),
          //     title: MyText(text:Strings.of(context).success_label,color: Colors.black87,fontWeight: FontWeight.bold,),
          //     description: MyText(text:,color: Colors.black87,)
          // );

          yesClick.call();

        }

        else if(state.statusLogOut== StatusButton.noInternet)
        {
          sl<DialogManager>().showNoNetDialog(
            context: context,
            onTryAgainClick: () {

              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());


            },
          );
        }

        else if(state.statusLogOut == StatusButton.failed)
        {
          debugPrint('error_is: statusLogin');
          toastification.show(
              type: ToastificationType.error,
              style: ToastificationStyle.minimal,
              backgroundColor: Colors.grey[100],
              //overlayState: globalNavigatorKey.currentState?.overlay,
              autoCloseDuration: const Duration(seconds: 3),
              title: MyText(text:Strings.of(context).failed_label,color: Colors.black87,fontWeight: FontWeight.bold,),
              description: MyText(text:'اشکالی پیش آمده دوباره تلاش کنید',color: Colors.black87,)
          );

        }


      },
      buildWhen: (previous, current) =>previous.statusLogOut != current.statusLogOut,
      builder: (context,state) {
        return

          ButtonWidget(


            onClick: () {
              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
            },
            loading: state.statusLogOut== StatusButton.loading,
            text: yesLabel?? Strings.of(context)
                .yes_label,
            width: 100,
            height: 35,
          );
      }
  );


  Widget get _descriptionView => Builder(
    builder: (context) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 24,
        end: 16,
        bottom: 16,
      ),
      child:



      MyText(
        text: description,
        fontSize: 15,
        textAlign: TextAlign.start,
        fontWeight: Fonts.bold,
      ),
    ),
  );
}
