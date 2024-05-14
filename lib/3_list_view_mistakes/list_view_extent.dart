import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewExtent extends StatelessWidget {
  const ListViewExtent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1000,
          prototypeItem: const Card(child: Text("")),
          itemBuilder: (context, index) {
            return Card(child: Text(index.toString()));
          },
        ),
      ),
    );
  }
}
