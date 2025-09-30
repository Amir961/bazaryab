
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'no_network_error_dialog_widget.dart';
import 'ok_dialog.dart';
import 'yes_no_dialog.dart';

abstract class DialogManager {
  Future<void> showAddSkillDialog({
    required BuildContext myContext,
    required Function() submit,
  });


  Future<void> showNoNetDialog({
    required BuildContext context,
    required Function() onTryAgainClick,
  });
















  Future<void> showYesNoDialog({
    required BuildContext context,
    required Function() yesClick,
  required String description,
   String? yesLabel,
   String? noLabel,
    Function()? noClick,


  });

  Future<void> showOkDialog({
    required BuildContext context,
  required String description,
   String? okLabel,
    Function()? okClick,


  });


}

class DialogManagerImpl implements DialogManager {

  static bool _isShowYesNoDialog = false;
  static bool _isShowOkDialog = false;
  static bool _isShowAddSkillDialog = false;
  static bool _isShowNetworkDialog = false;


  @override
  Future<void> showNoNetDialog({
    required BuildContext context,
    required Function() onTryAgainClick,
  }) async {
    if (_isShowNetworkDialog) return;
    _isShowNetworkDialog = true;
    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: NoNetworkDialogWidget(onTryAgainClick: onTryAgainClick),
        );
      },
    );
    _isShowNetworkDialog = false;
  }







  @override
  Future<void> showAddSkillDialog({required BuildContext myContext, required Function() submit}) async {
    if (_isShowAddSkillDialog) return;
    _isShowAddSkillDialog = true;
    await showModalBottomSheet(
      backgroundColor: Theme.of(myContext).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: myContext,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,

          child: Container(),
         // child: AddSkillWidget(submit: submit, context: myContext,),
        );
      },
    );
    _isShowAddSkillDialog = false;
  }



  @override
  Future<void> showYesNoDialog({required BuildContext context, required String description, String? yesLabel, String? noLabel, required Function() yesClick,  Function()? noClick}) async{
    {
      if (_isShowYesNoDialog) return;
      _isShowYesNoDialog = true;
      await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (context) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: YesNoDialog(
                yesClick: yesClick,
                noClick: noClick,
                yesLabel: yesLabel,
                noLabel: noLabel,
                description: description),
          );
        },
      );
      _isShowYesNoDialog = false;
    }
  }

  @override
  Future<void> showOkDialog({required BuildContext context, required String description, String? okLabel, Function()? okClick}) async{
    {
      if (_isShowOkDialog) return;
      _isShowOkDialog = true;
      await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (context) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: OkDialog(
                okClick: okClick,

                okLabel: okLabel,
                description: description),
          );
        },
      );
      _isShowOkDialog = false;
    }}











}