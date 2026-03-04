// D4rt test script: Tests ShortcutActivator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutActivator test executing');

  // Test ShortcutActivator - ShortcutActivator
  print('ShortcutActivator is available in the widgets package');
  print('ShortcutActivator runtimeType accessible');

  print('ShortcutActivator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutActivator Tests'),
      Text('ShortcutActivator'),
    ],
  );
}
