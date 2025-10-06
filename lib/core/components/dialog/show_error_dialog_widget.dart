

import 'package:blur/blur.dart';
import 'package:fare/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../features/language/utils/strings.dart';
import '../../utils/assets.dart';
import '../../utils/values.dart';
import '../text/text.dart';

class ShowErrorDialogWidget extends StatelessWidget {
  final Function() onTryAgainClick;
  final String? message;
  const ShowErrorDialogWidget({
    Key? key,
    required this.onTryAgainClick,
     this.message,
  }) : super(key: key);

  Future<bool> _onBackPressed() => Future.value(false);

  @override
  Widget build(BuildContext context) {
    return true
        ? WillPopScope(
            onWillPop: _onBackPressed,
            child: _body,
          )
        : _body;
  }

  Widget get _body =>
      Material(
        color: Colors.transparent,
        child: Builder(
          builder: (context) => Blur(
            blurColor: MyColors.darkCardColor.withOpacity(0.4),
            overlay: Center(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 44,
                  right: 44,
                  top: 24,
                  bottom: 24,
                ),
                padding: const EdgeInsets.only(
                  bottom: 24,
                  top: 8,
                  left: 4,
                  right: 4,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icomoon.close,
                            size: 17,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24, left: 24),
                      child: SvgPicture.asset(
                        MediaRes.error,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        width: 70,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: MyText(
                        text: message??'خطا در گرفتن اطلاعات',
                       // text: Strings.of(context).network_error,
                        textAlign: TextAlign.center,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                        fontWeight: Fonts.medium,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: _tryAgain,
                    ),
                  ],
                ),
              ),
            ),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        ),
      );

  Widget get _tryAgain => Builder(
        builder: (context) => Material(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).dialogBackgroundColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Navigator.of(context).pop();
              onTryAgainClick.call();
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              child: MyText(
              //  text: Strings.of(context).try_again_label,
                text: 'دوباره تلاش کنید',
                overflow: TextOverflow.fade,
                maxLine: 1,
                fontSize: 17,
                fontWeight: Fonts.medium,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      );
}
