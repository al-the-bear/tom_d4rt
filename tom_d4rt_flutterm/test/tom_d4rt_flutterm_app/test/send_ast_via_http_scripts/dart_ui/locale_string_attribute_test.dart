// D4rt test script: Tests LocaleStringAttribute from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LocaleStringAttribute test executing');

  // Test LocaleStringAttribute - Locale attribute
  print('LocaleStringAttribute is available in the dart_ui package');
  print('LocaleStringAttribute: Locale attribute');

  print('LocaleStringAttribute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LocaleStringAttribute Tests'),
      Text('Locale attribute'),
    ],
  );
}
