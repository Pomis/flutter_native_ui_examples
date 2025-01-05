import 'package:flutter/material.dart';

class CustomScaleDetector2 extends StatefulWidget {
  const CustomScaleDetector2({super.key});

  @override
  State<CustomScaleDetector2> createState() => _CustomScaleDetector2State();
}

class _CustomScaleDetector2State extends State<CustomScaleDetector2> {
  double _baseScale = 1.0;
  double _currentScale = 1.0;
  Offset _offset = Offset.zero;
  Offset? _lastFocalPoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _baseScale = _currentScale;
        _lastFocalPoint = details.localFocalPoint;
      },
      onScaleUpdate: (details) {
        setState(() {
          if (details.pointerCount > 1) {
            _currentScale = (_baseScale * details.scale);
            
            // Calculate the offset based on focal point movement
            if (_lastFocalPoint != null) {
              final delta = details.localFocalPoint - _lastFocalPoint!;
              _offset += delta / _currentScale;
              _lastFocalPoint = details.localFocalPoint;
            }
          }
        });
      },
      onScaleEnd: (details) {
        _lastFocalPoint = null;
      },
      child: CustomPaint(
        painter: _CustomScalePainter(
          scale: _currentScale,
          offset: _offset,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          width: 300,
          height: 500,
        ),
      ),
    );
  }
}

class _CustomScalePainter extends CustomPainter {
  final double scale;
  final Offset offset;

  _CustomScalePainter({
    required this.scale,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Save the current canvas state
    canvas.save();
    
    // Transform the canvas based on scale and offset
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.scale(scale);
    canvas.translate(-center.dx, -center.dy);
    canvas.translate(offset.dx, offset.dy);

    // Draw a red square
    final radius = size.width / 4;
    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: radius * 2,
        height: radius * 2,
      ),
      paint,
    );

    // Restore the canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CustomScalePainter oldDelegate) {
    return oldDelegate.scale != scale || oldDelegate.offset != offset;
  }
}
