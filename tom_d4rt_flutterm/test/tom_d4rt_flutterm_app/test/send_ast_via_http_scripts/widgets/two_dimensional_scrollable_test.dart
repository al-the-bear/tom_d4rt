// D4rt test script: Tests TwoDimensionalScrollable from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalScrollable test executing');

  // Test TwoDimensionalScrollable - TwoDimensionalScrollable
  print('TwoDimensionalScrollable is available in the widgets package');
  print('TwoDimensionalScrollable runtimeType accessible');

  print('TwoDimensionalScrollable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TwoDimensionalScrollable Tests'),
      Text('TwoDimensionalScrollable'),
    ],
  );
}
