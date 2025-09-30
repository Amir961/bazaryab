
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../inherited/tablet_checker/app_provider.dart';

class MyAutoSizeText extends StatelessWidget {
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
  const MyAutoSizeText({
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
    return AutoSizeText(
      text,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      minFontSize: 9,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontFamily: AppProvider.of(context).getFontFamily,
        fontSize: AppProvider.of(context).getFontSize(fontSize ?? 14),
        fontWeight: fontWeight ?? Fonts.light,
        height: height,
        decoration: textDecoration,
      ),
      maxLines: maxLine,
      overflow: overflow,
    );
  }
}
