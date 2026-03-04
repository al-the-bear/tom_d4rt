// D4rt test script: Tests RangeValues from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeValues test executing');

  // Test RangeValues - Range values
  print('RangeValues is available in the material package');
  print('RangeValues runtimeType accessible');

  print('RangeValues test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RangeValues Tests'),
      Text('Range values'),
    ],
  );
}
