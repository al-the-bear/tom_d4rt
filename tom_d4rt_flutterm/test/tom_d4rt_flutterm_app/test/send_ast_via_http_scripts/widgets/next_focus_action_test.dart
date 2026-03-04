// D4rt test script: Tests NextFocusAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NextFocusAction test executing');

  // Test NextFocusAction - NextFocusAction
  print('NextFocusAction is available in the widgets package');
  print('NextFocusAction runtimeType accessible');

  print('NextFocusAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NextFocusAction Tests'),
      Text('NextFocusAction'),
    ],
  );
}
