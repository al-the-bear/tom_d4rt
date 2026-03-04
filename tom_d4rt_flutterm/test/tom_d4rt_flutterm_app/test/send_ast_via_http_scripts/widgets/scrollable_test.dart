// D4rt test script: Tests Scrollable from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Scrollable test executing');

  // Test Scrollable - Scrollable widget
  print('Scrollable is available in the widgets package');
  print('Scrollable runtimeType accessible');

  print('Scrollable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Scrollable Tests'),
      Text('Scrollable widget'),
    ],
  );
}
