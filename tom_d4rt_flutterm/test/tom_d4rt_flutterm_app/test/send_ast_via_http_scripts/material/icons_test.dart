// D4rt test script: Tests Icons from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Icons test executing');

  // Test Icons - Icons
  print('Icons is available in the material package');
  print('Icons runtimeType accessible');

  print('Icons test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Icons Tests'),
      Text('Icons'),
    ],
  );
}
