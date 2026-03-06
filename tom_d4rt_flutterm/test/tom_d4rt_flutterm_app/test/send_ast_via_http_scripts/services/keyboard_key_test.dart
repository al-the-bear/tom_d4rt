// D4rt test script: Tests KeyboardKey from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyboardKey test executing');

  // Test KeyboardKey - KeyboardKey
  print('KeyboardKey is available in the services package');
  print('KeyboardKey: KeyboardKey');

  print('KeyboardKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyboardKey Tests'),
      Text('KeyboardKey'),
    ],
  );
}
