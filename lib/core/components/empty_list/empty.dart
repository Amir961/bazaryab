

import 'package:fare/core/components/text/text.dart';
import 'package:fare/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  final Widget? updateData;
  const EmptyWidget({this.updateData,this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: double.infinity,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(90),topRight: Radius.circular(8),bottomRight: Radius.circular(8),bottomLeft: Radius.circular(0)),
          border: Border.all(color: Colors.grey[400]??Colors.grey,width: 0.7)
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SvgPicture.asset(MediaRes.searchEmpty),
            SizedBox(height: 20,),
            MyText(
              textAlign: TextAlign.center,
              text: text?? 'در این بازه اطلاعاتی وجود ندارد.',),
               updateData??SizedBox()
          ],
        ),
      ),
    );
  }
}
