
  import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

import '../../../features/language/utils/strings.dart';
import '../../utils/assets.dart';
import '../../utils/values.dart';
import '../button/button_widget.dart';

import '../text/text.dart';

class YesNoDialog extends StatelessWidget {
  final String description;
  final String? yesLabel;
  final String? noLabel;
  final Function() yesClick;
  final Function()? noClick;
  const YesNoDialog({super.key,required this.description,required this.noClick,required this.noLabel,required this.yesClick,required this.yesLabel});

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Widget get _body => Material(
    color: Colors.transparent,
    child: Builder(
      builder: (context) => Blur(
        blurColor: MyColors.darkCardColor.withOpacity(0.4),
        overlay: Center(
          child: Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: 24,
            ),
            padding: const EdgeInsets.only(
              bottom: 16,
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
                SizedBox(
                  height: 20,
                ),


                _descriptionView,

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(


                        onClick: () {
                          yesClick.call();
                        },
                        loading: false,
                        text: yesLabel?? Strings.of(context)
                            .yes_label,
                        width: 100,
                        height: 35,
                      ),
                      const SizedBox(width: 10,),
                      ButtonWidget(

                        onClick: () {
                         if( noClick==null)
                           {
                             Navigator.of(context).pop();
                           }
                         else
                           {
                             noClick!.call();
                           }
                        },
                        loading: false,
                        text:noLabel?? Strings.of(context)
                            .no_label,
                        width: 100,
                        height: 35,
                      ),
                    ],
                  ),
                )
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



  Widget get _descriptionView => Builder(
    builder: (context) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 24,
        end: 16,
        bottom: 16,
      ),
      child:



      MyText(
        text: description,
        fontSize: 15,
        textAlign: TextAlign.start,
        fontWeight: Fonts.regular,
      ),
    ),
  );
}
