import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_examples/main.dart';

void main() {
  testWidgets('Check elements', (tester) async {
    await tester.pumpWidget(Container(
      color: Colors.red,
    ));
    tester.allElements;
    tester.allRenderObjects;
    tester.allWidgets;
    tester.allStates;
    tester.layers;

  });
}