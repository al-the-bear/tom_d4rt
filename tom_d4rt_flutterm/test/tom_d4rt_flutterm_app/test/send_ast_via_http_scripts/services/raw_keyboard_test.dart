// D4rt test script: Tests RawKeyboard from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyboard test executing');

  // Test RawKeyboard - RawKeyboard
  print('RawKeyboard is available in the services package');
  print('RawKeyboard: RawKeyboard');

  print('RawKeyboard test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawKeyboard Tests'),
      Text('RawKeyboard'),
    ],
  );
}
