

import 'package:fare/core/components/text/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/values.dart';

class MyScaffold extends StatefulWidget {
  final String title;
  final Widget child;
  final Function()? backFunction;
  const MyScaffold({required this.title,required this.child,this.backFunction,super.key,});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {

  Future<bool> _onWillPop() async {
    if (widget.backFunction != null) {
      widget.backFunction!();
      return false; // از pop پیش‌فرض جلوگیری می‌کنیم
    } else {
      return true; // اجازه بده خودش pop کنه
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      // اگر backFunction تعریف شده باشه، از pop خودکار جلوگیری کن (تا بتونیم خودش رو هندل کنیم)
      canPop: widget.backFunction == null,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        // اگر فریم‌ورک خودش pop رو انجام داده، کاری انجام نمیدیم
        if (didPop) return;

        // اگر backFunction داریم، اجراش کن (از Future.sync برای پشتیبانی از sync/async استفاده می‌کنیم)
        if (widget.backFunction != null) {
          await Future.sync(() => widget.backFunction!.call());
          // توجه: اینجا عمدی pop نکنیم — فرض می‌کنیم backFunction خودش در صورت لزوم Navigator.pop() یا context.pop() را صدا می‌زند.
        } else {
          // اگر backFunction نبود، می‌تونیم خودمون pop کنیم و نتیجه (result) رو پاس بدیم
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        body: SafeArea(
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
                              debugPrint('back_is: ${widget.backFunction}');
                              if(widget.backFunction!=null)
                                {
                                  debugPrint('back_is1: ${widget.backFunction}');
                                  widget.backFunction!();
                                }
                              else
                              {
                                debugPrint('back_is2: ${widget.backFunction}');
                                context.pop();
                              }
                            },
                            child: RotatedBox(
                                quarterTurns: 90,
                                child: Icon(Icons.play_arrow_rounded,color: Colors.white,size: 32,)),
                          )),
                      Positioned(
                          top:80,
                          right: 20,
                          child: MyText(text: widget.title,fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,)),
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
                  child: widget.child,
      
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
