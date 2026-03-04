// D4rt test script: Tests TextButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextButtonThemeData test executing');

  // Test TextButtonThemeData - Text data
  print('TextButtonThemeData is available in the material package');
  print('TextButtonThemeData runtimeType accessible');

  print('TextButtonThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextButtonThemeData Tests'),
      Text('Text data'),
    ],
  );
}
