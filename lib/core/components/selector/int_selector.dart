



import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../../utils/values.dart';
import '../inherited/tablet_checker/app_provider.dart';

import '../text/text.dart';

class IntSelectorWidget<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Function(int) onSelectedItemChange;
  final T selectedItem;
  final int initialItem;
  final double? itemWidth;
  final double? itemHeight;
  final Color? titleColor;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final double? fontSize;
  final bool needToUpdate;
  final double? titleMarginBottom;
  final double? titleFontSize;
  final bool isNotFromAuthPage;
  final bool? isWeight;

  const IntSelectorWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.onSelectedItemChange,
    required this.selectedItem,
    required this.initialItem,
    this.needToUpdate = false,
    this.fontSize,
    this.titleColor,
    this.selectedColor,
    this.unSelectedColor,
    this.itemHeight,
    this.itemWidth,
    this.titleMarginBottom,
    this.titleFontSize,
    this.isNotFromAuthPage = false,
    this.isWeight,
  }) : super(key: key);

  @override
  State<IntSelectorWidget> createState() => _IntSelectorWidgetState();
}

class _IntSelectorWidgetState extends State<IntSelectorWidget> {
  late FixedExtentScrollController _controller;

  final TextEditingController _usernameTextEditingController =
  TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();

  @override
  void didUpdateWidget(IntSelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.needToUpdate) _controller.jumpToItem(widget.selectedItem);
  }

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: widget.initialItem);
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameFocusNode.dispose();
    _usernameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // _input,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: widget.titleMarginBottom ?? 50),
              _title,
              SizedBox(height: widget.titleMarginBottom ?? 0),
              // _input,
              //  SizedBox(height: widget.titleMarginBottom ?? 14),
              _selector,
              SizedBox(height: widget.titleMarginBottom ?? 14),
            ],
          ),
        ),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget get _title => Builder(
    builder: (context) => MyText(
      text: widget.title,
      color: widget.titleColor ??
          (AppProvider.of(context).isDark
              ? Theme.of(context).textTheme.bodyLarge?.color
              : MyColors.subtitleColor2),
      fontSize: widget.titleFontSize ?? 22,
      fontWeight: Fonts.regular,
    ),
  );



  Widget get _selector => Builder(
    builder: (context) => SizedBox(
      height: _indicatorheight,
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        physics: const FixedExtentScrollPhysics(),
        itemExtent: _itemHeight + _marginTop,
        perspective: 0.001,
        onSelectedItemChanged: (index) {
          widget.onSelectedItemChange(index);
          _usernameTextEditingController.text = (index + 1).toString();
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(
            widget.items.length,
                (index) => _item(
              value: widget.items[index],
              currentIndex: index,
              selectedIndex: widget.items.indexWhere((item)=>item==widget.selectedItem) ,
            ),
          ),
        ),
      ),
    ),
  );

  Widget _item({
    required dynamic value,
    required int currentIndex,
    required int selectedIndex,
  }) =>
      Builder(
        builder: (context) {
          int maxIndex = widget.items.length - 1;
          final isDark = AppProvider.of(context).isDark;
          final isSelected = currentIndex == selectedIndex;
          final borderColor = isSelected
              ? Theme.of(context).primaryColor
              : (isDark
              ? Theme.of(context).disabledColor
              : MyColors.textColor2);
          int rawDif = (currentIndex - selectedIndex).abs();
          if (rawDif > 3) rawDif = maxIndex - (rawDif - 1);
          int dif = min(2, rawDif);
          final double opacity = max(
              1 - (dif * 0.25),
              isDark
                  ? .4
                  : widget.isNotFromAuthPage
                  ? .4
                  : .8);
          final width = _itemWidth -
              (dif == 0
                  ? 0
                  : dif == 1
                  ? 18
                  : 32);
          final height = _itemHeight -
              (dif == 0
                  ? 0
                  : dif == 1
                  ? 6
                  : 10);
          return Center(
            child: AnimatedContainer(
              duration: _duration,
              curve: _curve,
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    width: 2, color: borderColor.withOpacity(min(opacity, 1))),
                color: Theme.of(context).cardColor.withOpacity(min(opacity, 1)),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: _duration,
                  curve: _curve,
                  style: TextStyle(
                    color: borderColor.withOpacity(min(opacity, 1)),
                    fontSize: _fontSize - (dif * 3),
                    fontWeight: Fonts.regular,
                    fontFamily: AppProvider.of(context).getFontFamily,
                  ),
                  child: Text('$value')

                  // BlocBuilder<SettingsCubit, SettingsState>(
                  //   builder: (context, state) => Text('$value'),
                  // ),
                ),
              ),
            ),
          );
        },
      );

  Duration get _duration => const Duration(milliseconds: 300);

  Curve get _curve => Curves.decelerate;

  double get _itemWidth => widget.itemWidth ?? 100;

  double get _itemHeight => widget.itemHeight ?? 60;

  double get _marginTop => 8;

  double get _indicatorheight => ((_itemHeight + _marginTop) * 5);

  double get _fontSize => widget.fontSize ?? 25;
}