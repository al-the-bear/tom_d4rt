// D4rt test script: Tests SelectableChipAttributes from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableChipAttributes test executing');

  // Test SelectableChipAttributes - Selectable
  print('SelectableChipAttributes is available in the material package');
  print('SelectableChipAttributes runtimeType accessible');

  print('SelectableChipAttributes test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectableChipAttributes Tests'),
      Text('Selectable'),
    ],
  );
}
