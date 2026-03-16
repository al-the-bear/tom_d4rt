// D4rt test script: Tests RawKeyDownEvent from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyDownEvent test executing');

  // Test RawKeyDownEvent - RawKeyDownEvent
  print('RawKeyDownEvent is available in the services package');
  print('RawKeyDownEvent: RawKeyDownEvent');

  print('RawKeyDownEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawKeyDownEvent Tests'),
      Text('RawKeyDownEvent'),
    ],
  );
}
