import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_keys.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_never_scrollable_slivers.dart';
import 'package:flutter_ui_examples/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();


  final shrinkWrap = Scaffold(
    body: SafeArea(
      child: ListView.builder(
        key: Key('scrollable'),
        itemCount: 1000,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
              key: index == 999 ? ValueKey("last_item") : null,
              child: Text(index.toString()));
        },
      ),
    ),
  );

  final shrinkWrapAndNeverScrollable = Scaffold(
    body: SafeArea(
      child: ListView(
        key: Key('scrollable'),
        primary: true,
        children: [
          ListView.builder(
            itemCount: 1000,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // print("building item #${index}");
              return Card(
                  key: index == 999 ? ValueKey("last_item") : null,
                  child: Text(index.toString()));
            },
          ),
        ],
      ),
    ),
  );

  final slivers = Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          key: const Key('scrollable'),
          slivers: [
            const SliverToBoxAdapter(child: Card(child: Text("Header card"))),
            SliverList.builder(
              itemCount: 1000,
              itemBuilder: (context, index) {
                // print("building item #${index}");
                return Card(child: Text(index.toString()));
              },
            ),
            const SliverToBoxAdapter(
                child: Card(
                    key: ValueKey('last_item'), child: Text("Footer card"))),
          ],
        ),
      ),
    );

  final sliversPrototype = ListViewNeverScrollableSlivers();


  Future<void> _test(
      WidgetTester tester, Widget child, String reportKey) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(child: child));
    await tester.pumpAndSettle();

    await binding.traceAction(
      () async {
        // Scroll until the item to be found appears.
        await tester.scrollUntilVisible(
          find.byKey(ValueKey('last_item')),
          150.0,
          scrollable: find.byType(Scrollable).at(0),
          maxScrolls: 1000,
        );
        await tester.pump();
      },
      retainPriorEvents: true,
      reportKey: reportKey,
    );
    await Future.delayed(const Duration(seconds: 1));
  }

  testWidgets('Scrolling with Slivers', (tester) async {
    await _test(tester, shrinkWrapAndNeverScrollable, 'scrolling_timeline_shrink_wrap_never_scrollable');
    await _test(tester, shrinkWrap, 'scrolling_timeline_shrink_wrap');
    await _test(tester, slivers, 'scrolling_timeline_sliver');
    await _test(tester, sliversPrototype, 'scrolling_timeline_slivers_prototype');  
  });
}
