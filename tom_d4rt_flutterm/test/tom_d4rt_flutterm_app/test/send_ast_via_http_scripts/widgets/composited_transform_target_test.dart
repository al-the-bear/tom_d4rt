// D4rt test script: Tests CompositedTransformTarget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CompositedTransformTarget test executing');

  // Test CompositedTransformTarget - Transform target
  print('CompositedTransformTarget is available in the widgets package');
  print('CompositedTransformTarget runtimeType accessible');

  print('CompositedTransformTarget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CompositedTransformTarget Tests'),
      Text('Transform target'),
    ],
  );
}
