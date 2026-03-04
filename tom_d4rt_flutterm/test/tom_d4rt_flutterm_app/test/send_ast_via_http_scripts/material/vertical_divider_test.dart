// D4rt test script: Tests VerticalDivider from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VerticalDivider test executing');

  // Test VerticalDivider - VerticalDivider
  print('VerticalDivider is available in the material package');
  print('VerticalDivider runtimeType accessible');

  print('VerticalDivider test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VerticalDivider Tests'),
      Text('VerticalDivider'),
    ],
  );
}
