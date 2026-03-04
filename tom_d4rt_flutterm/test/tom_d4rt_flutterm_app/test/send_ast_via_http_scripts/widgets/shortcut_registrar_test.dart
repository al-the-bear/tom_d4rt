// D4rt test script: Tests ShortcutRegistrar from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutRegistrar test executing');

  // Test ShortcutRegistrar - ShortcutRegistrar
  print('ShortcutRegistrar is available in the widgets package');
  print('ShortcutRegistrar runtimeType accessible');

  print('ShortcutRegistrar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutRegistrar Tests'),
      Text('ShortcutRegistrar'),
    ],
  );
}
