import 'package:flutter/material.dart';

import '../../../features/language/utils/strings.dart';
import '../../utils/assets.dart';
import '../inherited/tablet_checker/app_provider.dart';

class YesNoButtonWidget extends StatelessWidget {
  final Function onClick;
  final bool isSelected;
  final double width;
  final double height;
  final double fontSize;

  final String text;

  const YesNoButtonWidget({
    super.key,
    required this.onClick,
    required this.isSelected,
    required this.text,
    this.width = 80,
    this.height = 32,
    this.fontSize = 17,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final unSelectedColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final backgroundColor = Theme.of(context).cardColor;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return AnimatedContainer(
      width: width,
      height: height,
      duration: _duration,
      curve: _curve,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? selectedColor : unSelectedColor,
          width: 1,
          style: isLight ? BorderStyle.none : BorderStyle.solid,
        ),
        color: isLight && isSelected ? selectedColor : backgroundColor,
        boxShadow: [
          if (!AppProvider.of(context).isDark)
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClick(),
          borderRadius: BorderRadius.circular(4),
          child: Center(
            child: AnimatedDefaultTextStyle(
              curve: _curve,
              style: TextStyle(
                fontWeight: Fonts.medium,
                fontFamily: AppProvider.of(context).getFontFamily,
                color: isSelected
                    ? isLight
                        ? Colors.white
                        : selectedColor
                    : unSelectedColor,
                fontSize: fontSize,
              ),
              duration: _duration,
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Duration get _duration => const Duration(milliseconds: 200);
  Curve get _curve => Curves.ease;
}
