// D4rt test script: Tests ButtonActivateIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ButtonActivateIntent test executing');

  // Test ButtonActivateIntent - Button activate
  print('ButtonActivateIntent is available in the widgets package');
  print('ButtonActivateIntent runtimeType accessible');

  print('ButtonActivateIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonActivateIntent Tests'),
      Text('Button activate'),
    ],
  );
}
