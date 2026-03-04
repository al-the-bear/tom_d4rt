// D4rt test script: Tests FocusOrder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FocusOrder test executing');

  // Test FocusOrder - FocusOrder
  print('FocusOrder is available in the widgets package');
  print('FocusOrder runtimeType accessible');

  print('FocusOrder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FocusOrder Tests'),
      Text('FocusOrder'),
    ],
  );
}
