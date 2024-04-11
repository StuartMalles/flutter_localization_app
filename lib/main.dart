import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Localization',
      localizationsDelegates: AppLocalizations.localizationsDelegates +
          [const LocaleNamesLocalizationsDelegate()],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyHome(),
    );
  }
}

// ignore: must_be_immutable
class MyHome extends StatefulWidget {
  MyHome({super.key});
  String? language;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    // Default the initial language code
    if (widget.language == null) {
      Locale systemLocal = Localizations.localeOf(context);
      if (AppLocalizations.supportedLocales.contains(systemLocal)) {
        widget.language = systemLocal.languageCode;
      } else {
        widget.language = AppLocalizations.supportedLocales.first.languageCode;
      }
    }

    List<DropdownMenuItem> localeMenuItems = [];

    // List the supported locales
    for (var element in AppLocalizations.supportedLocales) {
      localeMenuItems.add(DropdownMenuItem(
        value: element.languageCode,
        child: Text(LocaleNames.of(context)!.nameOf(element.languageCode) ??
            element.languageCode),
      ));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Localizations.override(
              context: context,
              locale: Locale(widget.language!),
              child: Builder(builder: (context) {
                return Text(AppLocalizations.of(context).helloUser);
              }),
            ),
            DropdownButton(
              value: widget.language,
              items: localeMenuItems,
              onChanged: (value) {
                setState(() {
                  widget.language = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
