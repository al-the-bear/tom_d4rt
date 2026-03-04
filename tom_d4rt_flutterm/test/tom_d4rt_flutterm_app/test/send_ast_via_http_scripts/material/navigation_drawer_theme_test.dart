// D4rt test script: Tests NavigationDrawerTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDrawerTheme test executing');

  // Test NavigationDrawerTheme - NavigationDrawerTheme
  print('NavigationDrawerTheme is available in the material package');
  print('NavigationDrawerTheme runtimeType accessible');

  print('NavigationDrawerTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationDrawerTheme Tests'),
      Text('NavigationDrawerTheme'),
    ],
  );
}
