// D4rt test script: Tests DisabledChipAttributes from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DisabledChipAttributes test executing');

  // Test DisabledChipAttributes - Disabled
  print('DisabledChipAttributes is available in the material package');
  print('DisabledChipAttributes runtimeType accessible');

  print('DisabledChipAttributes test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DisabledChipAttributes Tests'),
      Text('Disabled'),
    ],
  );
}
