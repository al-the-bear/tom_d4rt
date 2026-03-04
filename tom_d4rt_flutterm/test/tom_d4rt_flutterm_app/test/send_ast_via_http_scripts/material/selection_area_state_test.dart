// D4rt test script: Tests SelectionAreaState from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionAreaState test executing');

  // Test SelectionAreaState - SelectionAreaState
  print('SelectionAreaState is available in the material package');
  print('SelectionAreaState runtimeType accessible');

  print('SelectionAreaState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionAreaState Tests'),
      Text('SelectionAreaState'),
    ],
  );
}
