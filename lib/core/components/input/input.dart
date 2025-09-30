import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/assets.dart';
import '../../utils/values.dart';
import '../inherited/tablet_checker/app_provider.dart';

class Input extends StatefulWidget {
  final double width;
  final TextEditingController controller;
  final Color? errorColor;
  final Color? focusColor;
  final Color? borderColor;
  final Color? textColor;
  final String? hintText;
  final bool hasError;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? fontFamily;
  final double? fontSize;
  final double? hintFontSize;
  final FontWeight? fontWeight;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChange;
  final Function? onSubmit;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final Widget? perfix;
  final TextCapitalization? textCapitalization;
  final bool isLock;

  const Input({
    Key? key,
    required this.width,
    required this.controller,
    this.isLock = false,
    this.textCapitalization,
    this.perfix,
    this.errorColor,
    this.borderColor,
    this.hintText,
    this.hasError = false,
    this.focusNode,
    this.fontFamily,
    this.fontSize = 14,
    this.hintFontSize = 12,
    this.fontWeight,
    this.isPassword = false,
    this.textInputAction,
    this.keyboardType,
    this.nextFocusNode,
    this.onChange,
    this.onSubmit,
    this.maxLength,
    this.expands = false,
    this.maxLines,
    this.minLines,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textColor,
    this.focusColor,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _showPass = false;
  late StreamController<bool> _showPassController;
  @override
  void initState() {
    super.initState();
    _showPassController = BehaviorSubject();
  }

  @override
  void dispose() {
    _showPassController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    final bool isDark = themeData.brightness == Brightness.dark;
    final curserColor = themeData.textSelectionTheme.cursorColor;
    final errorColor = widget.errorColor ?? MyColors.errorColor;
    final focusColor = widget.focusColor ?? themeData.focusColor;
    final hintColor = themeData.hintColor;
    // final borderColor = widget.borderColor ??
    //     (isDark ? themeData.dividerColor : MyColors.disableColor);


    final borderColor =  Colors.black38;
    final textColor = widget.textColor ??
        (isDark ? textTheme.bodyLarge!.color! : MyColors.cardColor);
    return SizedBox(
      width: widget.width,
      child: StreamBuilder<bool>(
          stream: _showPassController.stream,
          builder: (context, snapshot) {
            _showPass = snapshot.data ?? _showPass;
            return TextField(

              readOnly: widget.isLock,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              controller: widget.controller,
              cursorRadius: const Radius.circular(16),
              cursorColor: curserColor,
              cursorWidth: 2,
              obscureText: widget.isPassword && !_showPass,
              keyboardType: widget.keyboardType,
              focusNode: widget.focusNode,
              textInputAction: widget.textInputAction,
              onChanged: (text) {
                if (widget.onChange != null) widget.onChange!(text);
              },
              onSubmitted: (text) {
                if (widget.onSubmit == null) {
                  if (widget.nextFocusNode == null) {
                    FocusScope.of(context).unfocus();
                    return;
                  }
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  return;
                }
                widget.onSubmit!();
              },
              expands: widget.expands,
              textAlign: widget.textAlign,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              textAlignVertical: widget.textAlignVertical,
              style: TextStyle(
                color: textColor,
                fontFamily: AppProvider.of(context).getFontFamily,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
              ),
              decoration: InputDecoration(
                filled: true, // پس‌زمینه رو فعال می‌کنه
                fillColor: Colors.white, // رنگ پس‌زمینه
                prefix: widget.perfix,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Icon(
                          Icomoon.eyepassword,
                          color: Theme.of(context).hintColor,
                        ),
                        onTap: () => _showPassController.add(!_showPass),
                      )
                    : null,
                isDense: true,
                hintText: widget.hintText,
                counterText: '',
                contentPadding: EdgeInsetsDirectional.only(
                  start: 10,
                  end: widget.isPassword ? 0 : 10,
                  top: 15,
                  bottom: 15,
                ),
                hintStyle: TextStyle(
                  color: widget.hasError ? errorColor : hintColor,
                  fontFamily: AppProvider.of(context).getFontFamily,
                  fontSize: widget.hintFontSize,
                  fontWeight: widget.fontWeight ?? Fonts.light,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.isLock
                        ? borderColor
                        : widget.hasError
                            ? errorColor
                            : borderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.isLock
                        ? borderColor
                        : widget.hasError
                            ? errorColor
                            : borderColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.isLock
                        ? borderColor
                        : widget.hasError
                            ? errorColor
                            : focusColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            );
          }),
    );
  }

  bool get hasFocus => widget.focusNode?.hasFocus ?? false;

  double get borderRadius => 15;
}
