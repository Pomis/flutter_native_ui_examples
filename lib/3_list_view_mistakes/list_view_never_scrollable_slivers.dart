import 'package:flutter/material.dart';

class ListViewNeverScrollableSlivers extends StatelessWidget {
  final bool hasPrototype;

  const ListViewNeverScrollableSlivers({this.hasPrototype = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          key: const Key('scrollable'),
          slivers: [
            const SliverToBoxAdapter(child: Card(child: Text("Header card"))),
            SliverPrototypeExtentList.builder(
              itemCount: 1000,
              itemBuilder: (context, index) {
                print("building item #${index}");
                return Card(child: Text(index.toString()));
              },
              prototypeItem: const Card(child: Text("")),
            ),
            const SliverToBoxAdapter(child: Card(key: ValueKey('last_item'), child: Text("Footer card"))),
          ],
        ),
      ),
    );
  }
}


// Below is an example of how not to do:
class ListViewShrinkWrap extends StatelessWidget {
  const ListViewShrinkWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          key: const Key('scrollable'),
          child: Column(
            children: [
              const Card(child: Text("Header card")),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1000,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print("building item #${index}");
                  return Card(child: Text(index.toString()));
                },
              ),
              const Card(key: ValueKey('last_item'), child: Text("Footer card")),
            ],
          ),
        ) ,
      ),
    );
  }
}
