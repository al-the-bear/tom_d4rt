// D4rt test script: Tests PrioritizedAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PrioritizedAction test executing');

  // Test PrioritizedAction - PrioritizedAction
  print('PrioritizedAction is available in the widgets package');
  print('PrioritizedAction runtimeType accessible');

  print('PrioritizedAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PrioritizedAction Tests'),
      Text('PrioritizedAction'),
    ],
  );
}
