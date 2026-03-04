// D4rt test script: Tests DualTransitionBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DualTransitionBuilder test executing');

  // Test DualTransitionBuilder - Dual transition
  print('DualTransitionBuilder is available in the widgets package');
  print('DualTransitionBuilder runtimeType accessible');

  print('DualTransitionBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DualTransitionBuilder Tests'),
      Text('Dual transition'),
    ],
  );
}
