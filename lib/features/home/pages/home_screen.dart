

import 'package:fare/core/components/text/text.dart';
import 'package:fare/core/res/constant.dart';
import 'package:fare/core/res/media_res.dart';
import 'package:fare/core/utils/values.dart';
import 'package:fare/features/customer/pages/my_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/components/dialog/dialog_manager.dart';
import '../../../core/utils/enum.dart';
import '../../../injection_container.dart';
import '../../language/utils/strings.dart';
import '../../message/pages/messages_screen.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final widthSqaur= MediaQuery.of(context).size.width-(2*horizontalPadding)/(5/9);

    return Scaffold(

      key: _scaffoldKey,
      endDrawer:

      ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50),   // گوشه بالا راست
          bottomRight: Radius.circular(50),// گوشه پایین راست
        ),
        child: Drawer(
          child: _menuBar


        ),
      ),

      body: SafeArea(child: Container(
        height: double.infinity,
        width: double.infinity,
        color: MyColors.backgroundColor,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65),bottomRight: Radius.circular(65))
              ),
              child: Column(

                children: [
                  SizedBox(height: 70,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      alarm,
                    Image.asset(MediaRes.mainLogo),
                    //CircleAvatar(),
                      IconButton(
                        icon: const Icon(Icons.menu, size: 32,color: Colors.white,),
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                      )

                  ],),
                  SizedBox(height: 20,),
                  _switch,
                  // Row(
                  //   children: [
                  //
                  //
                  //     SizedBox(width: 10,),
                  //     MyText(text: '',)
                  //   ],
                  // )
                ],
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(


                children: [
                  SizedBox(height: 100,),
                  Stack(
                    children: [
                      SizedBox(

                        height: 60,width: MediaQuery.of(context).size.width-(2*horizontalPadding),),
                      Positioned(
                       top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          alignment: Alignment.centerRight,
                          height: 55,
                          width: widthSqaur-20,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: SvgPicture.asset(MediaRes.addUser),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,

                        child: Container(
                          height: 55,
                          width: widthSqaur-10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'ثبت مشتری جدید',fontWeight: FontWeight.bold,color: MyColors.primaryColor,fontSize: 17,),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 35 ,),
                  InkWell(
                    onTap: (){
                      context.push(MyCustomerScreen.routeName);
                    },
                    child: Stack(
                      children: [
                        SizedBox(

                          height: 60,width: MediaQuery.of(context).size.width-(2*horizontalPadding),),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            height: 55,
                            width: widthSqaur-20,
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: SvgPicture.asset(MediaRes.allUser),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,

                          child: Container(
                            height: 55,
                            width: widthSqaur-10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  offset: const Offset(0, 3),
                                  blurRadius: 6,
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: MyText(
                                textAlign: TextAlign.center,
                                text: 'مشتری های من',fontWeight: FontWeight.bold,color: MyColors.primaryColor,fontSize: 17,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],


              ),
            ))
          ],
        ),
      )),
    );
  }

  Widget get alarm => InkWell(
    onTap: ()async {
      context.push(MessagesScreen.routeName);





    },
    child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white54,
        shape: BoxShape.circle
      ),
      child: SizedBox(
        height: 20,
        width: 20,
        child: Stack(


          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              MediaRes.alarm,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn, // رنگ اصلی جایگزین رنگ قبلی میشه
              ),

              semanticsLabel: 'Red dash paths',
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                ),
              ),
            )

          ],
        ),
      ),
    ),
  );

  Widget get _switch => BlocConsumer<HomeBloc,HomeState>(

      listenWhen: (previous, current) => previous.statusButton != current.statusButton,


      listener: (context,state) {

        if(state.statusButton == StatusButton.success)
        {

          toastification.show(
              type: ToastificationType.success,
              style: ToastificationStyle.minimal,
              backgroundColor: Colors.grey[100],
              //overlayState: globalNavigatorKey.currentState?.overlay,
              autoCloseDuration: const Duration(seconds: 3),
              title: MyText(text:'موفق',color: Colors.black87,fontWeight: FontWeight.bold,),
              description: MyText(text:'تغییر وضعیت انجام شد',color: Colors.black87,)
          );

        }

        else if(state.statusButton== StatusButton.noInternet)
        {
          sl<DialogManager>().showNoNetDialog(
            context: context,
            onTryAgainClick: () {

              //BlocProvider.of<AuthBloc>(context).add(LoginEvent());
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
      buildWhen: (previous, current) =>  previous.isOnline != current.isOnline ,

      builder: (context,state)=>ToggleSwitch(
        initialLabelIndex: state.isOnline,
        totalSwitches: 2,
        activeBgColor: [Colors.orange],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.grey[900],
        labels: ['آنلاین', 'آفلاین', ],
        onToggle: (index) {
          print('switched to: $index');
          BlocProvider.of<HomeBloc>(context).add(ChangeOnline(value: index??0));

        },
      ));

  Widget get _menuBar => BlocBuilder<HomeBloc,HomeState>(


      builder: (context,state)=>   ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MyText(text: state.user?.name??'',color: Colors.white,fontWeight: FontWeight.bold,),
                    SizedBox(width: 10,),
                    CircleAvatar(foregroundImage:state.user?.avatar==null? AssetImage(MediaRes.avatar):NetworkImage(state.user?.avatar!))
                  ],
                ),
              )
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("خانه"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("تنظیمات"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ), );
}
