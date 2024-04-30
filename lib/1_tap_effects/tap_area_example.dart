import 'package:flutter/material.dart';
import 'package:flutter_ui_examples/1_tap_effects/tap_area.dart';

class TapAreaExample extends StatelessWidget {
  const TapAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: TapArea(
                  onTap: () {},
                  borderRadius: 12,
                  padding: const EdgeInsets.all(16),
                  child: const ListTile(
                    leading: Icon(Icons.data_object),
                    title: Text("Title"),
                    subtitle: Text("Subtitle"),
                    trailing: Text("30.04.2024"),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(16),
                child: TapArea(
                  onTap: () {},
                  borderRadius: 12,
                  padding: const EdgeInsets.all(16),
                  child: const ListTile(
                    leading: Icon(Icons.data_object),
                    title: Text("Title"),
                    subtitle: Text("Subtitle"),
                    trailing: Text("30.04.2024"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
