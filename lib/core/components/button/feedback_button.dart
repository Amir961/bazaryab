import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../utils/assets.dart';


class FeedbackButtonWidget extends StatelessWidget {
  final double? size;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Function()? onClick;
  final Function()? onTapUp;
  final Function()? onTapDown;
  const FeedbackButtonWidget({
    super.key,
    this.size,
    this.child,
    this.margin,
     this.onClick,
     this.onTapUp,
     this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: _size,
        height: _size,
        margin: margin,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
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

  double get _size => size ?? 52;
}
