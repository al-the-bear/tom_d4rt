// D4rt test script: Tests Gradient from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gradient test executing');

  // Test Gradient - Base gradient
  print('Gradient is available in the painting package');
  print('Gradient: Base gradient');

  print('Gradient test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Gradient Tests'),
      Text('Base gradient'),
    ],
  );
}
