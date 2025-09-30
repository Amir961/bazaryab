import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/components/text/auto_scroll_text.dart';
import '../../../../core/components/toolbar.dart';
import '../../../../core/res/media_res.dart';
import '../../../../core/utils/assets.dart';
import '../../../language/utils/strings.dart';


class SettingToolBarWidget extends StatelessWidget {

  final String title;

  const SettingToolBarWidget({
    required this.title,
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    return Toolbar(
      margin: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          _menuButton,
          _titleWidget,
         _actionButton,
        ],
      ),
    );
  }

  Widget get _titleWidget => Positioned.fill(
        child: Builder(
          builder: (context) => Container(
            margin: EdgeInsets.only(
              left: _actionButtonSize * 1.2,
              right: _actionButtonSize * 1.2,
            ),
            height: _actionButtonSize,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 11.5),
            child:
            AutoScrollText(
              key:  ValueKey(title),
              startDuration: const Duration(milliseconds: 1500),
              endDuration: const Duration(milliseconds: 1500),
              duration: const Duration(seconds: 2),
              textAlign: TextAlign.center,
              maxLine: 2,
              text: title,
              fontSize: 17,
              fontWeight: Fonts.medium,
            ),
          ),
        ),
      );

  Widget get _menuButton => Align(
        alignment: AlignmentDirectional.bottomStart,
        child: _backButton

      );

  Widget get _backButton => Builder(
        builder: (context) => SizedBox(
          key: const ValueKey(4),
          width: _actionButtonSize,
          height: _actionButtonSize,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(_actionButtonSize / 2),
              onTap: () {
               Navigator.of(context).pop();
              },
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  //color: Colors.blue,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _actionButton => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(MediaRes.logo,),
         //  child: InkWell(
         //      onTap: (){},
         //      child: const Icon(Icomoon.plus)),
        )


      );














  double get _actionButtonSize => 56;


}
