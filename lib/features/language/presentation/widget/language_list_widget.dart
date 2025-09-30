import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../language/presentation/bloc/app_language_bloc.dart';
import 'language_item_widget.dart';


class LanguageListWidget extends StatefulWidget {
  final bool isProfile;
  const LanguageListWidget({
    Key? key,
    required this.isProfile,
  }) : super(key: key);

  @override
  State<LanguageListWidget> createState() => _LanguageListWidgetState();
}

class _LanguageListWidgetState extends State<LanguageListWidget> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return

      BlocBuilder<AppLanguageBloc,AppLanguageState>(
        builder: (context,state) {
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.getLanguageList.length ,
            itemBuilder: (context, index) =>
             LanguageItemWidget(
              isProfile: widget.isProfile,
              isSelected:
              state.getLanguageList[index].language ==
                  state.language.language,
              language: state.getLanguageList[index],
            )

          );
        }
      );
  }


}
