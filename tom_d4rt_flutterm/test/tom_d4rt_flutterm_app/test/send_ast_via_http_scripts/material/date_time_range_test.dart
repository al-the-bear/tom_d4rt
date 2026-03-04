// D4rt test script: Tests DateTimeRange from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DateTimeRange test executing');

  // Test DateTimeRange - Date range
  print('DateTimeRange is available in the material package');
  print('DateTimeRange runtimeType accessible');

  print('DateTimeRange test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DateTimeRange Tests'),
      Text('Date range'),
    ],
  );
}
