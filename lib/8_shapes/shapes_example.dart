import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'ticket_item.dart';

class ShapesExample extends StatefulWidget {
  const ShapesExample({super.key});

  @override
  State<ShapesExample> createState() => _ShapesExampleState();
}

class _ShapesExampleState extends State<ShapesExample> {
  final dateIndicatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notches example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _item1(),
            SizedBox(height: 20),

            _item2(),
            // _item3(),
            // _item4(),
            SizedBox(height: 20),
            // _item5(),
            // _item6(),
            SizedBox(height: 20),

            // _item7(),
            // _item8(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 150,
        color: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        notchMargin: 10,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Row(
          children: [Text('dsfdsfdsf')],
        ),
      ),
    );
  }

  Widget _item1() {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: Color(0xFFd6f5ff),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20))
            .lerpTo(
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(1)),
                0.4)!,
      ),
      child: const SizedBox(height: 200, width: 200),
    );
  }

  Widget _item2() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        color: Color(0xFFd6f5ff),
      ),
      child: const SizedBox(height: 200, width: 200),
    );
  }

  Widget _item3() {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: StarBorder(),
        color: Colors.amber,
      ),
      child: const SizedBox(height: 100, width: 100),
    );
  }

  Widget _item4() {
    return MessageBubble(text: "Sample message text");
  }

  Widget _item5() {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: MessageShapeBorder(
            borderRadius: 50,
            side: BorderSide(width: 0, color: Color(0xFF7ADEFF))),
        color: Color(0xFF7ADEFF),
      ),
      child: SizedBox(width: 500, height: 200),
    );
  }

  Widget _item7() {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: MessageShapeBorder(),
      ),
      child: Image.asset(
        "assets/6392956.jpg",
        height: 200,
        width: 300,
        fit: BoxFit.cover,
        cacheHeight: (300 * MediaQuery.of(context).devicePixelRatio).toInt(),
      ),
    );
  }

  Widget _item8() {
    return TicketItem(
      topChild: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Top child"),
          ],
        ),
      ),
      bottomChild: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (rectangle) => LinearGradient(
          begin: Alignment.topCenter,
          stops: [0, 1],
          colors: [Color(0xFFd6f5ff), Color(0x00d6f5ff)],
          end: Alignment.bottomCenter,
        ).createShader(rectangle),
        child: Image.asset(
          "assets/6392956.jpg",
          height: 200,
          width: 300,
          fit: BoxFit.cover,
          cacheHeight: (300 * MediaQuery.of(context).devicePixelRatio).toInt(),
        ),
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  final String text;
  const MessageBubble({super.key, required this.text});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  var isPressed = false;

  late Animation<double> animation;
  late Tween<double> tween;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: kThemeAnimationDuration, vsync: this);
    tween = Tween(begin: 2.5, end: 5.0);
    animation = tween.animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() {
        isPressed = true;
        controller.forward();
      }),
      onTapUp: (details) => setState(() {
        isPressed = false;
        controller.reverse();
      }),
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return DecoratedBox(
              decoration: ShapeDecoration(
                shape: MessageShapeBorder(
                  side: BorderSide(
                      color: Color(0xFF7ADEFF), width: animation.value + 2),
                  weight: animation.value,
                  borderRadius: 30,
                ),
                color: const Color(0xFFd6f5ff),
              ),
              child: Padding(
                padding: EdgeInsets.all(20).copyWith(left: 30),
                child: Text(widget.text),
              ),
            );
          }),
    );
  }
}

class MessageShapeBorder extends OutlinedBorder {
  final double borderRadius;
  final double weight;
  // final Color fillColor;

  const MessageShapeBorder(
      {super.side,
      this.borderRadius = 50,
      /*required this.fillColor,*/ this.weight = 2.5});

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final strokeWidth = side.width;

    final double left = rect.left + strokeWidth;
    final double right = rect.right - strokeWidth;
    final double top = rect.top + strokeWidth;
    final double bottom = rect.bottom - strokeWidth;

    final radius = math.max(0, borderRadius - 10);
    final offset = 10;

    return Path()
      ..moveTo(left + offset + radius, bottom)
      ..conicTo(
          left + offset, bottom, left + offset, bottom - 2 * radius, weight)
      ..lineTo(left + offset, top + radius)
      ..conicTo(left + offset, top, left + offset + radius, top, weight)
      ..lineTo(right - radius, top)
      ..conicTo(right, top, right, top + radius, weight)
      ..lineTo(right, bottom - radius)
      ..conicTo(right, bottom, right - radius, bottom, weight)
      ..close();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double left = rect.left;
    final double right = rect.right;
    final double top = rect.top;
    final double bottom = rect.bottom;

    final radius = borderRadius;
    final offset = 10;

    return Path()
      ..moveTo(left, bottom)
      ..conicTo(left + offset, bottom - offset, left + offset,
          bottom - 2 * radius, weight)
      ..lineTo(left + offset, top + radius)
      ..conicTo(left + offset, top, left + offset + radius, top, weight)
      ..lineTo(right - radius, top)
      ..conicTo(right, top, right, top + radius, weight)
      ..lineTo(right, bottom - radius)
      ..conicTo(right, bottom, right - radius, bottom, weight)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPath(getInnerPath(rect), Paint()..color = side.color);
  }

  @override
  ShapeBorder scale(double t) {
    return this; //
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return this; //
  }
}
