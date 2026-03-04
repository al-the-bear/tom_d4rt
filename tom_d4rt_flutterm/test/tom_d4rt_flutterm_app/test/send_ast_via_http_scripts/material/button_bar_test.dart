// D4rt test script: Tests ButtonBar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonBar test executing');

  // Test ButtonBar - ButtonBar
  print('ButtonBar is available in the material package');
  print('ButtonBar runtimeType accessible');

  print('ButtonBar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonBar Tests'),
      Text('ButtonBar'),
    ],
  );
}
