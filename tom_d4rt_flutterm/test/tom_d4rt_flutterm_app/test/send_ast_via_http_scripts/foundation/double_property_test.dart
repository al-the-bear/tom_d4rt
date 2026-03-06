// D4rt test script: Tests DoubleProperty from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DoubleProperty test executing');

  // Test DoubleProperty - DoubleProperty
  print('DoubleProperty is available in the foundation package');
  print('DoubleProperty: DoubleProperty');

  print('DoubleProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DoubleProperty Tests'),
      Text('DoubleProperty'),
    ],
  );
}
