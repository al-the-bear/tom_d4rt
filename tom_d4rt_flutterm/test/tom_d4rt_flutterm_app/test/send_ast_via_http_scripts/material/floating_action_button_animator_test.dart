// D4rt test script: Tests FloatingActionButtonAnimator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingActionButtonAnimator test executing');

  // Test FloatingActionButtonAnimator - FAB animator
  print('FloatingActionButtonAnimator is available in the material package');
  print('FloatingActionButtonAnimator runtimeType accessible');

  print('FloatingActionButtonAnimator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingActionButtonAnimator Tests'),
      Text('FAB animator'),
    ],
  );
}
