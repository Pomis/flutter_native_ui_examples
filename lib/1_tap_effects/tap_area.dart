import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TapArea extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongTap;
  final double borderRadius;
  final EdgeInsets? padding;

  const TapArea({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongTap,
    this.padding,
    this.borderRadius = 0,
  });

  @override
  State<TapArea> createState() => defaultTargetPlatform == TargetPlatform.iOS
      ? _TapAreaIosState()
      : _TapAreaAndroidState();
}

class _TapAreaAndroidState extends State<TapArea> {
  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.child,
    );

    if (widget.onTap == null && widget.onLongTap == null) return content;

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        onTap: widget.onTap,
        onLongPress: widget.onLongTap,
        child: content,
      ),
    );
  }
}

class _TapAreaIosState extends State<TapArea> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.child,
    );

    if (widget.onTap == null && widget.onLongTap == null) return content;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isDown = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isDown = false;
        });
      },
      onTap: () {
        setState(() {
          _isDown = false;
        });
        widget.onTap!();
      },
      onLongPress: widget.onLongTap,
      child: Focus(
        child: Opacity(
          opacity: _isDown ? 0.7 : 1.0,
          child: content,
        ),
      ),
    );
  }
}
