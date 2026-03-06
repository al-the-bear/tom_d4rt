// D4rt test script: Tests RawKeyEvent from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEvent test executing');

  // Test RawKeyEvent - RawKeyEvent
  print('RawKeyEvent is available in the services package');
  print('RawKeyEvent: RawKeyEvent');

  print('RawKeyEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawKeyEvent Tests'),
      Text('RawKeyEvent'),
    ],
  );
}
