// D4rt test script: Tests KeyEvent from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEvent test executing');

  // Test KeyEvent - KeyEvent
  print('KeyEvent is available in the services package');
  print('KeyEvent: KeyEvent');

  print('KeyEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyEvent Tests'),
      Text('KeyEvent'),
    ],
  );
}
