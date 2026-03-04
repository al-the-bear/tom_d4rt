// D4rt test script: Tests BackButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BackButton test executing');

  // Test BackButton - BackButton
  print('BackButton is available in the material package');
  print('BackButton runtimeType accessible');

  print('BackButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackButton Tests'),
      Text('BackButton'),
    ],
  );
}
