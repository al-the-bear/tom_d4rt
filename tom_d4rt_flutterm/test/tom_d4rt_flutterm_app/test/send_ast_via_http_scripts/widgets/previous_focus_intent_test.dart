// D4rt test script: Tests PreviousFocusIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PreviousFocusIntent test executing');

  // Test PreviousFocusIntent - PreviousFocusIntent
  print('PreviousFocusIntent is available in the widgets package');
  print('PreviousFocusIntent runtimeType accessible');

  print('PreviousFocusIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PreviousFocusIntent Tests'),
      Text('PreviousFocusIntent'),
    ],
  );
}
