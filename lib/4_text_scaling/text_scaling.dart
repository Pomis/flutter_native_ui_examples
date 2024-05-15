import 'package:flutter/material.dart';
import 'package:i18n/strings.g.dart';

class TextScaling extends StatelessWidget {
  const TextScaling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Text Scaling example",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Insets.medium(context),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Hello, User!"),
                  SizedBox(width: Dimens.large(context)),
                  Expanded(
                    child: Text(
                      Dimens.isSmallWidth(context)
                          ? t.tasksDoneShort(n: 10, completed: 5)
                          : t.tasksDone(n: 10, completed: 5),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 100),
                child: const Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleText("Item A", style: TextStyle(fontSize: 30)),
                        Text("Subtitle", maxLines: 1),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimens.medium(context)),
              const Row(children: [
                _RowCard(),
                _RowCard(),
                _RowCard(),
              ]),
              const Row(children: [
                _RowCardSubtitle(subtitle: "1 user"),
                _RowCardSubtitle(subtitle: "3 users"),
                _RowCardSubtitle(subtitle: "1234123 users"),
              ]),
              SizedBox(height: Dimens.medium(context)),
              const Text(
                "Text C: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                maxLines: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowCard extends StatelessWidget {
  const _RowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Center(
          child: Padding(
            padding: Insets.medium(context),
            child: TitleText(
              "Item B",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

class _RowCardSubtitle extends StatelessWidget {
  final String subtitle;

  const _RowCardSubtitle({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Center(
          child: Padding(
            padding: Insets.medium(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  "Item D",
                  style: TextStyle(fontSize: 24),
                ),
                Text(subtitle, style: TextStyle(fontSize: 11), maxLines: 1)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dimens {
  static const smallScreenThreshold = 300;
  static bool isSmallWidth(BuildContext context) {
    return MediaQuery.of(context).size.width /
            MediaQuery.textScalerOf(context).scale(1) <
        smallScreenThreshold;
  }

  static double small(BuildContext context) => isSmallWidth(context) ? 4 : 8;
  static double medium(BuildContext context) => isSmallWidth(context) ? 8 : 16;
  static double large(BuildContext context) => isSmallWidth(context) ? 16 : 32;
}

class Insets {
  static EdgeInsets small(BuildContext context) =>
      EdgeInsets.all(Dimens.small(context));

  static EdgeInsets medium(BuildContext context) =>
      EdgeInsets.all(Dimens.medium(context));

  static EdgeInsets large(BuildContext context) =>
      EdgeInsets.all(Dimens.large(context));
}

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const TitleText(this.text, {required this.style, super.key});

  static const double maxRealFontSize = 30;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.textScalerOf(context).scale(style.fontSize!) >
        maxRealFontSize) {
      return Text(
        text,
        style: style.copyWith(
          fontSize: maxRealFontSize / MediaQuery.textScalerOf(context).scale(1),
        ),
      );
    }
    return Text(text, style: style);
  }
}


        // "tasksDone(rich)": {
        //     "one": "You have done $completed of $n tasks",
        //     "other": "You have done $completed of $n tasks"
        // },
        // "tasksDone(rich)": {
        //     "one": "$completed/$n tasks done",
        //     "other": "$completed/$n tasks done"
        // },