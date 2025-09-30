import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color? progressColor;
  final double stroke;
  final double? width;

  const LoadingWidget({
    Key? key,
    this.progressColor,
    this.stroke = 3,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: width,
            height: width,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColor ?? Colors.white,
              ),
              strokeWidth: stroke,
            ),
          ),
        ),
      );
}
