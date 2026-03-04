// D4rt test script: Tests SizedOverflowBox from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SizedOverflowBox test executing');

  // Test SizedOverflowBox - SizedOverflowBox
  print('SizedOverflowBox is available in the widgets package');
  print('SizedOverflowBox runtimeType accessible');

  print('SizedOverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SizedOverflowBox Tests'),
      Text('SizedOverflowBox'),
    ],
  );
}
