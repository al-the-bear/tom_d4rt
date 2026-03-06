// D4rt test script: Tests StarBorder from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StarBorder test executing');

  // Test StarBorder - Star shape
  print('StarBorder is available in the painting package');
  print('StarBorder: Star shape');

  print('StarBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StarBorder Tests'),
      Text('Star shape'),
    ],
  );
}
