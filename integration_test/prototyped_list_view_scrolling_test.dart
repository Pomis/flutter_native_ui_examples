import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_keys.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_never_scrollable_slivers.dart';
import 'package:flutter_ui_examples/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> _test(WidgetTester tester, Widget child, String reportKey) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(child: child));

    await binding.traceAction(
      () async {
        await tester.drag(
          find.byKey(Key('scrollable')), const Offset(250, 0) // what you want to find
          // find.byKey(Key('scrollable')), // widget you want to scroll
          // const Offset(-250, 0), // delta to move
        );
      },
      retainPriorEvents: true,
      reportKey: reportKey,
    );
  }

  testWidgets('Scrolling with Slivers', (tester) async {
    await _test(tester, ListViewNeverScrollableSlivers(), 'scrolling_timeline_sliver');
  });

  testWidgets('Scrolling with shrink wrap', (tester) async {
    await _test(tester, ListViewShrinkWrap(), 'scrolling_timeline_shrink_wrap');
  });
}