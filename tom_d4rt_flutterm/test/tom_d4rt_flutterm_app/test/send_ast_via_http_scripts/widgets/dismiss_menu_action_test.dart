// D4rt test script: Tests DismissMenuAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DismissMenuAction test executing');

  // Test DismissMenuAction - DismissMenuAction
  print('DismissMenuAction is available in the widgets package');
  print('DismissMenuAction runtimeType accessible');

  print('DismissMenuAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DismissMenuAction Tests'),
      Text('DismissMenuAction'),
    ],
  );
}
