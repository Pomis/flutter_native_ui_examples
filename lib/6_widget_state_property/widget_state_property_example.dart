import 'package:flutter/material.dart';
import 'package:flutter_ui_examples/6_widget_state_property/tap_area_2.dart';

import 'card_example.dart';

class WidgetStatePropertyExample extends StatefulWidget {
  const WidgetStatePropertyExample({super.key});

  @override
  State<WidgetStatePropertyExample> createState() =>
      _WidgetStatePropertyExampleState();
}

class _WidgetStatePropertyExampleState
    extends State<WidgetStatePropertyExample> {
  final _statesController = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const CardExample(),
              const SizedBox(height: 40),
              _ButtonExample(statesController: _statesController),
              const SizedBox(height: 40),
              TapArea2(
                style: TapAreaStyle(
                  opacity: WidgetStateProperty.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.pressed)) {
                        return 0.5;
                      }
                      if (states.contains(WidgetState.hovered)) {
                        return 0.9;
                      }
                      return 1.0;
                    },
                  ),
                  foregroundHighlight: WidgetStateProperty.resolveWith(
                    (states) {
                      if (states.contains(WidgetState.hovered)) {
                        return 0.1;
                      }
                      return 0.0;
                    },
                  ),
                ),
                padding: EdgeInsets.all(20),
                child: Text("Tap area"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonExample extends StatelessWidget {
  const _ButtonExample({
    super.key,
    required WidgetStatesController statesController,
  }) : _statesController = statesController;

  final WidgetStatesController _statesController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: _statesController,
      style: ButtonStyle(side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return const BorderSide(color: Colors.black);
        }
        if (states.contains(WidgetState.hovered)) {
          return const BorderSide(color: Colors.deepPurple);
        }
        return null;
      }), backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.black12;
        }
        return Colors.transparent;
      })),
      onPressed: () {},
      child: Text("ABC"),
    );
  }
}
