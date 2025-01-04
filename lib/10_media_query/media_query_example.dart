import 'package:flutter/material.dart';

class MediaQueryExample extends StatelessWidget {
  const MediaQueryExample({super.key});

  @override
  Widget build(BuildContext context) {
    print("----");
    print("size: ${MediaQuery.sizeOf(context)}");
    print("viewInsets: ${MediaQuery.viewInsetsOf(context)}");
    print("viewPadding: ${MediaQuery.viewPaddingOf(context)}");
    print("padding: ${MediaQuery.paddingOf(context)}");
    
    final element = context.getElementForInheritedWidgetOfExactType<MediaQuery>();
    
    DefaultTextStyle.of(context);
    final defaultTextStyleElement = context.getElementForInheritedWidgetOfExactType<DefaultTextStyle>();
    // MediaQuery.displayFeaturesOf(context); android only
    return Scaffold(

    );
  }
}