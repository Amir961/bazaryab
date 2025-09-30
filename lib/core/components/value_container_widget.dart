import 'package:flutter/material.dart';

import '../../../../core/components/inherited/tablet_checker/app_provider.dart';
import '../../../../core/components/text/text.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/values.dart';

class ValueContainerWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? secondValue;
  final String lable;
  final String? secondLabel;
  final EdgeInsetsDirectional margin;
  final Function() onItemClick;

  const ValueContainerWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.lable,
    required this.onItemClick,
    required this.margin,
    this.secondLabel,
    this.secondValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: margin.start + 10,
            end: margin.end + 10,
          ),
          child: MyText(
            text: title,
            color: AppProvider.of(context).isDark
                ? Theme.of(context).textTheme.titleLarge?.color
                : Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 14,
            fontWeight: Fonts.light,
          ),
        ),
        Container(
          width: double.infinity,
          margin: margin,
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(3),
              onTap: () => onItemClick(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: AppProvider.of(context).getFontFamily,
                            fontWeight: Fonts.light,
                            color: AppProvider.of(context).isDark
                                ? Theme.of(context).textTheme.bodyLarge?.color
                                : MyColors.primaryColor,
                          ),
                          children: [
                            TextSpan(
                              text: value,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            TextSpan(
                              text: ' $lable',
                              style: const TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            if (secondValue != null)
                              TextSpan(
                                text: ' $secondValue',
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            if (secondValue != null)
                              TextSpan(
                                text: ' $secondLabel',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: Icon(
                      Icomoon.arrowDown,
                      color: AppProvider.of(context).isDark
                          ? Theme.of(context).textTheme.bodyLarge?.color
                          : MyColors.subtitleColor2,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
