import 'package:flutter/material.dart';
import 'adaptive_refresh_indicator.dart';

class AdaptiveRefreshIndicatorExample2 extends StatelessWidget {
  const AdaptiveRefreshIndicatorExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveRefreshIdicator2(
          slivers: [
            SliverList.builder(
              itemCount: 1000,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(index.toString()),
                );
              },
            )
          ],
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 3));
          }),
    );
  }
}
