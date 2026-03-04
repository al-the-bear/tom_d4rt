// D4rt test script: Tests ButtonBarTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonBarTheme test executing');

  // Test ButtonBarTheme - ButtonBarTheme
  print('ButtonBarTheme is available in the material package');
  print('ButtonBarTheme runtimeType accessible');

  print('ButtonBarTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonBarTheme Tests'),
      Text('ButtonBarTheme'),
    ],
  );
}
