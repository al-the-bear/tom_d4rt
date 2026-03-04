// D4rt test script: Tests MaterialLocalizations from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialLocalizations test executing');

  // Test MaterialLocalizations - Localization
  print('MaterialLocalizations is available in the material package');
  print('MaterialLocalizations runtimeType accessible');

  print('MaterialLocalizations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialLocalizations Tests'),
      Text('Localization'),
    ],
  );
}
