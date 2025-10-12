

import 'dart:async';


import 'package:fare/core/components/loading/loading_widget.dart';
import 'package:fare/features/customer/bloc/update_customer_bloc.dart';
import 'package:fare/features/customer/models/city_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/language/utils/strings.dart';
import '../../../injection_container.dart';
import '../../utils/assets.dart';

import '../../utils/enum.dart';
import '../../utils/values.dart';
import '../button/button_widget.dart';
import '../dialog/dialog_manager.dart';
import '../inherited/tablet_checker/app_provider.dart';
import '../input/input.dart';
import '../text/text.dart';


class ListCityUpdateWidget extends StatefulWidget {


  final BuildContext context;
  final int id;

  const ListCityUpdateWidget({super.key,required this.context,required this.id});

  @override
  State<ListCityUpdateWidget> createState() => _ListCityUpdateWidgetState();
}



class _ListCityUpdateWidgetState extends State<ListCityUpdateWidget> {

  double get inputWidth => MediaQuery.of(context).size.width * 0.8;
  double get marginWidth => MediaQuery.of(context).size.width * 0.1;

  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final FocusNode _focusNode= FocusNode();



  List<City> tempList=[];
  List<City> originList=[];
  City? selectCity;





  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _focusNode.dispose();


    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  start()async
  {
    await Future.delayed(Duration.zero);

    BlocProvider.of<UpdateCustomerBloc>(widget.context).add(GetCityEvent(widget.id));
    _focusNode.requestFocus();
  }

  clearTextField()
  {
    _nameTextEditingController.clear();
    _nameTextEditingController.text='';
    tempList= originList;
    setState(() {

    });
  }

  _search(String value){
    tempList= originList.where((item)=> item.title!.contains(value)).toList();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return


      SafeArea(
        child: BlocProvider.value(
        value: BlocProvider.of<UpdateCustomerBloc>(widget.context),
        child:
        SizedBox.expand(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: MyColors.primaryColor,
                child: Stack(
                  children: [
                    Positioned(
                        top:20,
                        left: 15,
                        child: InkWell(
                          onTap: (){

                            context.pop();
                          },
                          child: RotatedBox(
                              quarterTurns: 90,
                              child: Icon(Icons.play_arrow_rounded,color: Colors.white,size: 32,)),
                        )),
                    Positioned(
                        top:80,
                        right: 20,
                        child: MyText(text: "تعیین شهرستان",fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 120),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: MyColors.backgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(90))
                ),
                child: Column(

                  children: [
                    SizedBox(height: 20,),
                    MyText(text: 'شهرستان مورد نظر را انتخاب کنید'),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,),
                      child: TextField(
                        controller: _nameTextEditingController,
                        onChanged: (String value){
                          _search(value);
                        },
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: AppProvider.of(context).getFontFamily,
                          fontSize: 14,

                        ),
                        decoration: InputDecoration(
                          filled: true, // پس‌زمینه رو فعال می‌کنه
                          fillColor: Colors.grey[350], // رنگ پس‌زمینه
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Icon(
                              Icons.close,
                              //color: Theme.of(context).hintColor,
                            ),
                            onTap: () => clearTextField(),
                          ),

                          isDense: true,
                          hintText: 'جستجوی شهر',
                          counterText: '',
                          contentPadding: EdgeInsetsDirectional.only(
                            start: 10,
                            end:  0,
                            top: 10,
                            bottom: 10,
                          ),
                          hintStyle: TextStyle(
                             color: Colors.grey[400],
                            // fontFamily: AppProvider.of(context).getFontFamily,
                            // fontSize: widget.hintFontSize,
                            // fontWeight: widget.fontWeight ?? Fonts.light,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[350]!,
                                width: 0,
                              ),

                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[350]!,
                              width: 0,
                            ),

                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignLabelWithHint: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[350]!,
                              width: 0,
                            ),

                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _listView,
                    )),
                    ButtonWidget(

                    // isEnable: true,
                    isEnable: true,


                    onClick: () {



                      context.pop(selectCity);



                    },
                    loading: false,
                    text: 'تایید',
                    width: inputWidth,
                    height: 45,
                  ),
                    SizedBox(height: 20,)

                  ],
                )

              ),
            ],
          ),
        ),


            ),
      );



  }


  Widget get _listView => BlocConsumer<UpdateCustomerBloc,UpdateCustomerState>(

      listener: (context,state){

        if(state.statusButtonGetCity== StatusButton.noInternet)
        {
          sl<DialogManager>().showNoNetDialog(
            context: context,
            onTryAgainClick: () {

              BlocProvider.of<UpdateCustomerBloc>(widget.context).add(GetCityEvent(widget.id));


            },
          );
        }

       else if(state.statusButtonGetCity== StatusButton.success)
        {

          originList=BlocProvider.of<UpdateCustomerBloc>(widget.context).state.listCity;
          tempList=List.from(BlocProvider.of<UpdateCustomerBloc>(widget.context).state.listCity);

        }
       else if(state.statusButtonGetCity== StatusButton.failed)
        {
          sl<DialogManager>().showErrorDialog(
            context: context,
            onTryAgainClick: () {

              BlocProvider.of<UpdateCustomerBloc>(widget.context).add(GetCityEvent(widget.id));


            }, message: state.message,
          );
        }
      },
      buildWhen: (previous, current) => previous.statusButtonGetCity != current.statusButtonGetCity,
      builder: (context,state){

    return state.statusButtonGetCity==StatusButton.loading? Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [

          LoadingWidget(progressColor:MyColors.primaryColor),
         SizedBox(height: 10,),
         MyText(text: Strings.of(context).searching_label,fontWeight: FontWeight.bold,)
      ],
    ),): state.statusButtonGetCity==StatusButton.success && tempList.isEmpty? Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [


        MyText(text: Strings.of(context).no_items_found_label,fontWeight: FontWeight.bold,fontSize: 18,)
      ],
    ),):

    ListView.separated(
        itemCount: tempList.length,
        shrinkWrap: true,
      //  physics: ,
        itemBuilder: (context,index){
      return InkWell(
        onTap: (){
          setState(() {
            selectCity=tempList[index];
          });

          //Navigator.of(context).pop();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2,vertical: 3),
          child: Row(
            children: [

              SizedBox(width: 10,),
              MyText(text:tempList[index].title!,fontWeight: FontWeight.bold,color: tempList[index].id==selectCity?.id?Colors.blueAccent:Colors.grey[700],)
            ],
          ),
        ),
      );
    }, separatorBuilder: (BuildContext context, int index) {
          return Divider();
    },);
  });

}
