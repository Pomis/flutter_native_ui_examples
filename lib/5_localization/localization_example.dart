import 'package:flutter/material.dart';
import 'package:i18n/strings.g.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';

class LocalizationExample extends StatefulWidget {
  const LocalizationExample({super.key});

  @override
  State<LocalizationExample> createState() => _LocalizationExampleState();
}

class _LocalizationExampleState extends State<LocalizationExample> {
  @override
  void initState() {
    super.initState();
    _printCurrencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _printDates());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Localization example")),
      body: Column(
        children: [
          StyledText(
            text: t.agreeWithTerms,
            style: Theme.of(context).textTheme.bodyMedium,
            tags: {
              'a': StyledTextActionTag(
                (String? text, Map<String?, String?> attrs) {
                  final action = attrs['action'];
                  switch (action) {
                    case 'OPEN_TC':
                      _openTC();
                    case 'OPEN_PP':
                      _openPP();
                  }
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline),
              )
            },
          ),
          Text(t.usersOnline(n: 3)),
        ],
      ),
    );
  }

  void _openTC() {
    print("open TC");
  }

  void _openPP() {
    print("open PP");
  }

  void _printDates() {
    final date = DateTime.now();
    format(String locale) => "$locale: ${DateFormat.yMMMEd(locale).format(date)}}";
    print(format("en_US"));
    print(format("en_GB"));
    print(format("et_EE"));
    print(format("fi_FI"));
    print(format("ar_QA"));
    print(TimeOfDay.now().format(context));
  }
  
  void _printCurrencies() {
    print(NumberFormat.simpleCurrency(locale: 'en_US', name: 'USD').format(199.99));
    print(NumberFormat.simpleCurrency(locale: 'en_GB', name: 'GBP').format(199.99));
    print(NumberFormat.simpleCurrency(locale: 'es_ES', name: 'EUR').format(199.99));
  }

  String explicitFormat(String currencyCode, String? locale, num amount) {
    final shortFormat = NumberFormat.simpleCurrency(locale: locale, name: currencyCode).format(amount);

    return "$shortFormat $currencyCode";
  }
}
