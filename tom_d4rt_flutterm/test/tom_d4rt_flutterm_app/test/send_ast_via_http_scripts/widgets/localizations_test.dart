// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Localizations, DefaultWidgetsLocalizations from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Localizations test executing');

  // Access locale from context
  try {
    final locale = Localizations.localeOf(context);
    print('Localizations.localeOf(context) accessed');
    print('Locale: $locale');
    print('Locale languageCode: ${locale.languageCode}');
    print('Locale countryCode: ${locale.countryCode}');
    print('Locale scriptCode: ${locale.scriptCode}');
  } catch (e) {
    print('Localizations.localeOf(context) error: $e');
  }

  // Test Locale construction
  final locale1 = Locale('en');
  print('Locale(en) created: $locale1');
  print('Locale languageCode: ${locale1.languageCode}');

  final locale2 = Locale('en', 'US');
  print('Locale(en, US) created: $locale2');
  print('Locale countryCode: ${locale2.countryCode}');

  final locale3 = Locale('de', 'DE');
  print('Locale(de, DE) created: $locale3');

  final locale4 = Locale('ja');
  print('Locale(ja) created: $locale4');

  // DefaultWidgetsLocalizations is the default implementation
  print('DefaultWidgetsLocalizations provides default text direction');

  // Test MaterialApp with locale setting
  final localizedApp = MaterialApp(
    locale: Locale('en', 'US'),
    supportedLocales: [Locale('en', 'US'), Locale('de', 'DE'), Locale('ja')],
    home: Builder(
      builder: (innerContext) {
        final innerLocale = Localizations.localeOf(innerContext);
        print('Inner locale: $innerLocale');
        print('Inner locale languageCode: ${innerLocale.languageCode}');
        return Scaffold(
          appBar: AppBar(title: Text('Localizations Test')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Current locale: $innerLocale'),
                Text('Language: ${innerLocale.languageCode}'),
                Text('Country: ${innerLocale.countryCode}'),
                SizedBox(height: 16.0),
                Text('Supported: en_US, de_DE, ja'),
              ],
            ),
          ),
        );
      },
    ),
  );
  print('MaterialApp with locale and supportedLocales created');

  // Test Localizations widget directly
  final localizationsWidget = Localizations(
    locale: Locale('fr', 'FR'),
    delegates: [
      DefaultWidgetsLocalizations.delegate,
      DefaultMaterialLocalizations.delegate,
    ],
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Localizations widget with fr_FR locale'),
    ),
  );
  print('Localizations widget with locale fr_FR created');

  print('Localizations test completed');
  return localizedApp;
}
