import 'package:flutter/material.dart';

class ImagesExample extends StatelessWidget {
  final Widget child;
  const ImagesExample(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images Example"),
      ),
      body: Column(
        children: [
          child,
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    PaintingBinding.instance.imageCache.currentSizeBytes
                        .toString(),
                  ),
                ),
              );
            },
            child: Text("Check cache"),
          )
        ],
      ),
    );
  }
}


