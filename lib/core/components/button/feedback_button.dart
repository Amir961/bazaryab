import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../utils/assets.dart';


class FeedbackButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color? backGround;
  final bool isBorder;
  final EdgeInsetsGeometry? margin;
  final Function()? onClick;
  final Function()? onTapUp;
  final Function()? onTapDown;
  const FeedbackButtonWidget({
    super.key,
    this.isBorder=false,
    this.width,
    this.height,
    this.child,
    this.margin,
     this.onClick,
     this.onTapUp,
     this.onTapDown,
     this.backGround,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: _size,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: backGround??Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: isBorder?Border.all(color: Colors.grey):null
        ),
        alignment: Alignment.center,
        child:

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onClick,
          onTapUp:onTapUp!=null? (_) {
            onTapUp!.call();
          }:null,
          onTapDown:onTapDown!=null?(_) {
            onTapDown!.call();
          }:null,
          onTapCancel:onTapUp!=null? (){
            onTapUp!.call();
          }:null,
          child:child?? const Icon(
            Icomoon.feedback,
            size: 28,
            color: Colors.white,
          ),
        ),
      );
  }

  double get _size => width ?? 52;
}
