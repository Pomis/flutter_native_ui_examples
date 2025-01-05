import 'package:flutter/material.dart';

class TransformScaleDetector extends StatefulWidget {
  const TransformScaleDetector({super.key});

  @override
  State<TransformScaleDetector> createState() => _TransformScaleDetectorState();
}

class _TransformScaleDetectorState extends State<TransformScaleDetector> {
  double scaleOnStart = 1.0;
  double scale = 1.0;
  Offset offset = Offset.zero;
  Offset? lastFocalPoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        scaleOnStart = scale;
        lastFocalPoint = details.localFocalPoint;
      },
      onScaleUpdate: (details) {
        if (details.pointerCount == 1) {
          return;
        }
        setState(() {
          scale = scaleOnStart * details.scale;
          
          // Update offset based on focal point movement
          if (lastFocalPoint != null) {
            final delta = details.localFocalPoint - lastFocalPoint!;
            offset += delta / scale;
            lastFocalPoint = details.localFocalPoint;
          }
        });
      },
      onScaleEnd: (details) {
        lastFocalPoint = null;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        width: 300,
        height: 300,
        child: Transform(
          transform: Matrix4.identity()
            ..translate(offset.dx, offset.dy)
            ..scale(scale),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}