
import 'package:fare/core/res/constant.dart';
import 'package:flutter/material.dart';

import '../../../core/layouts/my_scaffold.dart';

class MessagesScreen extends StatefulWidget {
  static const routeName = '/message-screen';
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(title: 'نوتیفیکیشن ها', child: Padding(padding: EdgeInsets.only(
      left: horizontalPadding,right: horizontalPadding,
      top: 20
    )),);
  }
}
