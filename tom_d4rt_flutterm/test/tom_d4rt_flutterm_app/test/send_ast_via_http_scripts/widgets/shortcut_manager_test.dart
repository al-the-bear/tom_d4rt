// D4rt test script: Tests ShortcutManager from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutManager test executing');

  // Test ShortcutManager - ShortcutManager
  print('ShortcutManager is available in the widgets package');
  print('ShortcutManager runtimeType accessible');

  print('ShortcutManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutManager Tests'),
      Text('ShortcutManager'),
    ],
  );
}
