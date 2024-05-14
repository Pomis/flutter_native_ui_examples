import 'package:flutter/material.dart';

class ListViewPadding extends StatelessWidget {
  const ListViewPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView with padding"),),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1000,
          padding: const EdgeInsets.all(40),
          prototypeItem: const Card(child: Text("")),
          itemBuilder: (context, index) {
            return Card(child: Text(index.toString()));
          },
        ),
      ),
    );
  }
}