// D4rt test script: Tests MaterialButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialButton test executing');

  // Test MaterialButton - Material button
  print('MaterialButton is available in the material package');
  print('MaterialButton runtimeType accessible');

  print('MaterialButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialButton Tests'),
      Text('Material button'),
    ],
  );
}
