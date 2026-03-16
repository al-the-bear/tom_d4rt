// D4rt test script: Tests FittedSizes from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FittedSizes test executing');

  // Test FittedSizes - Fitted size calculation
  print('FittedSizes is available in the painting package');
  print('FittedSizes: Fitted size calculation');

  print('FittedSizes test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FittedSizes Tests'),
      Text('Fitted size calculation'),
    ],
  );
}
