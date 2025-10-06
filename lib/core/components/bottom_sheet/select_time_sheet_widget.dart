

import 'package:fare/core/components/button/border_button_widget.dart';
import 'package:fare/core/components/calender/persian_calender/src/utils/jalali_extension.dart';
import 'package:fare/core/components/text/text.dart';
import 'package:fare/core/utils/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shamsi_date/shamsi_date.dart';
import 'package:toastification/toastification.dart';

import '../../../features/language/utils/strings.dart';


import '../button/button_widget.dart';
import '../button/feedback_button.dart';

import '../calender/persian_wheel_date_picker_widget.dart';

import '../selector/int_selector.dart';

class SelectTimeSheetWidget extends StatefulWidget {
  final BuildContext context;
  const SelectTimeSheetWidget({required this.context,super.key});

  @override
  State<SelectTimeSheetWidget> createState() => _SelectTimeSheetWidgetState();
}

class _SelectTimeSheetWidgetState extends State<SelectTimeSheetWidget> {

  int selectedState=0;
  int selectedHour=12;
  int selectedMinute=2;
  Jalali? selectedJalali = Jalali.now();

  final List<String> hourList = ['00','01','02','03','04','05','06','07','08','09','10','11',
    '12','13','14','15','16','17','18','19','20','21','22','23',

  ];

  final List<String> minutesList = ['00','15','30','45',
  ];



  final FocusNode _focusNode= FocusNode();


  // double get inputWidth => MediaQuery.of(context).size.width * 0.8;
  // double get margin => MediaQuery.of(context).size.width * 0.15;
  double get inputWidth => MediaQuery.of(context).size.width -36;
  double get margin => 18;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: selectedState==0 ?_state0:
      selectedState==1 ?_state1:

      SizedBox(),
    );




  }




  Widget  get  _state1 =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: 'انتخاب ساعت مراجعه',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400]
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),


              ],
            ),
          ),



          Padding(
            padding:  EdgeInsets.symmetric(horizontal:margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                MyText(text: 'لطفا ساعت مراجعه خود را اعلام کنید.',fontWeight: FontWeight.w600,color: Colors.grey,),
                SizedBox(height: 7,),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [

                    Flexible(child:  IntSelectorWidget<String>(
                      isNotFromAuthPage: false,
                      titleMarginBottom: 0,
                      initialItem: 2,
                      onSelectedItemChange: (index) {

                        setState(() {
                          selectedMinute=index;
                        });



                      },
                      selectedItem: minutesList[selectedMinute],
                      items: minutesList,
                      title: "دقیقه",
                      fontSize: 21,
                      itemWidth: _itemWidth,
                      itemHeight: _itemHeight,
                      isWeight: true,
                    ),),
                    Flexible(child:  IntSelectorWidget<String>(
                      isNotFromAuthPage: true,
                      titleMarginBottom: 0,
                      initialItem: 12,
                      onSelectedItemChange: (index) {

                        setState(() {
                          selectedHour=index;
                        });
                      },
                      selectedItem: hourList[selectedHour],
                      items: hourList,
                      title: "ساعت",
                      fontSize: 21,
                      itemWidth: _itemWidth,
                      itemHeight: _itemHeight,
                      isWeight: false,
                    ),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [

                    _buttonReturn,
                    SizedBox(width: 10,),
                    _buttonConfirmAndC,
                  ],
                )
              ],
            ),
          ),




          const SizedBox(height: 20),
        ],
      );


  Widget  get  _state0 =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: 'انتخاب روز مراجعه',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[400]
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),


              ],
            ),
          ),



          Padding(
            padding:  EdgeInsets.symmetric(horizontal:margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                MyText(text: 'تاریخ مراجعه',fontWeight: FontWeight.w600,color: Colors.grey,),
                SizedBox(height: 7,),
                selectedJalali==null ? SizedBox(
                  height: 220,
                ):

                PersianWheelDatePickerWidget(
                 // lastDate: state.detailsSalonModels?.loadingToDate?.toJalali(),
                 // firstDate: state.detailsSalonModels?.loadingFromDate?.toJalali(),
                  initialDate: selectedJalali!, changeDate: (Jalali value ) {

                  debugPrint('date_selected_is:${value.toShortShow()}');

                  selectedJalali=value;
                },),

                // PersianCalendar(
                //
                //   isSelectedBefore: false,
                //   initialDate: selectedJalali,
                //    endingDate: state.detailsSalonModels?.loadingToDate?.toJalali(),
                //  //  startingDate: selectedJalali,
                //    startingDate: state.detailsSalonModels?.loadingFromDate?.toJalali(),
                //   confirmButton:  SizedBox(),
                //   onDateChanged: (value) {
                //     selectedJalali=value;
                //   },
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.ltr,
                  children: [
                    _buttonConfirmAndC,
                    InkWell(
                        onTap: ()async{
                          setState(() {
                            selectedJalali=null;
                          });
                          await Future.delayed(Duration(milliseconds: 5));
                          debugPrint('date_is__:${selectedJalali?.toShortShow()}');

                          setState(() {
                            selectedJalali=Jalali.now();
                          });

                        },
                        child: MyText(text: 'برو به امروز',color: MyColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 16,))
                  ],
                )
              ],
            ),
          ),




          const SizedBox(height: 20),
        ],
      );








  
  
  Widget get _buttonConfirmAndC =>



      FeedbackButtonWidget(

        onClick: () async{

          if(selectedState==0)
          {

            if(selectedJalali!.distanceTo(Jalali.now())>0)
            {
              toastification.show(
                  type: ToastificationType.error,
                  style: ToastificationStyle.minimal,
                  backgroundColor: Colors.grey[100],
                  //overlayState: globalNavigatorKey.currentState?.overlay,
                  autoCloseDuration: const Duration(seconds: 3),
                  title: MyText(text:Strings.of(context).failed_label,color: Colors.black87,fontWeight: FontWeight.bold,),
                  description: MyText(text:'تاریخ های گذشته را نمی توانید انتخاب کنید',color: Colors.black87,)
              );
              return;
            }






          }



          if(selectedState==0) {
            setState(() {
              selectedState += 1;
            });
          }
          else
            {
              context.pop('$selectedHour:$selectedMinute ${selectedJalali!.toShortShow()}');
            }
        },

        width: 150,

        height: 45,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(text: '${selectedState==0?'تایید و ادامه':'تایید'}',color: Colors.white),
            SizedBox(width: 0,),
            Icon(Icons.chevron_right_outlined,color: Colors.white,size: 32,),
          ],
        ),
      );

  Widget get _buttonReturn =>   BorderButtonWidget(

    onClick: () async{

      selectedState-=1;


      setState(() {

      });
    },

    width: 150,

    height: 45,

    loading: false,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(width: 0,),
        Icon(Icons.chevron_left_outlined,color: MyColors.primaryColor,size: 32,),
        MyText(text: 'بازگشت',color: MyColors.primaryColor),
      ],
    ),
  );

  double get _itemWidth => 80;

  double get _itemHeight => 46;
}
