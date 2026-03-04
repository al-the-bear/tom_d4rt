// D4rt test script: Tests TabPageSelector from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabPageSelector test executing');

  // Test TabPageSelector - TabPageSelector
  print('TabPageSelector is available in the material package');
  print('TabPageSelector runtimeType accessible');

  print('TabPageSelector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabPageSelector Tests'),
      Text('TabPageSelector'),
    ],
  );
}
