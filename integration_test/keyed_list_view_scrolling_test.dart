import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_keys.dart';
import 'package:flutter_ui_examples/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> _test(
      WidgetTester tester, Widget child, String reportKey) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(child: child));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('last_item'));

    await binding.traceAction(
      () async {
        // Scroll until the item to be found appears.
        await tester.scrollUntilVisible(
          itemFinder,
          150.0,
          scrollable: listFinder,
          maxScrolls: 1000,
        );
      },
      retainPriorEvents: true,
      reportKey: reportKey,
    );
  }

  testWidgets('Scrolling test no keys', (tester) async {
    await _test(tester, ListViewKeys.noKeys(), 'scrolling_timeline_no_keys');
  });

  testWidgets('Scrolling test global keys', (tester) async {
    await _test(
        tester, ListViewKeys.globalKeys(), 'scrolling_timeline_global_keys');
  });

  testWidgets('Scrolling test value keys', (tester) async {
    await _test(
        tester, ListViewKeys.valueKeys(), 'scrolling_timeline_value_keys');
  });
}
