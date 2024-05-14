import 'package:flutter/material.dart';

class ListViewNeverScrollableSlivers extends StatelessWidget {
  const ListViewNeverScrollableSlivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: Card(child: Text("Header card"))),
            SliverPrototypeExtentList.builder(
              itemBuilder: (context, index) {
                print("building item #${index}");
                return Card(child: Text(index.toString()));
              },
              prototypeItem: const Card(child: Text("")),
            ),
            const SliverToBoxAdapter(child: Card(child: Text("Footer card"))),
          ],
        ),
      ),
    );
  }
}
