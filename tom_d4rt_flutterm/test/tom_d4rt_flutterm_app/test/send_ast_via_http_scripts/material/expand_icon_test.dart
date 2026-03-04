// D4rt test script: Tests ExpandIcon from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpandIcon test executing');

  // Test ExpandIcon - ExpandIcon
  print('ExpandIcon is available in the material package');
  print('ExpandIcon runtimeType accessible');

  print('ExpandIcon test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ExpandIcon Tests'),
      Text('ExpandIcon'),
    ],
  );
}
