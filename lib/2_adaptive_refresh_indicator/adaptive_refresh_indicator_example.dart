import 'package:flutter/material.dart';
import 'package:flutter_ui_examples/2_adaptive_refresh_indicator/adaptive_refresh_indicator.dart';

class AdaptiveRefreshIndicatorExample extends StatelessWidget {
  const AdaptiveRefreshIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Refresh page")),
      body: AdaptiveRefreshIdicator(
          child: Column(children: [
            ...List.generate(
              20,
              (index) => const ListTile(
                title: Text("item"),
              ),
            )
          ]),
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 3));
          }),
    );
  }
}
