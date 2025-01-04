import 'package:flutter/material.dart';

class PanDetector extends StatelessWidget {
  final Widget child;

  const PanDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTapDown: (_) => print("onTapDown"),
      // onTapUp: (_) => print("onTapUp"),
      onPanStart: (it) => print("onPanStart (${it.globalPosition})"),
      onPanDown: (it) => print("onPanDown (${it.globalPosition})"),
      onPanUpdate: (it) => print("onPanUpdate (${it.globalPosition})"),
      // onVerticalDragDown: (it) => print("onVerticalDragDown (${it.globalPosition})"),
      // onVerticalDragStart: (details) => print("onVerticalDragStart (${details.globalPosition})"),
      // onVerticalDragUpdate: (details) => print("onVerticalDragUpdate (${details.globalPosition})"),
      onPanEnd: (details) => print("onPanEnd (${details.velocity})"),
      onPanCancel: () => print("onPanCancel"),
      // onScaleStart: (details) => print("onScaleStart (${details.localFocalPoint})"),

      child: child,
    );
  }
}