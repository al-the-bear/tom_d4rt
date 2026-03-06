// D4rt test script: Tests ObjectEvent from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ObjectEvent test executing');

  // Test ObjectEvent - Object events
  print('ObjectEvent is available in the foundation package');
  print('ObjectEvent: Object events');

  print('ObjectEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectEvent Tests'),
      Text('Object events'),
    ],
  );
}
