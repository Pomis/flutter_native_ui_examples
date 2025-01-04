import 'package:deferred_indexed_stack/deferred_indexed_stack.dart';
import 'package:flutter/material.dart';

class DeferredIndexedStackExample extends StatefulWidget {
  const DeferredIndexedStackExample({super.key});

  @override
  State<DeferredIndexedStackExample> createState() => _DeferredIndexedStackExampleState();
}

class _DeferredIndexedStackExampleState extends State<DeferredIndexedStackExample> {
  final _controller = DeferredIndexedStackController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.initChildAt(1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return Scaffold(
    //   body: DeferredIndexedStack(
    //     controller: _controller,
    //     children: [
    //       DeferredTab(child: TabA()),
    //       DeferredTab(
    //         id: tabB,
    //         child: TabB(),
    //       ),
    //       DeferredTab(
    //         id: tabC,
    //         child: TabC(),
    //       ),
    //       DeferredTab(
    //         id: tabD,
    //         deferredFor: Duration(seconds: 5),
    //         child: TabD(),
    //       ),
    //   ])
    // );
  }
}