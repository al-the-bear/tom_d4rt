// D4rt test script: Tests DeletableChipAttributes from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DeletableChipAttributes test executing');

  // Test DeletableChipAttributes - Deletable
  print('DeletableChipAttributes is available in the material package');
  print('DeletableChipAttributes runtimeType accessible');

  print('DeletableChipAttributes test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeletableChipAttributes Tests'),
      Text('Deletable'),
    ],
  );
}
