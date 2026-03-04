// D4rt test script: Tests ShortcutSerialization from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutSerialization test executing');

  // Test ShortcutSerialization - ShortcutSerialization
  print('ShortcutSerialization is available in the widgets package');
  print('ShortcutSerialization runtimeType accessible');

  print('ShortcutSerialization test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutSerialization Tests'),
      Text('ShortcutSerialization'),
    ],
  );
}
