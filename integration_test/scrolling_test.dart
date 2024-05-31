import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_keys.dart';
import 'package:flutter_ui_examples/main.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Scrolling test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(openListViewKeys: true));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('last_item'));

    await binding.traceAction(
      () async {
        // Scroll until the item to be found appears.
        await tester.scrollUntilVisible(
          itemFinder,
          1000.0,
          scrollable: listFinder,
        );
      },
      reportKey: 'scrolling_timeline',
    );
  });
}