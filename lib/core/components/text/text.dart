import 'package:flutter/material.dart';


import '../../utils/assets.dart';
import '../inherited/tablet_checker/app_provider.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? height;
  final TextDecoration textDecoration;
  const MyText({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.maxLine,
    this.color,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.height,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ,
      textDirection: textDirection?? AppProvider.of(context).getTextDirection,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontFamily: fontFamily ?? AppProvider.of(context).getFontFamily,
        // fontFamily: Fonts.poppins,
        fontSize: AppProvider.of(context).getFontSize(fontSize ?? 14),
        fontWeight: fontWeight ?? Fonts.medium,
        height: height,

        decoration: textDecoration,
      ),
      maxLines: maxLine,
      overflow: overflow,
    );
  }
}
