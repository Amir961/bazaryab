import 'package:flutter/material.dart';

import '../../../language/utils/strings.dart';
import '../widget/setting_toolbar.dart';
import '../widget/theme_list_widget.dart';



class ThemePage extends StatelessWidget {
  static const routeName = '/theme-screen';
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children:  [

            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: const ThemeListWidget(),
            ),
            SettingToolBarWidget(title: 'Strings.of(context).theme_label'),
          ],
        ),
      ),
    );
  }
}
