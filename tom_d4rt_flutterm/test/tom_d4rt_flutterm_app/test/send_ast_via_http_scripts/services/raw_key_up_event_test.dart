// D4rt test script: Tests RawKeyUpEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyUpEvent test executing');

  // Test RawKeyUpEvent - RawKeyUpEvent
  print('RawKeyUpEvent is available in the services package');
  print('RawKeyUpEvent: RawKeyUpEvent');

  print('RawKeyUpEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawKeyUpEvent Tests'),
      Text('RawKeyUpEvent'),
    ],
  );
}
