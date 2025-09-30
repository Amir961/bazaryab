
  import 'package:fare/core/components/text/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/values.dart';

class MyScaffold extends StatefulWidget {
  final String title;
  final Widget child;
  const MyScaffold({required this.title,required this.child,super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
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

              ),
            ],
          ),
        ),
      ),
    );
  }
}
