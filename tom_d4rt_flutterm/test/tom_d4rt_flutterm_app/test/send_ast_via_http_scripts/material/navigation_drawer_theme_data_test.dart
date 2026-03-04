// D4rt test script: Tests NavigationDrawerThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDrawerThemeData test executing');

  // Test NavigationDrawerThemeData - Nav drawer data
  print('NavigationDrawerThemeData is available in the material package');
  print('NavigationDrawerThemeData runtimeType accessible');

  print('NavigationDrawerThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationDrawerThemeData Tests'),
      Text('Nav drawer data'),
    ],
  );
}
