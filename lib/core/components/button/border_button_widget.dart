import 'package:flutter/material.dart';


import '../../../../core/components/loading/loading_widget.dart';
import '../../../../core/components/text/text.dart';
import '../../../../core/utils/assets.dart';

class BorderButtonWidget extends StatelessWidget {
  final bool loading;
  final Function onClick;
  final String text;

  const BorderButtonWidget({
    Key? key,
    required this.loading,
    required this.onClick,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 32,
        left: 32,
        bottom: 24,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(loading ? _buttonHeight * .5 : 8),
        color: Theme.of(context).dialogBackgroundColor,
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
            height: _buttonHeight,
            width: loading ? _buttonHeight : MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(loading ? _buttonHeight * .5 : 8),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.5,
                style: loading ? BorderStyle.none : BorderStyle.solid,
              ),
            ),
            child: AnimatedSwitcher(
              switchInCurve: _curve,
              switchOutCurve: _curve,
              duration: _duration,
              child: loading ? _loadingWidget : _buttonText,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _loadingWidget => Builder(
        key: const ValueKey(0),
        builder: (context) => LoadingWidget(
          progressColor: Theme.of(context).primaryColor,
          stroke: 2,
        ),
      );

  Widget get _buttonText => Builder(
        key: const ValueKey(1),
        builder: (context) => MyText(
          text: text,
          overflow: TextOverflow.fade,
          maxLine: 1,
          fontSize: 19,
          fontWeight: Fonts.medium,
          color: Theme.of(context).primaryColor,
        ),
      );

  Duration get _duration => const Duration(milliseconds: 300);

  Curve get _curve => Curves.ease;

  double get _buttonHeight => 46;
}
