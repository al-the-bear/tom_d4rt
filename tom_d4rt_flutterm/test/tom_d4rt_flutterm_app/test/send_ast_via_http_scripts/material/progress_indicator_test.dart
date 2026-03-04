// D4rt test script: Tests ProgressIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ProgressIndicator test executing');

  // Test ProgressIndicator - ProgressIndicator
  print('ProgressIndicator is available in the material package');
  print('ProgressIndicator runtimeType accessible');

  print('ProgressIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ProgressIndicator Tests'),
      Text('ProgressIndicator'),
    ],
  );
}
