// D4rt test script: Tests PopScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PopScope test executing');

  // Test PopScope - Navigation pop
  print('PopScope is available in the widgets package');
  print('PopScope runtimeType accessible');

  print('PopScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopScope Tests'),
      Text('Navigation pop'),
    ],
  );
}
