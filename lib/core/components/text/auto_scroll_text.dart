import 'package:flutter/material.dart';

import 'text.dart';

class AutoScrollText extends StatefulWidget {
  final bool hasAnimation;
  final String text;
  final Widget? child;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final Duration duration;
  final Duration startDuration;
  final Duration endDuration;
  const AutoScrollText({
    Key? key,
    this.text = '',
    this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.startDuration = const Duration(milliseconds: 1000),
    this.endDuration = const Duration(milliseconds: 1000),
    this.hasAnimation = true,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.color,
    this.maxLine,
    this.overflow,
    this.textAlign,
    this.height,
  }) : super(key: key);

  @override
  State<AutoScrollText> createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<AutoScrollText> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _animateScroll();
  }

  @override
  void didUpdateWidget(AutoScrollText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) _animateScroll();
  }

  Future<void> _animateScroll() async {
    final needToScroll = _scrollController.hasClients
        ? _scrollController.position.maxScrollExtent > 0
        : true;
    if (!widget.hasAnimation || !needToScroll) return;
    await Future.delayed(widget.startDuration);
    if (!mounted) return;
    if (_isScrolling) return;
    _isScrolling = true;
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: widget.duration,
      curve: Curves.decelerate,
    );
    if (!mounted) return;
    await Future.delayed(widget.endDuration);
    if (!mounted) return;
    _isScrolling = false;
    _scrollController.jumpTo(0);
    _animateScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: widget.child ??
          MyText(
            key: widget.key,
            text: '${widget.text}   ',
            fontFamily: widget.fontFamily,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.color,
            height: widget.height,
            maxLine: widget.maxLine,
            overflow: widget.overflow,
            textAlign: widget.textAlign,
          ),
    );
  }
}
