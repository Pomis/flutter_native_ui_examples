import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ui_examples/10_media_query/media_query_example.dart';
import 'package:flutter_ui_examples/12_gestures/custom_tap_detector.dart';
import 'package:flutter_ui_examples/12_gestures/gestures_page.dart';
import 'package:flutter_ui_examples/1_tap_effects/tap_area_example.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_keys.dart';
import 'package:flutter_ui_examples/3_list_view_mistakes/list_view_never_scrollable_slivers.dart';
import 'package:flutter_ui_examples/5_localization/localization_example.dart';
import 'package:flutter_ui_examples/6_widget_state_property/widget_state_property_example.dart';
import 'package:flutter_ui_examples/7_images/images_example.dart';
import 'package:flutter_ui_examples/9_layers/layers_example.dart';

import '2_adaptive_refresh_indicator/adaptive_refresh_indicator_example.dart';
import '2_adaptive_refresh_indicator_advanced/adaptive_refresh_indicator_example.dart';
import '3_list_view_mistakes/list_view_extent.dart';
import '3_list_view_mistakes/list_view_padding.dart';
import '4_text_scaling/text_scaling.dart';
import '7_images/images_example_list.dart';
import '8_shapes/shapes_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Widget? child;

  const MyApp({super.key, this.child});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          switchTheme: SwitchThemeData(
            trackOutlineColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? Colors.white
                  : null;
            }),
            trackOutlineWidth: WidgetStateProperty.all(1.0),
          )),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', ''),
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocale != null &&
              deviceLocale.languageCode == locale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      builder: (_, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          gestureSettings: const DeviceGestureSettings(touchSlop: 30),
          textScaler: MediaQuery.of(context)
              .textScaler
              .clamp(minScaleFactor: 0.8, maxScaleFactor: 1.6),
        ),
        child: child!,
      ),
      home: child ?? const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("01. Tap Area"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return TapAreaExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("02. Refresh Indicator"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AdaptiveRefreshIndicatorExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("02. Refresh Indicator — Slivers"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AdaptiveRefreshIndicatorExample2();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("03. ListView — Never Scrollable Physics (Slivers)"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ListViewNeverScrollableSlivers();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("03. ListView — Extent"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ListViewExtent();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("03. ListView — Padding"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ListViewPadding();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("04. ListView — Keys"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ListViewKeys.noKeys();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("04. TextScaling"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return TextScaling();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("05. Localization"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LocalizationExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("06. Widget State Properties"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return WidgetStatePropertyExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("07. Images"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ImagesExampleList();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("08. Shapes"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ShapesExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("09. Layers"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LayersExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("10. MediaQuery"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MediaQueryExample();
                  },
                ));
              },
            ),
            TextButton(
              child: Text("12. Gestures"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return GesturesPage();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
