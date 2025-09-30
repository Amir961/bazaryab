import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inherited/tablet_checker/app_provider.dart';
import '../../../../core/components/text/text.dart';
import '../../../../core/utils/assets.dart';

import '../../../language/domain/entity/app_language.dart';
import '../../../language/presentation/bloc/app_language_bloc.dart';

class LanguageItemWidget extends StatelessWidget {
  final AppLanguage language;
  final bool isSelected;
  final bool isProfile;
  const LanguageItemWidget({
    Key? key,
    required this.language,
    required this.isSelected,
    required this.isProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
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
            BlocProvider.of<AppLanguageBloc>(context)
                .add(SetAppLanguageEvent(tag: language.language));
            if (isProfile) {
              debugPrint(language.language);
              // BlocProvider.of<AppLanguageBloc>(context)
              //     .add(SetAppLanguageEvent(tag: language.language));

            //  BlocProvider.of<UpdateUserInfoBloc>(context).add(
            //      PostUpdateLanguageUserInfoEvent(language: language.language));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _titleWidget,
                    const SizedBox(height: 4),
                    _nameWidget,
                  ],
                ),
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
          text: language.nameEnglish,
          textAlign: TextAlign.start,
          fontSize: 17,
          fontWeight: Fonts.medium,

        ),
      );

  Widget get _nameWidget => Builder(
        builder: (context) => MyText(
          text: language.nameNative ?? '',
          textAlign: TextAlign.start,
          fontSize: 13,
          fontWeight: Fonts.medium,

        ),
      );

  Widget get _selectIconWidget => Builder(
        builder: (context) => Icon(
          Icomoon.success,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      );
}
