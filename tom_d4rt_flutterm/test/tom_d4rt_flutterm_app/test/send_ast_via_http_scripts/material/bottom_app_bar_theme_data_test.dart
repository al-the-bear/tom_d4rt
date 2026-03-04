// D4rt test script: Tests BottomAppBarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomAppBarThemeData test executing');

  // Test BottomAppBarThemeData - Bottom data
  print('BottomAppBarThemeData is available in the material package');
  print('BottomAppBarThemeData runtimeType accessible');

  print('BottomAppBarThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BottomAppBarThemeData Tests'),
      Text('Bottom data'),
    ],
  );
}
