
import 'package:fare/core/res/constant.dart';
import 'package:flutter/material.dart';

import '../../../core/layouts/my_scaffold.dart';

class MyCustomerScreen extends StatefulWidget {
  static const routeName = '/my-customer-screen';
  const MyCustomerScreen({super.key});

  @override
  State<MyCustomerScreen> createState() => _MyCustomerScreenState();
}

class _MyCustomerScreenState extends State<MyCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(title: 'مشتری های من', child: Padding(padding: EdgeInsets.only(
      left: horizontalPadding,right: horizontalPadding,
      top: 20
    )),);
  }
}
