import 'package:flutter/material.dart';

class LayersExample extends StatelessWidget {
  const LayersExample({super.key});

  @override
  Widget build(BuildContext context) {
    return _RepaintBoundaryExample();

    return Scaffold(
      appBar: AppBar(title: Text("Layers example")),
      body: Column(children: [
        
        RepaintBoundary(
          child: CircularProgressIndicator()
        ),

        // ColorFiltered(
        //   colorFilter: ColorFilter.mode(Colors.red, BlendMode.difference),
        //   child: Opacity(
        //     opacity: 0.9,
        //     child: Image.asset(
        //       "assets/6392956.jpg",
        //       height: 100,
        //       width: 300,
        //       cacheHeight:
        //           (300 * MediaQuery.of(context).devicePixelRatio).toInt(),
        //     ),
        //   ),
        // ),
        // ColorFiltered(
        //   colorFilter: ColorFilter.mode(Colors.red, BlendMode.difference),
        //   child: Image.asset(
        //     "assets/6392956.jpg",
        //     height: 100,
        //     width: 300,
        //     cacheHeight:
        //         (300 * MediaQuery.of(context).devicePixelRatio).toInt(),
        //   ),
        // )
      ]),
      
    );
    // RepaintBoundary(child: Container());
    // RenderRepaintBoundary.debugAsymmetricPaintCount
    // RenderBox.;
  }
}

class _RepaintBoundaryExample extends StatelessWidget {
  const _RepaintBoundaryExample({super.key});

  @override
  Widget build(BuildContext context) {
    // debugDumpLayerTree();
    // debugDumpRenderTree();
    return Scaffold(
      appBar: AppBar(title: Text("Layers example")),
      body: Column(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: RepaintBoundary(
              child: CircularProgressIndicator()
            ),
          ),
        ),
        Text('Outer widget')
      ]),
    );
  }
}
