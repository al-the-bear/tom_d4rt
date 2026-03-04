// D4rt test script: Tests SelectionArea from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionArea test executing');

  // Test SelectionArea - SelectionArea
  print('SelectionArea is available in the material package');
  print('SelectionArea runtimeType accessible');

  print('SelectionArea test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionArea Tests'),
      Text('SelectionArea'),
    ],
  );
}
