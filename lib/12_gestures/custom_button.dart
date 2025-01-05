import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomGestureButton extends StatefulWidget {
  final GestureTapCallback onTap;

  const CustomGestureButton({super.key, required this.onTap});

  @override
  State<CustomGestureButton> createState() => _CustomGestureButton();
}

class _CustomGestureButton extends State<CustomGestureButton> {
  Offset _panUpdatePosition = Offset.zero;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final color = Color.lerp(
      Colors.blue,
      Color.fromARGB(255, 33, 76, 176),
      (_isPressed ? 0.5 : 0.0) +
          0.5 * (min(400, _panUpdatePosition.distance) / 400),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          print('onTap');
        },
        onPanDown: (details) {
          setState(() {
            _isPressed = true;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _panUpdatePosition = _panUpdatePosition - details.delta;
          });
        },
        onPanEnd: (details) {
          setState(() {
            _panUpdatePosition = Offset.zero;
            _isPressed = false;
          });
        },
        onPanCancel: () {
          setState(() {
            _panUpdatePosition = Offset.zero;
            _isPressed = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Transform.scale(
            scale: 1 - min(400, _panUpdatePosition.distance) / 1500,
            child: Transform.translate(
              offset: Offset(
                translateDistance(_panUpdatePosition.dx / 10, 40),
                translateDistance(_panUpdatePosition.dy / 10, 20),
              ),
              child: Text(
                "Button",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white.withOpacity(
                      1 - min(400, _panUpdatePosition.distance) / 400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double translateDistance(double distance, double limit) {
    return limit * sin(distance.clamp(-limit, limit) / limit);
  }
}