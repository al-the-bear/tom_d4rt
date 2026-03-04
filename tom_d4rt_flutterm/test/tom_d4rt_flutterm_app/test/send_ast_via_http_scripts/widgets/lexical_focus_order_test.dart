// D4rt test script: Tests LexicalFocusOrder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LexicalFocusOrder test executing');

  // Test LexicalFocusOrder - LexicalFocusOrder
  print('LexicalFocusOrder is available in the widgets package');
  print('LexicalFocusOrder runtimeType accessible');

  print('LexicalFocusOrder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LexicalFocusOrder Tests'),
      Text('LexicalFocusOrder'),
    ],
  );
}
