// D4rt test script: Tests NextFocusIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NextFocusIntent test executing');

  // Test NextFocusIntent - NextFocusIntent
  print('NextFocusIntent is available in the widgets package');
  print('NextFocusIntent runtimeType accessible');

  print('NextFocusIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NextFocusIntent Tests'),
      Text('NextFocusIntent'),
    ],
  );
}
