import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:fare/core/components/text/text.dart';
import 'package:fare/core/res/constant.dart';
import 'package:fare/core/res/media_res.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:fare/features/customer/bloc/add_customer_bloc.dart';
import 'package:fare/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:fare/features/splash/presentation/models/common_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_filex/open_filex.dart';
import 'package:toastification/toastification.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/button/button_widget.dart';
import '../../../core/components/dialog/dialog_manager.dart';
import '../../../core/components/input/input.dart';
import '../../../core/components/loading/loading_widget.dart';
import '../../../core/layouts/my_scaffold.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/values.dart';
import '../../../injection_container.dart';
import '../../language/utils/strings.dart';
class AddCustomerScreen extends StatefulWidget {
  static const routeName = '/add-customer-screen';
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {


  final TextEditingController _nameSetTextEditingController =
  TextEditingController();

  final TextEditingController _nameOwnerSetTextEditingController =
  TextEditingController();

  final TextEditingController _identityTextEditingController =
  TextEditingController();

  final TextEditingController _phoneTextEditingController =
  TextEditingController();


  final TextEditingController _nameResponsibleTextEditingController =
  TextEditingController();

  final TextEditingController _phoneResponsibleTextEditingController =
  TextEditingController();

  final TextEditingController _codeTextEditingController =
  TextEditingController();

  final TextEditingController _descriptionTextEditingController =
  TextEditingController();


  final FocusNode _nameFocusNode= FocusNode();
  final FocusNode _nameOwnerFocusNode= FocusNode();
  final FocusNode _identityFocusNode= FocusNode();
  final FocusNode _phoneFocusNode= FocusNode();


  final FocusNode _nameResponsibleFocusNode= FocusNode();
  final FocusNode _phoneResponsibleFocusNode= FocusNode();
  final FocusNode _codeFocusNode= FocusNode();


  LatLng? currentLocation;
  final mapController = MapController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      // حالا نقشه رندر شده
      setData();

    });
  }


  setData() async{

    final bloc = BlocProvider.of<AddCustomerBloc>(context);
    await getLocation();

    bloc.add(ChangeTypePage(value: PageAddCustomer.initInfo));



  }

  getLocation() async
  {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.requestPermission();
    if (!serviceEnabled || permission == LocationPermission.denied) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    currentLocation = LatLng(position.latitude, position.longitude);


  }




  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backFunction: () {
        final bloc = BlocProvider.of<AddCustomerBloc>(context);
        if (bloc.state.pageAddCustomer == PageAddCustomer.completeInfo) {
          bloc.add(ChangeTypePage(value: PageAddCustomer.initInfo));
        } else {
          context.pop(); // برگشت پیش‌فرض
        }
      }
      ,



      title: 'ثبت مشتری جدید', child: Padding(
        padding: EdgeInsets.only(
        left: horizontalPadding,right: horizontalPadding,
        top: 20,

    ),
      child: BlocBuilder<AddCustomerBloc,AddCustomerState>(
          buildWhen: (previous, current) =>  previous.pageAddCustomer != current.pageAddCustomer ,
          builder: (context,state){

          return   state.pageAddCustomer==PageAddCustomer.loading? LoadingWidget(progressColor: MyColors.primaryColor,):

            state.pageAddCustomer==PageAddCustomer.initInfo?
                _page1
                : _page2;


      }),
    ),

    );
  }

  Widget get _page2 => SingleChildScrollView(
    child: Column(
      children: [
        _code,
        Padding(
          padding: const EdgeInsets.only(top: 14.0,bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(text: 'موقعیت مکانی مجموعه',fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black,),
              SizedBox()
            ],
          ),
        ),
        _state,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(color: Colors.grey,),
        ),
        _city,
        SizedBox(height: 12,),
        _map,
        _selectDate,
        SizedBox(height: 10,),
        _result,
        _description,
        SizedBox(height: 10,),
        _selectFile,
        SizedBox(height: 10,),
        _buttonAdd



      ],
    ),
  );

  Widget get _selectFile =>
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
          buildWhen: (previous, current) =>  previous.file != current.file ,

          builder: (context, state) {
            return  SizedBox(
              height: 150,
              child: state.file==null?
              InkWell(
                onTap: ()async{
                  // FilePickerResult? result = await FilePicker.platform.pickFiles(
                  //   allowMultiple: false,
                  //   type: FileType.any,
                  //   allowedExtensions: ['jpg', 'pdf', 'png'],
                  // );

                  final result = await sl<DialogManager>().showSelectImageSheet(context: context,);


                  if (result != null) {
                    File file = File(result.path);
                    BlocProvider.of<AddCustomerBloc>(context).add(ChangeFile(value:file));


                  } else {
                    // User canceled the picker
                  }
                },
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions (
                      dashPattern: [2, 2],
                      strokeWidth: 1,

                      color: Colors.black,
                      radius: Radius.circular(10)

                  ),


                  // RectDottedBorderOptions(
                  //   dashPattern: [2, 2],
                  //   strokeWidth: 1,
                  //   color: Colors.black
                  //
                  // ),
                  child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                         // color: MyColors.backGroundColor
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SvgPicture.asset(MediaRes.upload),
                            SizedBox(height: 10,),
                            MyText(text: 'حداکثر حجم 2 مگابایت',fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
                            SizedBox(height: 20,),
                            MyText(text: '  فرمت های قابل قبول jpg, jpeg, png ',),

                          ],
                        ),
                      )



                  ),
                ),
              )
                  :
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.backgroundColor
                      ),
                      child:Image.file(state.file!)),
                  Container(

                    height: 150,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(MediaRes.backImage),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      //  color: Colors.black.withAlpha(90),
                    ),
                    child:SvgPicture.asset(MediaRes.backImage,fit: BoxFit.cover,),
                  ),
                  Positioned(
                    right:10,
                    bottom:10,
                    child: InkWell(
                      onTap:(){

                        BlocProvider.of<AddCustomerBloc>(context).add(ChangeFile(value:null));

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle
                        ),
                        child:Icon(Icons.delete,color: Colors.white,),
                      ),
                    ),),
                  Center(child: InkWell(

                    onTap: () {

                      OpenFilex.open(state.file!.path);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(MediaRes.eye),
                    ),
                  ),)
                ],
              ),
            );

          });

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

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeDescription(value:value));
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
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
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


                        BlocProvider.of<AddCustomerBloc>(context).add(ChangeResult(value: value!));


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
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
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
                    BlocProvider.of<AddCustomerBloc>(context).add(ChangeVisitDate(value:selectDate));

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




  Widget get _map=>
      Stack(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: 200,
              child:
              //currentLocation==null ? LoadingWidget():

              FlutterMap(
                mapController: mapController,
                options: currentLocation!=null? MapOptions(
                  initialCenter: currentLocation!,
                  initialZoom: 7,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,) // غیرفعال کردن زوم و درگ
                ):MapOptions(),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'ir.rahko.fare',
                  ),
                  MarkerLayer(
                    markers: [



                      if(currentLocation!=null)
                        Marker(
                          point: currentLocation!,
                          width: 40,
                          height: 40,
                          child: SvgPicture.asset(MediaRes.location)
                        ),
                    ],
                  ),

                ],
              ),
            ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  debugPrint('selected_state_is0: ');
                  final location = await sl<DialogManager>().showSelectLocationSheet(
                    Ex: context,
                    loc: currentLocation!,
                  );

                  debugPrint('selected_state_is: ${location?.longitude}');
                  if (location != null) {
                    currentLocation=location;
                    BlocProvider.of<AddCustomerBloc>(context)
                        .add(ChangeLocation(loc: location));
                    mapController.move(location, 16);

                    setState(() {

                    });
                  }
                },
              ),
            ),
          ),
        ],
      );

  Widget get _code =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'کد ارسال شده به مسئول هماهنگی',),
          ),
          Input(

            width: double.infinity,
            controller: _codeTextEditingController,

            focusNode: _codeFocusNode,


            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeResponsibleCode(value:value));
            },


            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _city =>
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
          buildWhen: (previous, current) =>  previous.selectedCity != current.selectedCity || previous.selectedState != current.selectedState ,

          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                MyText(text: 'شهرستان',fontWeight: FontWeight.bold,fontSize: 16,),
                InkWell(
                    onTap: () async{
                      if(state.selectedState==null)
                        {
                          return;
                        }

                      final city= await sl<DialogManager>().showListCitySheet(Ex: context, id:(state.selectedState?.id??0).toInt() );
                      debugPrint('selected_state_is: ${city?.title}');
                      if(city!=null)
                      {
                        BlocProvider.of<AddCustomerBloc>(context).add(ChangeSelectedCity(value:city));

                      }

                    },
                    child: MyText(text: state.selectedCity?.title??'انتخاب کنید',fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey[600],)),

              ],
            );
          });

  Widget get _state =>
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
          buildWhen: (previous, current) =>  previous.selectedState != current.selectedState ,

          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                MyText(text: 'استان',fontWeight: FontWeight.bold,fontSize: 16,),
                InkWell(
                    onTap: () async{

                     final state= await sl<DialogManager>().showListStateSheet(Ex: context);
                     debugPrint('selected_state_is: ${state?.title}');
                     if(state!=null)
                       {
                         BlocProvider.of<AddCustomerBloc>(context).add(ChangeSelectedState(value:state));
                         BlocProvider.of<AddCustomerBloc>(context).add(ChangeSelectedCity(value:null));

                       }

                    },
                    child: MyText(text: state.selectedState?.title??'انتخاب کنید',fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey[600],)),

              ],
            );
          });


  Widget get _page1 => SingleChildScrollView(
    child: Column(
      children: [
        _typeBussiness,
    
        _kindBussiness,
        _nameSet,
        _nameOwnerSet,
        _identitySet,
        _phone,
        _responsiblePosition,
        _nameResponsible,
        _phoneResponsible,
        _button
    
    
      ],
    ),
  );

  Widget get _phoneResponsible =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'شماره همراه مسئول',),
          ),
          Input(

            width: double.infinity,
            controller: _phoneResponsibleTextEditingController,

            focusNode: _phoneResponsibleFocusNode,


            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeResponsiblePhoneNumber(value:value));
            },


            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _nameResponsible =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'نام و نام خانوادگی مسئول',),
          ),
          Input(

            width: double.infinity,
            controller: _nameResponsibleTextEditingController,

            focusNode: _nameResponsibleFocusNode,
             nextFocusNode: _phoneResponsibleFocusNode,

            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeResponsibleName(value:value));
            },


            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _responsiblePosition =>
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
          buildWhen: (previous, current) =>  previous.responsiblePosition != current.responsiblePosition ,

          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0,top: 10),
                  child: MyText(text: 'سمت مسئول',),
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

                      items: BlocProvider.of<SplashBloc>(context).state.dataApp?.position!
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
                      value: state.responsiblePosition,
                      onChanged:(value) {


                        BlocProvider.of<AddCustomerBloc>(context).add(ChangeResponsiblePosition(value: value!));


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

  Widget get _phone =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'تلفن ثابت مجموعه',),
          ),
          Input(

            width: double.infinity,
            controller: _phoneTextEditingController,

            focusNode: _phoneFocusNode,
           // nextFocusNode: _phoneFocusNode,

            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangePhoneNumberSet(value:value));
            },


            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _identitySet =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'شناسه / شماره ملی',),
          ),
          Input(

            width: double.infinity,
            controller: _identityTextEditingController,

            focusNode: _identityFocusNode,
            nextFocusNode: _phoneFocusNode,

            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeNameIdentity(value:value));
            },


            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _nameOwnerSet =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'نام و نام خانوادگی مالک مجموعه',),
          ),
          Input(

            width: double.infinity,
            controller: _nameOwnerSetTextEditingController,

            focusNode: _nameOwnerFocusNode,
            nextFocusNode: _identityFocusNode,

            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeNameOwnerSet(value:value));
            },


            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _nameSet =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0,top: 10),
            child: MyText(text: 'نام مجموعه',),
          ),
          Input(

            width: double.infinity,
            controller: _nameSetTextEditingController,

            focusNode: _nameFocusNode,
            nextFocusNode: _nameOwnerFocusNode,

            maxLines: 1,
            onChange: (value) {

              BlocProvider.of<AddCustomerBloc>(context).add(ChangeNameSet(value:value));
            },


            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,

            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: Fonts.medium,
            borderColor: MyColors.hintTextColor,
            hintFontSize: 11,


          ),

        ],
      );

  Widget get _kindBussiness =>
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
          buildWhen: (previous, current) =>  previous.kindBussiness != current.kindBussiness ,

          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0,top: 10),
                  child: MyText(text: 'نوع کسب و کار',),
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

                      items: BlocProvider.of<SplashBloc>(context).state.dataApp?.industry!
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
                      value: state.kindBussiness,
                      onChanged:(value) {


                        BlocProvider.of<AddCustomerBloc>(context).add(ChangeKindBussiness(value: value!));


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

  Widget get _typeBussiness =>
      BlocBuilder<AddCustomerBloc, AddCustomerState>(
          buildWhen: (previous, current) =>  previous.typeBussiness != current.typeBussiness ,

          builder: (context, state) {
        return Column(
           crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MyText(text: 'شخصیت کسب و کار',),
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

                  items: BlocProvider.of<SplashBloc>(context).state.dataApp?.userType!
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
                  value: state.typeBussiness,
                  onChanged:(value) {


                    BlocProvider.of<AddCustomerBloc>(context).add(ChangeTypeBussiness(value: value!));


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


  Widget get _button =>
      
      BlocConsumer<AddCustomerBloc,AddCustomerState>(
        listenWhen: (previous, current) =>  previous.statusButtonOtp != current.statusButtonOtp ,
      listener: (context,state){

        if(state.statusButtonOtp == StatusButton.success)
        {

          BlocProvider.of<AddCustomerBloc>(context).add(ChangeTypePage(value: PageAddCustomer.completeInfo));


        }

        else if(state.statusButtonOtp== StatusButton.noInternet)
        {
          sl<DialogManager>().showNoNetDialog(
            context: context,
            onTryAgainClick: () {

              BlocProvider.of<AddCustomerBloc>(context).add(GetOtp());
            },
          );
        }

        else if(state.statusButtonOtp == StatusButton.failed)
        {
          debugPrint('error_is: statusotp');
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
      previous.statusButtonOtp != current.statusButtonOtp ||
      previous.nameSet != current.nameSet ||
          previous.typeBussiness != current.typeBussiness ||
          previous.kindBussiness != current.kindBussiness ||
          previous.phoneNumberSet != current.phoneNumberSet ||
          previous.nameOwnerSet != current.nameOwnerSet ||
          previous.identity != current.identity ||
          previous.responsiblePosition != current.responsiblePosition ||
          previous.responsibleName != current.responsibleName ||
          previous.responsiblePhoneNumber != current.responsiblePhoneNumber
          ,
      builder: (context,state) {

        debugPrint('data_is: ${state.nameSet}- ${state.phoneNumberSet}- ${state.nameOwnerSet}- ${state.identity} - ${state.responsibleName} - ${state.responsiblePhoneNumber}');

        return

          Column(
            children: [
              SizedBox(height: 20,),
              ButtonWidget(
              
                // isEnable: true,
                isEnable: state.nameSet.isNotEmpty &&
                           state.phoneNumberSet.isNotEmpty &&
                           state.nameOwnerSet.isNotEmpty &&
                           state.identity.isNotEmpty &&
                           state.responsibleName.isNotEmpty &&
                           state.typeBussiness!=null&&
                           state.kindBussiness!=null&&
                           state.responsiblePosition!=null&&
                           state.responsiblePhoneNumber.length==11 ,

                onClick: () {

                  BlocProvider.of<AddCustomerBloc>(context).add(GetOtp());

                },
                loading: state.statusButtonOtp == StatusButton.loading,
                text: 'ثبت و ادامه',
                width: inputWidth,
                height: 45,
              ),
              SizedBox(height: 10,),
               Visibility(
                   visible:
                   !(state.nameSet.isNotEmpty &&
                       state.phoneNumberSet.isNotEmpty &&
                       state.nameOwnerSet.isNotEmpty &&
                       state.identity.isNotEmpty &&
                       state.typeBussiness!=null&&
                       state.kindBussiness!=null&&
                       state.responsiblePosition!=null&&
                       state.responsibleName.isNotEmpty &&
                       state.responsiblePhoneNumber.length==11 ),
                   child: MyText(text: 'لطفا همه مقادیر را کامل کنید',color: Colors.red,)),
              SizedBox(height: 20,),
            ],
          );
      }
  );


  Widget get _buttonAdd =>

      BlocConsumer<AddCustomerBloc,AddCustomerState>(
          listenWhen: (previous, current) =>  previous.statusButtonAdd != current.statusButtonAdd ,
          listener: (context,state) async{

            if(state.statusButtonAdd == StatusButton.success)
            {

             // BlocProvider.of<AddCustomerBloc>(context).add(ChangeTypePage(value: PageAddCustomer.completeInfo));

              toastification.show(
                  type: ToastificationType.success,
                  style: ToastificationStyle.minimal,
                  backgroundColor: Colors.grey[100],
                  //overlayState: globalNavigatorKey.currentState?.overlay,
                  autoCloseDuration: const Duration(seconds: 3),
                  title: MyText(text:'موفق',color: Colors.black87,fontWeight: FontWeight.bold,),
                  description: MyText(text:'مشتری شما با موفقیت اضافه شد',color: Colors.black87,)
              );
              await Future.delayed(Duration(seconds: 1));

              context.pop();

            }

            else if(state.statusButtonAdd== StatusButton.noInternet)
            {
              sl<DialogManager>().showNoNetDialog(
                context: context,
                onTryAgainClick: () {

                  BlocProvider.of<AddCustomerBloc>(context).add(AddCustomer());
                },
              );
            }

            else if(state.statusButtonAdd == StatusButton.failed)
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
          previous.statusButtonAdd != current.statusButtonAdd ||
              previous.responsibleCode != current.responsibleCode ||
              previous.selectedState != current.selectedState ||
              previous.selectedCity != current.selectedCity ||
              previous.phoneNumberSet != current.phoneNumberSet ||
              previous.visitDate != current.visitDate ||
              previous.result != current.result ||
              previous.loc != current.loc ||
              previous.description != current.description ||
              previous.file != current.file,
          builder: (context,state) { return Column(
                children: [
                  SizedBox(height: 20,),
                  ButtonWidget(

                    // isEnable: true,
                    isEnable: state.responsibleCode.isNotEmpty &&
                        state.description.isNotEmpty &&
                        state.visitDate !=null &&


                        state.selectedCity!=null&&
                        state.selectedState!=null&&
                        state.loc!=null&&
                        state.result!=null&&
                        state.file!=null ,

                    onClick: () {

                      BlocProvider.of<AddCustomerBloc>(context).add(AddCustomer());

                    },
                    loading: state.statusButtonAdd == StatusButton.loading,
                    text: 'ثبت نهایی',
                    width: inputWidth,
                    height: 45,
                  ),
                  SizedBox(height: 10,),
                  Visibility(
                      visible:
                      !(state.responsibleCode.isNotEmpty &&
                          state.description.isNotEmpty &&
                          state.visitDate !=null &&


                          state.selectedCity!=null&&
                          state.selectedState!=null&&
                          state.loc!=null&&
                          state.result!=null&&
                          state.file!=null ),
                      child: MyText(text: 'لطفا همه مقادیر را کامل کنید',color: Colors.red,)),
                  SizedBox(height: 20,),
                ],
              );
          }
      );

  double get heightInput => 50;
  double get inputWidth => MediaQuery.of(context).size.width -(10);
}
