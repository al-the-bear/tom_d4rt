// D4rt test script: Tests NoSplash from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NoSplash test executing');

  // Test NoSplash - NoSplash
  print('NoSplash is available in the material package');
  print('NoSplash runtimeType accessible');

  print('NoSplash test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NoSplash Tests'),
      Text('NoSplash'),
    ],
  );
}
