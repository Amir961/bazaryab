
import 'package:fare/core/res/constant.dart';
import 'package:fare/core/res/media_res.dart';
import 'package:fare/features/customer/bloc/update_result_bloc.dart';
import 'package:fare/features/customer/pages/update_customer_screen.dart';
import 'package:fare/features/customer/pages/update_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../core/components/button/button_widget.dart';
import '../../../core/components/dialog/dialog_manager.dart';
import '../../../core/components/empty_list/empty.dart';
import '../../../core/components/empty_list/error_in_get_list.dart';
import '../../../core/components/loading/loading_widget.dart';
import '../../../core/components/text/text.dart';
import '../../../core/layouts/my_scaffold.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/values.dart';
import '../../../injection_container.dart';
import '../../language/utils/strings.dart';
import '../bloc/list_customer_bloc.dart';
import '../models/customer.dart';

class MyCustomerScreen extends StatefulWidget {
  static const routeName = '/my-customer-screen';
  const MyCustomerScreen({super.key});

  @override
  State<MyCustomerScreen> createState() => _MyCustomerScreenState();
}

class _MyCustomerScreenState extends State<MyCustomerScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async
  {
    await Future.delayed(Duration.zero);

    BlocProvider.of<ListCustomerBloc>(context).add(GetDataEvent());

  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(title: 'مشتری های من', child:
    Padding(padding: EdgeInsets.only(
      left: horizontalPaddingList,right: horizontalPaddingList,
      top: 20,
      bottom: horizontalPaddingList,
    ),child: _list ,),);
  }

  Widget get _list =>

      BlocConsumer<ListCustomerBloc,ListCustomerState>(
          listenWhen: (previous, current) =>  previous.statusButton != current.statusButton ,
          listener: (context,state){

            if(state.statusButton== StatusButton.noInternet)
            {
              sl<DialogManager>().showNoNetDialog(
                context: context,
                onTryAgainClick: () {

                  BlocProvider.of<ListCustomerBloc>(context).add(GetDataEvent());
                },
              );
            }

            else if(state.statusButton == StatusButton.failed)
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
          previous.statusButton != current.statusButton  ,
          builder: (context,state){

            if(state.statusButton==StatusButton.loading)
            {
              return Center(child: LoadingWidget(progressColor: MyColors.accentColor,),);
            }

            if(state.statusButton==StatusButton.failed)
            {
              return ErrorInGetList(
                text: null,
                updateData:

                InkWell(
                  onTap: (){
                    getData();
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Icon(Icons.update_rounded,size: 42,color: Colors.grey[600],)),
                ),
              );
            }


            else if(state.statusButton==StatusButton.success)
            {
              // return EmptyWidget();
              return

                RefreshIndicator(
                  onRefresh: () async{
                    getData();
                  },
                  child: state.listCustomer.isEmpty?
                  EmptyWidget(updateData:

                  InkWell(
                    onTap: (){
                      getData();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Icon(Icons.update_rounded,size: 42,color: Colors.grey[600],)),
                  ),
                  ):


                  ListView.builder(
                     // itemCount: 3,
                      itemCount: state.listCustomer.length,
                      itemBuilder: (context,index) {
                        return myContainer(state.listCustomer[index],  );
                      }
                  ),
                );
            }
            else
              return SizedBox();



          });


  Widget myContainer(Customer customer){
    return  Container(
      width: double.infinity,

       padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
       margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(90),topRight: Radius.circular(8),bottomRight: Radius.circular(8),bottomLeft: Radius.circular(0)),
          border: Border.all(color: Colors.grey[400]??Colors.grey,width: 0.7)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(text: 'مجموعه غذایی مینو',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16,),
              InkWell(
                onTap: ()async{

                  final result= await   context.push(UpdateCustomerScreen.routeName,extra: customer);
                  if(result !=null && result as bool)
                  {
                    getData();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: SvgPicture.asset(MediaRes.edit),
                ),
              ),
            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              SvgPicture.asset(MediaRes.map),
              SizedBox(width: 5,),
              MyText(text: customer.address??'',fontWeight: FontWeight.bold,color: MyColors.primaryColor,fontSize: 14),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'آخرین مراجعه:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: customer.visit??'',fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'مالک مجموعه:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: customer.ownerName??'',fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'مسئول هماهنگی:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: customer.inChargeName??'',fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'شماره همراه مسئول:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: customer.inChargeMobile??'',fontWeight: FontWeight.w400,color: MyColors.primaryColor,fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'تلفن ثابت مجموعه:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: customer.phone??'',fontWeight: FontWeight.w400,color: MyColors.primaryColor,fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'نتیجه مراجعه:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: customer.result??'',fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13),

            ],
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(

                  children: [
                    TextSpan(
                      text: 'توضیحات: ',
                      style: TextStyle(
                        fontFamily: Fonts.iranSans,

                          fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14
                      ),
                    ),
                    TextSpan(
                      text: customer.description,
                      style: TextStyle(
                        fontFamily: Fonts.iranSans,
                        fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ButtonWidget(

              // isEnable: true,
              isEnable: true ,

              onClick: ()  async{

               final result= await   context.push(UpdateResultScreen.routeName,extra: customer);
               if(result !=null && result as bool)
                 {
                   getData();
                 }

              },
              loading:false,
              text: 'بروز رسانی نتیجه',
              fontSize: 14,
              width: 170,
              height: 42,
            ),
          ),

        ],


      ),
    );
  }

}
