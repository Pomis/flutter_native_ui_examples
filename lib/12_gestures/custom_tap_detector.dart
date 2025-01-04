import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomSlopeTapDetector extends StatefulWidget {
  final double factor;
  final GestureTapCallback onTap;
  final Widget child;

  const CustomSlopeTapDetector(
      {super.key,
      required this.factor,
      required this.onTap,
      required this.child});

  @override
  State<CustomSlopeTapDetector> createState() => _CustomSlopeTapDetectorState();
}

class _CustomSlopeTapDetectorState extends State<CustomSlopeTapDetector> {
  Offset? _tapDownPosition;
  Offset? _panUpdatePosition;

  @override
  Widget build(BuildContext context) {
    final touchSlope = widget.factor *
        (MediaQuery.gestureSettingsOf(context).touchSlop ?? kTouchSlop);

    return GestureDetector(
      onTapDown: (details) {
        _tapDownPosition = details.globalPosition;
      },
      onTapUp: (details) {
        if (_tapDownPosition != null &&
            (details.globalPosition - _tapDownPosition!).distance <
                touchSlope) {
          widget.onTap();
        }
      },
      onPanUpdate: (details) {
        setState(() {
          _panUpdatePosition = details.localPosition;
          print(_panUpdatePosition);
        });
      },
      onPanCancel: () {
        setState(() {
          _panUpdatePosition = Offset.zero;
        });
      },
      onTapCancel: () => _tapDownPosition = null,
      child: Transform.translate(
        offset: (_panUpdatePosition ?? Offset.zero),
        child: widget.child,
      ),
    );
  }
}
