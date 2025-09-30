import 'package:flutter/material.dart';


import '../../../../core/components/loading/loading_widget.dart';
import '../../../../core/components/text/text.dart';
import '../../../../core/utils/assets.dart';
import '../../utils/values.dart';
import '../inherited/tablet_checker/app_provider.dart';

class ButtonWidget extends StatelessWidget {
  final bool loading;
  final bool isEnable;
  final Function? onClick;
  final String text;
  final double width;
  final double height;
  final double? fontSize;
  final Color? backGroundColor;

  const ButtonWidget({
    Key? key,
    this.fontSize,
    this.backGroundColor,
    this.isEnable = true,
    required this.loading,
    required this.onClick,
    required this.text,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => loginButton;

  Widget get loginButton => AnimatedContainer(
        width: loading ? height : width,
        height: height,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        child: Builder(
          builder: (context) => TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: isEnable?( backGroundColor?? Theme.of(context).primaryColor): Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(loading ? 29 : 15),
              ),
            ),
            onPressed:onClick==null?null: () {
              if (loading || !(isEnable ?? true)) return;
              onClick!();
            },
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: loading
                    ? SizedBox(
                        width: 28,
                        height: 28,
                        child: LoadingWidget(
                          progressColor: AppProvider.of(context).isDark
                              ? const Color(0xff272a32)
                              : MyColors.cardColor,
                          stroke: 3,
                        ),
                      )
                    : MyText(
                        text: text,
                        fontSize: fontSize ?? 22,
                        color:  Colors.white,
                        fontWeight: Fonts.medium,
                      ),
              ),
            ),
          ),
        ),
      );
}
