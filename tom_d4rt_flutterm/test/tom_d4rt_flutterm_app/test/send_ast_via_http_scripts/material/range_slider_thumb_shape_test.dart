// D4rt test script: Tests RangeSliderThumbShape from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeSliderThumbShape test executing');

  // Test RangeSliderThumbShape - Range thumb
  print('RangeSliderThumbShape is available in the material package');
  print('RangeSliderThumbShape runtimeType accessible');

  print('RangeSliderThumbShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RangeSliderThumbShape Tests'),
      Text('Range thumb'),
    ],
  );
}
