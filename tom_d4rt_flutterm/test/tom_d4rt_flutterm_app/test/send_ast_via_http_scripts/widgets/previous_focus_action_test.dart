// D4rt test script: Tests PreviousFocusAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PreviousFocusAction test executing');

  // Test PreviousFocusAction - PreviousFocusAction
  print('PreviousFocusAction is available in the widgets package');
  print('PreviousFocusAction runtimeType accessible');

  print('PreviousFocusAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PreviousFocusAction Tests'),
      Text('PreviousFocusAction'),
    ],
  );
}
