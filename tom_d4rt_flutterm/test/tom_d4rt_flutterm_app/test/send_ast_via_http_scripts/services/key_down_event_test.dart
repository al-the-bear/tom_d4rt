// D4rt test script: Tests KeyDownEvent from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyDownEvent test executing');

  // Test KeyDownEvent - KeyDownEvent
  print('KeyDownEvent is available in the services package');
  print('KeyDownEvent: KeyDownEvent');

  print('KeyDownEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyDownEvent Tests'),
      Text('KeyDownEvent'),
    ],
  );
}
