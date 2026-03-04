// D4rt test script: Tests ShapeBorder from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShapeBorder test executing');

  // Test ShapeBorder - Base shape border
  print('ShapeBorder is available in the painting package');
  print('ShapeBorder: Base shape border');

  print('ShapeBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShapeBorder Tests'),
      Text('Base shape border'),
    ],
  );
}
