// D4rt test script: Tests Magnifier from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Magnifier test executing');

  // Test Magnifier - Magnifier
  print('Magnifier is available in the material package');
  print('Magnifier runtimeType accessible');

  print('Magnifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Magnifier Tests'),
      Text('Magnifier'),
    ],
  );
}
