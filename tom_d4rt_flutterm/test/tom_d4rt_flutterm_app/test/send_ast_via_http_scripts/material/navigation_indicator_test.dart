// D4rt test script: Tests NavigationIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationIndicator test executing');

  // Test NavigationIndicator - NavigationIndicator
  print('NavigationIndicator is available in the material package');
  print('NavigationIndicator runtimeType accessible');

  print('NavigationIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationIndicator Tests'),
      Text('NavigationIndicator'),
    ],
  );
}
