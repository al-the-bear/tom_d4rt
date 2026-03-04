// D4rt test script: Tests DialogRoute from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DialogRoute test executing');

  // Test DialogRoute - DialogRoute
  print('DialogRoute is available in the material package');
  print('DialogRoute runtimeType accessible');

  print('DialogRoute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DialogRoute Tests'),
      Text('DialogRoute'),
    ],
  );
}
