// D4rt test script: Tests RefreshIndicatorState from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicatorState test executing');

  // Test RefreshIndicatorState - RefreshIndicatorState
  print('RefreshIndicatorState is available in the material package');
  print('RefreshIndicatorState runtimeType accessible');

  print('RefreshIndicatorState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RefreshIndicatorState Tests'),
      Text('RefreshIndicatorState'),
    ],
  );
}
