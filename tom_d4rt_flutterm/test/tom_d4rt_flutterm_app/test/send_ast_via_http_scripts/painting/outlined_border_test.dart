// D4rt test script: Tests OutlinedBorder from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OutlinedBorder test executing');

  // Test OutlinedBorder - Shape with outline
  print('OutlinedBorder is available in the painting package');
  print('OutlinedBorder: Shape with outline');

  print('OutlinedBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OutlinedBorder Tests'),
      Text('Shape with outline'),
    ],
  );
}
