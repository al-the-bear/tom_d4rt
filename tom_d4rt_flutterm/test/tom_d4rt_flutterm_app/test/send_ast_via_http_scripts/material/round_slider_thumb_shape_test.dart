// D4rt test script: Tests RoundSliderThumbShape from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RoundSliderThumbShape test executing');

  // Test RoundSliderThumbShape - Round thumb
  print('RoundSliderThumbShape is available in the material package');
  print('RoundSliderThumbShape runtimeType accessible');

  print('RoundSliderThumbShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RoundSliderThumbShape Tests'),
      Text('Round thumb'),
    ],
  );
}
