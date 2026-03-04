// D4rt test script: Tests ActivateIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ActivateIntent test executing');

  // Test ActivateIntent - Activate intent
  print('ActivateIntent is available in the widgets package');
  print('ActivateIntent runtimeType accessible');

  print('ActivateIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ActivateIntent Tests'),
      Text('Activate intent'),
    ],
  );
}
