import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../language/utils/strings.dart';

import '../../../../core/components/inherited/tablet_checker/app_provider.dart';
import '../../../../core/components/text/text.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/values.dart';
import '../../../theme/domain/entity/app_theme.dart';
import '../../../theme/presentation/bloc/app_theme_bloc.dart';

class ThemeItemWidget extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  const ThemeItemWidget({
    Key? key,
    required this.theme,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Theme.of(context).cardColor,
        boxShadow: [
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
          borderRadius: BorderRadius.circular(7),
          onTap: () {
            BlocProvider.of<AppThemeBloc>(context)
                .add(SetAppThemeEvent(themeMode: theme.theme));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _titleWidget,
                const SizedBox(width: 8),
                AnimatedCrossFade(
                  firstChild: _selectIconWidget,
                  secondChild: const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  crossFadeState: isSelected
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                  sizeCurve: Curves.ease,
                  firstCurve: Curves.ease,
                  secondCurve: Curves.ease,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _titleWidget => Builder(
        builder: (context) => MyText(
          text: _getName(context),
          textAlign: TextAlign.start,
          fontSize: 17,
          fontWeight: Fonts.medium,
          color: AppProvider.of(context).isDark
              ? Theme.of(context).textTheme.bodyLarge?.color
              : MyColors.subtitleColor2,
        ),
      );

  Widget get _selectIconWidget => Builder(
        builder: (context) => Icon(
          Icomoon.success,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      );

  String _getName(BuildContext context) {
    switch (theme.theme) {
      case ThemeMode.system:
        return 'Strings.of(context).system_default_label';
      case ThemeMode.light:
        return 'Strings.of(context).light_label';
      case ThemeMode.dark:
        return 'Strings.of(context).dark_label';
    }
  }
}
