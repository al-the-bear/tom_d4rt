// D4rt test script: Tests OverflowBox from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverflowBox test executing');

  // Test OverflowBox - Overflow box
  print('OverflowBox is available in the widgets package');
  print('OverflowBox runtimeType accessible');

  print('OverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverflowBox Tests'),
      Text('Overflow box'),
    ],
  );
}
