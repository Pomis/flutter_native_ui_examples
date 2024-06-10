import 'package:flutter/material.dart';
import 'package:flutter_ui_examples/7_images/images_example.dart';

class ImagesExampleList extends StatelessWidget {
  const ImagesExampleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image examples"),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text("No cacheHeight"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ImagesExample(_OriginalSizedImage());
                },
              ));
            },
          ),
          TextButton(
            child: Text("cacheHeight: 100"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ImagesExample(_CacheHeightImage(100));
                },
              ));
            },
          ),
          TextButton(
            child: Text("cacheHeight: 500"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ImagesExample(_CacheHeightImage(500));
                },
              ));
            },
          ),
          TextButton(
            child: Text("Opacity Example"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return _OpacityExample();
                },
              ));
            },
          ),
          TextButton(
            child: Text("No Opacity Example"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return _NoOpacityExample();
                },
              ));
            },
          ),
TextButton(
  child: const Text("Precache image"),
  onPressed: () async {
    cacheSize() => PaintingBinding.instance.imageCache.currentSizeBytes.toString();
    print(cacheSize());
    final asset = Image.asset(
      "assets/6392956.jpg",
      height: 100,
      width: 300,
      cacheHeight: (100 * MediaQuery.of(context).devicePixelRatio).toInt(),
    );
    await precacheImage(asset.image, context);
    print(cacheSize());
  },
)
        ],
      ),
    );
  }
}

class _OpacityExample extends StatelessWidget {
  const _OpacityExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 10; i++)
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/6392956.jpg",
              height: 100,
              width: 300,
              cacheHeight:
                  (100 * MediaQuery.of(context).devicePixelRatio).toInt(),
            ),
          ),
      ],
    );
  }
}

class _NoOpacityExample extends StatelessWidget {
  const _NoOpacityExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 10; i++)
          Image.asset(
            "assets/6392956.jpg",
            height: 100,
            width: 300,
            color: Colors.white.withOpacity(0.5),
            colorBlendMode: BlendMode.modulate,
            cacheHeight:
                (100 * MediaQuery.of(context).devicePixelRatio).toInt(),
          ),
      ],
    );
  }
}

class _OriginalSizedImage extends StatelessWidget {
  const _OriginalSizedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/6392956.jpg",
      height: 100,
      width: 300,
    );
  }
}

class _CacheHeightImage extends StatelessWidget {
  final double height;
  const _CacheHeightImage(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/6392956.jpg",
      height: 100,
      width: 300,
      cacheHeight: (height * MediaQuery.of(context).devicePixelRatio).toInt(),
    );
  }
}
