
import 'package:fare/core/res/constant.dart';
import 'package:fare/features/message/bloc/messages_bloc.dart';
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
import '../../../core/res/media_res.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/values.dart';
import '../../../injection_container.dart';
import '../../customer/pages/update_customer_screen.dart';
import '../../customer/pages/update_result_screen.dart';
import '../../language/utils/strings.dart';

class MessagesScreen extends StatefulWidget {
  static const routeName = '/message-screen';
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async
  {
    await Future.delayed(Duration.zero);

    BlocProvider.of<MessagesBloc>(context).add(GetDataEvent());

  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(title: 'نوتیفیکیشن ها', child:
    Padding(padding: EdgeInsets.only(
      left: horizontalPaddingList,right: horizontalPaddingList,
      top: 20,
      bottom: horizontalPaddingList,
    ),child: _list ,),);
  }

  Widget get _list =>

      BlocConsumer<MessagesBloc,MessagesState>(
          listenWhen: (previous, current) =>  previous.statusButton != current.statusButton ,
          listener: (context,state){

            if(state.statusButton== StatusButton.noInternet)
            {
              sl<DialogManager>().showNoNetDialog(
                context: context,
                onTryAgainClick: () {

                  BlocProvider.of<MessagesBloc>(context).add(GetDataEvent());
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
                  child: state.listMessage.isNotEmpty?
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
                      itemCount: 3,
                      //itemCount: state.listCustomer.length,
                      itemBuilder: (context,index) {
                        return myContainer(state.listMessage,  );
                      }
                  ),
                );
            }
            else
              return SizedBox();



          });


  Widget myContainer(customer){
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(text: 'مجموعه غذایی مینو',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16,),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              SvgPicture.asset(MediaRes.map),
              SizedBox(width: 5,),
              MyText(text: 'مجموعه غذایی مینو',fontWeight: FontWeight.bold,color: MyColors.primaryColor,fontSize: 14),

            ],
          ),


          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'مسئول هماهنگی:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: 'محسن احمدی',fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'شماره همراه مسئول:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: '09125486851',fontWeight: FontWeight.w400,color: MyColors.primaryColor,fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'تلفن ثابت مجموعه:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: '0313365487',fontWeight: FontWeight.w400,color: MyColors.primaryColor,fontSize: 13),

            ],
          ),
          SizedBox(height: 1,),
          Row(

            children: [
              MyText(text: 'نتیجه مراجعه:',fontWeight: FontWeight.w500,color: Colors.black87,fontSize: 14),

              SizedBox(width: 5,),
              MyText(text: 'مراجعه مجدد',fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13),

            ],
          ),
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
                  text: 'این یک متن آزمایش است.این یک متن آزمایش است.این یک متن آزمایش است.این یک متن آزمایش است.این یک متن آزمایش است. ',
                  style: TextStyle(
                      fontFamily: Fonts.iranSans,
                      fontWeight: FontWeight.w400,color: Colors.grey[600],fontSize: 13
                  ),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ButtonWidget(

              // isEnable: true,
              isEnable: true ,

              onClick: () {

                context.push(UpdateResultScreen.routeName);

              },
              loading:false,
              text: 'انجام شد',
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
