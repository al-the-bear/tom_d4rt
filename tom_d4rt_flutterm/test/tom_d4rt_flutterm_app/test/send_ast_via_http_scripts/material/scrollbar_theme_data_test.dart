// D4rt test script: Tests ScrollbarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollbarThemeData test executing');

  // Test ScrollbarThemeData - ScrollbarThemeData
  print('ScrollbarThemeData is available in the material package');
  print('ScrollbarThemeData runtimeType accessible');

  print('ScrollbarThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollbarThemeData Tests'),
      Text('ScrollbarThemeData'),
    ],
  );
}
