
import 'package:fare/core/components/bottom_sheet/bottom_sheet_select_location_widget.dart';
import 'package:fare/core/components/dialog/show_error_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../features/customer/models/city_model.dart';
import '../bottom_sheet/bottom_sheet_list_city_widget.dart';
import '../bottom_sheet/bottom_sheet_list_state_widget.dart';
import '../bottom_sheet/select_image_sheet_widget.dart';
import '../bottom_sheet/select_time_sheet_widget.dart';
import 'log_out_dialog.dart';
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

  Future<void> showLogOutDialog({
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

  Future<void> showErrorDialog({
    required BuildContext context,
    required String? message,
    required Function() onTryAgainClick,
  });

  Future<City?> showListStateSheet({
    required BuildContext Ex,


  });
  Future<City?> showListCitySheet({

    required int id,
    required BuildContext Ex,


  });

  Future<LatLng?> showSelectLocationSheet({

    required LatLng loc,
    required BuildContext Ex,


  });

  Future<String?> showSelectedDateSheet({required BuildContext context,
  });

  Future<XFile?> showSelectImageSheet({required BuildContext context,
  });



}

class DialogManagerImpl implements DialogManager {

  static bool _isShowYesNoDialog = false;
  static bool _isShowLogOut = false;
  static bool _isShowOkDialog = false;
  static bool _isShowAddSkillDialog = false;
  static bool _isShowNetworkDialog = false;
  static bool _isShowErrorDialog = false;
  static bool _isShowListStateSheet = false;
  static bool _isShowListCitySheet = false;
  static bool _isShowSelectLocationSheet = false;
  static bool _isShowSelectDateSheet = false;
  static bool _showSelectImageSheet = false;


  @override
  Future<XFile?> showSelectImageSheet({required BuildContext context}) async {

    if (_showSelectImageSheet) return null;
    _showSelectImageSheet = true;
    final result = await showModalBottomSheet<XFile>(
      backgroundColor: Theme
          .of(context)
          .cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: MediaQuery
              .of(sheetContext)
              .viewInsets,

          child: SelectImageSheetWidget(bottomSheetContext: sheetContext,),
        );
      },
    );
    _showSelectImageSheet = false;
    return result;


    // if (_showSelectImageSheet) return null;
    // _showSelectImageSheet = true;
    // final result = await showModalBottomSheet<XFile>(
    //   backgroundColor: Theme
    //       .of(context)
    //       .cardColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) {
    //     return Padding(
    //       padding: MediaQuery
    //           .of(context)
    //           .viewInsets,
    //
    //       child: SelectImageSheetWidget(),
    //     );
    //   },
    // );
    // _showSelectImageSheet = false;
    // return result ?? null;
  }



  @override
  Future<String?> showSelectedDateSheet({required BuildContext context}) async {
    if (_isShowSelectDateSheet) return null;
    _isShowSelectDateSheet = true;
    final result=  await showModalBottomSheet<String?>(
      backgroundColor: Theme
          .of(context)
          .cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery
              .of(context)
              .viewInsets,

          child: SelectTimeSheetWidget(context: context,),
        );
      },
    );
    _isShowSelectDateSheet = false;
    return result;

  }


  @override
  Future<City?> showListCitySheet({required BuildContext Ex,required int id }) async {
    if (_isShowListCitySheet) return null;
    _isShowListCitySheet = true;
  final City? city=  await showModalBottomSheet<City?>(
      backgroundColor: Theme.of(Ex).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: Ex,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,

          child:  ListCityWidget(context: Ex,id: id, ),
        );
      },
    );
    _isShowListCitySheet = false;
    return city;
  }


  @override
  Future<LatLng?> showSelectLocationSheet({required BuildContext Ex,required LatLng loc }) async {
    if (_isShowSelectLocationSheet) return null;
    _isShowSelectLocationSheet = true;
  final LatLng? location=  await showModalBottomSheet<LatLng?>(
      backgroundColor: Theme.of(Ex).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      context: Ex,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,

          child:  SelectLocationWidget(context: Ex,loc: loc, ),
        );
      },
    );
    _isShowSelectLocationSheet = false;
    return location;
  }

  @override
  Future<City?> showListStateSheet({required BuildContext Ex, }) async {
    if (_isShowListStateSheet) return null;
    _isShowListStateSheet = true;
    final City? city=  await showModalBottomSheet<City?>(
      backgroundColor: Theme.of(Ex).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      context: Ex,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,

          child:  ListStateWidget(context: Ex, ),
        );
      },
    );
    _isShowListStateSheet = false;
    return city;
  }



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
  Future<void> showLogOutDialog({required BuildContext context, required String description, String? yesLabel, String? noLabel, required Function() yesClick,  Function()? noClick}) async{
    {
      if (_isShowLogOut) return;
      _isShowLogOut = true;
      await showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (context) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: LogOutDialog(
                yesClick: yesClick,
                noClick: noClick,
                yesLabel: yesLabel,
                noLabel: noLabel,
                description: description),
          );
        },
      );
      _isShowLogOut = false;
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


  @override
  Future<void> showErrorDialog({
    required String? message,
    required BuildContext context,
    required Function() onTryAgainClick,
  }) async {
    if (_isShowErrorDialog) return;
    _isShowErrorDialog = true;
    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: ShowErrorDialogWidget(onTryAgainClick: onTryAgainClick,message: message ,),
        );
      },
    );
    _isShowErrorDialog = false;
  }










}