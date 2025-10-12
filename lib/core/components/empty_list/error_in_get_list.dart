

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/media_res.dart';
import '../text/text.dart';

class ErrorInGetList extends StatelessWidget {
  final String? text;
  final Widget? updateData;
  const ErrorInGetList({required this.text,required this.updateData,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(90),topRight: Radius.circular(8),bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),

          border: Border.all(color: Colors.grey[400]??Colors.grey,width: 0.7)
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SvgPicture.asset(MediaRes.error),
            SizedBox(height: 20,),
            MyText(
              textAlign: TextAlign.center,
              text: (text!=null && text!.isNotEmpty)?text!: 'خطا در گرفتن اطلاعات',),
            updateData??SizedBox()
          ],
        ),
      ),
    );
  }
}
