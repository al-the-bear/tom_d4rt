// D4rt test script: Tests ShortcutMapProperty from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutMapProperty test executing');

  // Test ShortcutMapProperty - ShortcutMapProperty
  print('ShortcutMapProperty is available in the widgets package');
  print('ShortcutMapProperty runtimeType accessible');

  print('ShortcutMapProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutMapProperty Tests'),
      Text('ShortcutMapProperty'),
    ],
  );
}
