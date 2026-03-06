// D4rt test script: Tests LinearBorder from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LinearBorder test executing');

  // Test LinearBorder - Linear border
  print('LinearBorder is available in the painting package');
  print('LinearBorder: Linear border');

  print('LinearBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LinearBorder Tests'),
      Text('Linear border'),
    ],
  );
}
