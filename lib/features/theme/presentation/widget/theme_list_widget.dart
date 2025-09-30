import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/presentation/bloc/app_theme_bloc.dart';
import 'theme_item_widget.dart';

class ThemeListWidget extends StatelessWidget {
  const ThemeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeBloc, AppThemeState>(
      builder: (context, state) => ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.getThemeList.length ,
        itemBuilder: (context, index) =>
            ThemeItemWidget(
                isSelected: state.getThemeList[index].id == state.theme.id,
                theme: state.getThemeList[index],
              )

      ),
    );
  }
}
