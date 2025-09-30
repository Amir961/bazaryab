import 'package:flutter/material.dart';
//import 'package:imazh/features/setting/presentation/widget/setting_toolbar.dart';

import '../../utils/strings.dart';
import '../widget/language_list_widget.dart';



class LanguagePage extends StatelessWidget {
  static const routeName = '/language-screen';
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:  [
            //SettingToolBarWidget(title: Strings.of(context).language_label),
            LanguageListWidget(
              isProfile: true,
            ),
          ],
        ),
      ),
    );
  }
}
