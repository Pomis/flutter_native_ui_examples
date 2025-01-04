import 'dart:math';

import 'package:flutter/material.dart';

class CustomScaleDetector extends StatefulWidget {
  const CustomScaleDetector({super.key});

  @override
  State<CustomScaleDetector> createState() => _CustomScaleDetectorState();
}

class _CustomScaleDetectorState extends State<CustomScaleDetector> {
  double scaleOnStart = 1.0;
  double scale = 1.0;
  double scaleDelta = 0.0;
  Offset? localFocalPoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        scaleOnStart = scale;
      },
      onScaleUpdate: (details) {
        if (details.pointerCount == 1) {
          return;
        }
        setState(() {
          scaleDelta = scale - details.scale;

          // if (details.pointerCount > 1) {
            scale = scaleOnStart * details.scale;
            
          // }
          // if (details.pointerCount > 1) {
          localFocalPoint = details.localFocalPoint;
          // }
        });
      },
      onScaleEnd: (details) {},
      child: CustomPaint(
        painter:
            CustomScalePainter(scale: scale, localFocalPoint: localFocalPoint, scaleDelta: scaleDelta),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

class CustomScalePainter extends CustomPainter {
  final double scale;
  final double scaleDelta;
  Offset? localFocalPoint;
  Offset? blackCircleCenter;

  CustomScalePainter(
      {super.repaint, required this.scale, required this.scaleDelta, required this.localFocalPoint});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;


    blackCircleCenter =
        (Offset(size.width / 2, size.height / 2) + (localFocalPoint ?? Offset.zero) * (1 - scaleDelta));
    final radius = size.width * scale / 2;

    if (localFocalPoint != null) {
      canvas.drawCircle(localFocalPoint!, 2, paint);

      // final paint2 = Paint()
      //   ..color = Colors.red
      //   ..strokeWidth = 5
      //   ..style = PaintingStyle.stroke;
      // canvas.drawCircle(localFocalPoint!, 2.5, paint2);

      TextPainter tp = TextPainter();
      tp.textDirection = TextDirection.ltr;
      tp.text = TextSpan(
          text: 'localFocalPoint:\n$localFocalPoint\nscale: $scale',
          style: TextStyle(color: Colors.black, fontSize: 16));
      tp.layout();
      tp.paint(canvas, localFocalPoint! - Offset(0, 20));
    }
    if (blackCircleCenter != null) {
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(blackCircleCenter!, radius, paint);

      // TextPainter tp = TextPainter();
      // tp.textDirection = TextDirection.ltr;
      // tp.text = TextSpan(
      //     text: 'blackCircleCenter:\n$blackCircleCenter',
      //     style: TextStyle(color: Colors.black, fontSize: 16));
      // tp.layout();
      // tp.paint(canvas, blackCircleCenter! - Offset(0, 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
