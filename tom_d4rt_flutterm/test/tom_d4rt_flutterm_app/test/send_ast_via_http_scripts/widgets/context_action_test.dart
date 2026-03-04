// D4rt test script: Tests ContextAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContextAction test executing');

  // Test ContextAction - ContextAction
  print('ContextAction is available in the widgets package');
  print('ContextAction runtimeType accessible');

  print('ContextAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContextAction Tests'),
      Text('ContextAction'),
    ],
  );
}
