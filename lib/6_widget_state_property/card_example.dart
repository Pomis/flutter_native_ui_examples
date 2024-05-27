import 'package:flutter/material.dart';

class CardExample extends StatefulWidget {
  const CardExample({super.key});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  final _controller = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, states, _) {
        return Card(
          elevation: states.contains(WidgetState.hovered) ? 4 : 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text("Text"),
                TextButton(
                  statesController: _controller,
                  onPressed: _onPressed, 
                  child: const Text("Button"),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _onPressed() {

  }
}

