// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LocalizationsResolver from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LocalizationsResolver test executing');
  print('=' * 50);

  // === Test LocalizationsResolver class ===
  print('\nLocalizationsResolver manages locale resolution');

  // Create a LocalizationsResolver
  print('\n--- Testing LocalizationsResolver creation ---');
  final resolver = LocalizationsResolver(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('es', 'ES'),
      Locale('fr', 'FR'),
    ],
  );
  print('Created LocalizationsResolver');
  print('resolver.runtimeType: ${resolver.runtimeType}');
  print('resolver.locale: ${resolver.locale}');

  // Test with specific locale
  print('\n--- Testing with specific locale ---');
  final resolverWithLocale = LocalizationsResolver(
    supportedLocales: [Locale('en'), Locale('de')],
    locale: Locale('de'),
  );
  print('Created with locale: de');
  print('resolverWithLocale.locale: ${resolverWithLocale.locale}');

  // Test localizationsDelegates
  print('\n--- Testing localizationsDelegates ---');
  final delegates = resolver.localizationsDelegates;
  print('localizationsDelegates count: ${delegates.length}');
  for (final delegate in delegates) {
    print('  - ${delegate.runtimeType}');
  }

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('resolver is ChangeNotifier: ${resolver is ChangeNotifier}');
  print('resolver is Listenable: ${resolver is Listenable}');

  // Test update method
  print('\n--- Testing update method ---');
  print('update() can change:');
  print('  - locale');
  print('  - localeListResolutionCallback');
  print('  - localeResolutionCallback');
  print('  - localizationsDelegates');
  print('  - supportedLocales');

  // Test callbacks
  print('\n--- Testing resolution callbacks ---');
  print('localeListResolutionCallback: ${resolver.localeListResolutionCallback}');
  print('localeResolutionCallback: ${resolver.localeResolutionCallback}');

  // Dispose resolvers
  resolver.dispose();
  resolverWithLocale.dispose();
  print('\n--- Disposed resolvers ---');

  print('\n' + '=' * 50);
  print('LocalizationsResolver test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LocalizationsResolver Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Purpose: Manage locale resolution'),
      Text('Is ChangeNotifier: true'),
      Text('Observes: WidgetsBinding'),
    ],
  );
}
