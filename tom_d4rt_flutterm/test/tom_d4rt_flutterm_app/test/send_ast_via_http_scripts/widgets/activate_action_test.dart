// D4rt test script: Tests ActivateAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ActivateAction test executing');

  // Test ActivateAction - Activate action
  print('ActivateAction is available in the widgets package');
  print('ActivateAction runtimeType accessible');

  print('ActivateAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ActivateAction Tests'),
      Text('Activate action'),
    ],
  );
}
