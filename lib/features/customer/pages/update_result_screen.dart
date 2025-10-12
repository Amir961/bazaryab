
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fare/features/customer/bloc/update_result_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

import '../../../core/components/button/button_widget.dart';
import '../../../core/components/dialog/dialog_manager.dart';
import '../../../core/components/input/input.dart';
import '../../../core/components/text/text.dart';
import '../../../core/layouts/my_scaffold.dart';
import '../../../core/res/constant.dart';
import '../../../core/res/media_res.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/values.dart';
import '../../../injection_container.dart';
import '../../language/utils/strings.dart';
import '../../splash/presentation/bloc/splash_bloc.dart';
import '../../splash/presentation/models/common_setting.dart';

class UpdateResultScreen extends StatefulWidget {
  static const routeName = '/update-result-screen';
  const UpdateResultScreen({super.key});

  @override
  State<UpdateResultScreen> createState() => _UpdateResultScreenState();
}

class _UpdateResultScreenState extends State<UpdateResultScreen> {
  final TextEditingController _descriptionTextEditingController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(




      title: 'بروز رسانی نتیجه', child: Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding,right: horizontalPadding,
        top: 20,

      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _selectDate,
            SizedBox(height: 10,),
            _result,
            _description,
            SizedBox(height: 40,),
            _buttonUpdateResult
          ],
        ),
      ),
    ),

    );
  }

  Widget get _description =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'توضیحات',),
          ),
          Input(

            width: double.infinity,
            controller: _descriptionTextEditingController,




            maxLines: 5,
            onChange: (value) {

              BlocProvider.of<UpdateResultBloc>(context).add(ChangeDescription(value:value));
            },


            // textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.text,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _result =>
      BlocBuilder<UpdateResultBloc, UpdateResultState>(
          buildWhen: (previous, current) =>  previous.result != current.result ,

          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: MyText(text: 'نتیجه مراجعه',),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),

                  child:
                  DropdownButtonHideUnderline(

                    child: DropdownButton2<UserType>(

                      isExpanded: true,

                      hint:  Row(
                        children: [

                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: MyText(
                              text: 'انتخاب کنید',

                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.grey,

                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      items: BlocProvider.of<SplashBloc>(context).state.dataApp?.customerStatus!
                          .map((UserType item) => DropdownMenuItem<UserType>(
                        value: item,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            MyText(
                              text: item.title??'',

                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,

                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ))
                          .toList(),
                      value: state.result,
                      onChanged:(value) {


                        BlocProvider.of<UpdateResultBloc>(context).add(ChangeResult(value: value!));


                      },
                      buttonStyleData: ButtonStyleData(
                        height: heightInput,
                        width: inputWidth,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey[700]!,
                              width: 1.7
                          ),
                          color: Colors.white,
                        ),
                        elevation: 0,
                      ),
                      iconStyleData: IconStyleData(
                        icon:  Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(MediaRes.chev),
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.grey[800],
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,


                        width: inputWidth-38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        offset: const Offset(0, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData:  MenuItemStyleData(
                        height: heightInput,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),


                    ),
                  ),
                ),

              ],
            );
          });

  Widget get _selectDate =>
      BlocBuilder<UpdateResultBloc, UpdateResultState>(
          buildWhen: (previous, current) =>   previous.visitDate != current.visitDate ,

          builder: (context, state) {
            return
              InkWell(
                onTap: () async {
                  final String? selectDate= await   sl<DialogManager>().showSelectedDateSheet(
                    context: context,




                  );

                  if(selectDate!=null)
                  {
                    BlocProvider.of<UpdateResultBloc>(context).add(ChangeVisitDate(value:selectDate));

                  }

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0,top: 10),
                      child: MyText(text: 'تاریخ مراجعه',),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        width: inputWidth,
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:  BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey[700]!,width: 1.5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyText(text: state.visitDate==null? '----/--/--' :state.visitDate!,color: state.visitDate==null?Colors.grey:Colors.black,),
                            ),
                            SvgPicture.asset(MediaRes.calender),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              );
          });


  Widget get _buttonUpdateResult =>

      BlocConsumer<UpdateResultBloc,UpdateResultState>(
          listenWhen: (previous, current) =>  previous.statusButton != current.statusButton ,
          listener: (context,state){

            if(state.statusButton == StatusButton.success)
            {

              // BlocProvider.of<AddCustomerBloc>(context).add(ChangeTypePage(value: PageAddCustomer.completeInfo));


            }

            else if(state.statusButton== StatusButton.noInternet)
            {
              sl<DialogManager>().showNoNetDialog(
                context: context,
                onTryAgainClick: () {

                  BlocProvider.of<UpdateResultBloc>(context).add(UpdateResult());
                },
              );
            }

            else if(state.statusButton == StatusButton.failed)
            {
              debugPrint('error_is: statusAdd');
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

          buildWhen: (previous, current) =>
          previous.statusButton != current.statusButton ,

          builder: (context,state) { return Column(
            children: [
              SizedBox(height: 20,),
              ButtonWidget(

                 isEnable: true,


                onClick: () {

                  BlocProvider.of<UpdateResultBloc>(context).add(UpdateResult());

                },
                loading: state.statusButton == StatusButton.loading,
                text: 'ثبت نتیجه',
                width: inputWidth,
                height: 45,
              ),
              SizedBox(height: 10,),

            ],
          );
          }
      );


  double get heightInput => 50;
  double get inputWidth => MediaQuery.of(context).size.width -(10);
}
