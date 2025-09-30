import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../inherited/tablet_checker/app_provider.dart';
import '../text/text.dart';

class RadioButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final double? size;
  final double? fontSize;
  final double? space;
  final Function()? onClick;

  const RadioButtonWidget({
    Key? key,
    required this.isSelected,
    required this.title,
    this.onClick,
    this.size,
    this.fontSize,
    this.space,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SizedBox(
              width: _size,
              height: _size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _borderWidget,
                  _innerWidget,
                ],
              ),
            ),
          ),
           SizedBox(width: space??8),
          Flexible(
            child: MyText(
              text: title,
              fontWeight: Fonts.light,
              fontSize: fontSize??14,
              color: AppProvider.of(context).isDark
                  ? Theme.of(context).textTheme.bodyMedium?.color
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          )
        ],
      ),
    );
  }

  Widget get _borderWidget => Builder(
        builder: (context) => AnimatedContainer(
          duration: _duration,
          curve: _curve,
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).hintColor,
              width: 1.5,
            ),
          ),
        ),
      );

  Widget get _innerWidget => Builder(
        builder: (context) => AnimatedContainer(
          duration: _duration,
          curve: _curve,
          width: isSelected ? _innerSize : 0,
          height: isSelected ? _innerSize : 0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );

  double get _size => size ?? 18;

  double get _innerSize => _size - 8;

  Duration get _duration => const Duration(milliseconds: 300);

  Curve get _curve => Curves.ease;
}
