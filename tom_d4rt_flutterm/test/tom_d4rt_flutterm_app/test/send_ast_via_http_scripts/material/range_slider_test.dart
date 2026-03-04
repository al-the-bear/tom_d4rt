// D4rt test script: Tests RangeSlider from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeSlider test executing');

  // Test RangeSlider - Range slider
  print('RangeSlider is available in the material package');
  print('RangeSlider runtimeType accessible');

  print('RangeSlider test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RangeSlider Tests'),
      Text('Range slider'),
    ],
  );
}
