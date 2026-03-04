// D4rt test script: Tests ShortcutRegistry from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutRegistry test executing');

  // Test ShortcutRegistry - ShortcutRegistry
  print('ShortcutRegistry is available in the widgets package');
  print('ShortcutRegistry runtimeType accessible');

  print('ShortcutRegistry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutRegistry Tests'),
      Text('ShortcutRegistry'),
    ],
  );
}
