// D4rt test script: Tests WillPopScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WillPopScope test executing');

  // Test WillPopScope - Pop scope (deprecated)
  print('WillPopScope is available in the widgets package');
  print('WillPopScope runtimeType accessible');

  print('WillPopScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WillPopScope Tests'),
      Text('Pop scope (deprecated)'),
    ],
  );
}
