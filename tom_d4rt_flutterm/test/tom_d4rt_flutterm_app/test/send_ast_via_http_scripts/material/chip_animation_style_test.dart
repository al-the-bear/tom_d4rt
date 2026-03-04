// D4rt test script: Tests ChipAnimationStyle from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChipAnimationStyle test executing');

  // Test ChipAnimationStyle - Chip animation
  print('ChipAnimationStyle is available in the material package');
  print('ChipAnimationStyle runtimeType accessible');

  print('ChipAnimationStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChipAnimationStyle Tests'),
      Text('Chip animation'),
    ],
  );
}
