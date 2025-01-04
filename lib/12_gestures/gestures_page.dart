import 'package:flutter/material.dart';
import 'package:flutter_ui_examples/12_gestures/custom_button.dart';
import 'package:flutter_ui_examples/12_gestures/custom_scale_detector.dart';
import 'package:flutter_ui_examples/12_gestures/custom_tap_detector.dart';
import 'package:flutter_ui_examples/12_gestures/pan_detector.dart';

class GesturesPage extends StatelessWidget {
  const GesturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSlopeTapDetector(
              onTap: () => print("Tapped"),
              factor: 2,
              child: Container(
                width: 100,
                height: 20,
                color: Colors.red,
              ),
            ),
            PanDetector(
              child: Container(
                height: 300,
                width: 300,
                color: Colors.black12,
              ),
            ),
            CustomGestureButton(
              onTap: () => print("Tapped"),
            ),
            SizedBox(height: 100),

            CustomScaleDetector(),
          ],
        ),
      ),
    );
  }
}
