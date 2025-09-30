import 'package:flutter/material.dart';



class Toolbar extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;

  const Toolbar({
    Key? key,
    required this.child,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: 64 + topPadding,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [

               BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, -4),
                  blurRadius: 21,
                  spreadRadius: 0,
                )

        ],
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 2,
            right: 8,
            left: 8,
          ),
          child: child,
        ),
      ),
    );
  }
}
