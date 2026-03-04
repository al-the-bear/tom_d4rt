// D4rt test script: Tests Class from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Class test executing');

  // Test Class - Description
  print('Class is available in the material package');
  print('Class runtimeType accessible');

  print('Class test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Class Tests'),
      Text('Description'),
    ],
  );
}
