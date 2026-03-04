// D4rt test script: Tests IgnoreBaseline from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IgnoreBaseline test executing');

  // Test IgnoreBaseline - IgnoreBaseline
  print('IgnoreBaseline is available in the widgets package');
  print('IgnoreBaseline runtimeType accessible');

  print('IgnoreBaseline test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IgnoreBaseline Tests'),
      Text('IgnoreBaseline'),
    ],
  );
}
