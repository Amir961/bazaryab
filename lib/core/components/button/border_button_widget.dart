import 'package:flutter/material.dart';


import '../../../../core/components/loading/loading_widget.dart';
import '../../../../core/components/text/text.dart';
import '../../../../core/utils/assets.dart';

class BorderButtonWidget extends StatelessWidget {
  final bool loading;
  final Function onClick;
  final String? text;
  final double? fontSize;
  final Widget? child;
  final double width;
  final double height;
  final Color? borderColor;
  final Color? backGroundColor;

  const BorderButtonWidget({
    Key? key,
    required this.loading,
    required this.onClick,
     this.text,
     this.fontSize,
    required this.width,
     required this.height,
      this.child,
    this.borderColor,
    this.backGroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // right: 32,
        // left: 32,
        // bottom: 24,
      ),
      child: Material(
        borderRadius:  BorderRadius.circular(loading ? 12 : 12),
        color: backGroundColor??Theme.of(context).dialogBackgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: loading
              ? null
              : () {
                  onClick();
                },
          child: AnimatedContainer(
            curve: _curve,
            duration: _duration,
            alignment: Alignment.center,
            height: height,
            width:  width,
            decoration: BoxDecoration(
              borderRadius:
                   BorderRadius.circular(loading ? 12 : 12),
              border: Border.all(
                color:borderColor?? Theme.of(context).primaryColor,
                width: 1.5,
                style:  BorderStyle.solid,
                //style: loading ? BorderStyle.none : BorderStyle.solid,
              ),
            ),
            child: AnimatedSwitcher(
              switchInCurve: _curve,
              switchOutCurve: _curve,
              duration: _duration,
              child: loading ? _loadingWidget : text!=null? _buttonText:_buttonWidget,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _loadingWidget => Builder(
        key: const ValueKey(0),
        builder: (context) => LoadingWidget(
          progressColor: borderColor ??Theme.of(context).primaryColor,
          stroke: 2,
        ),
      );

  Widget get _buttonText => Builder(
        key: const ValueKey(1),
        builder: (context) => MyText(
          text: text!,
          overflow: TextOverflow.fade,
          maxLine: 1,
          fontSize: fontSize??16,
          fontWeight: Fonts.medium,
          color: borderColor?? Theme.of(context).primaryColor,
        ),
      );

  Widget get _buttonWidget => Builder(
    key: const ValueKey(1),
    builder: (context) => child??SizedBox(),
  );

  Duration get _duration => const Duration(milliseconds: 300);

  Curve get _curve => Curves.ease;


}
