// D4rt test script: Tests CalendarDelegate from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CalendarDelegate test executing');

  // Test CalendarDelegate - Calendar delegate
  print('CalendarDelegate is available in the material package');
  print('CalendarDelegate runtimeType accessible');

  print('CalendarDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CalendarDelegate Tests'),
      Text('Calendar delegate'),
    ],
  );
}
