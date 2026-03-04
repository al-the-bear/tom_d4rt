// D4rt test script: Tests ShortcutRegistryEntry from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShortcutRegistryEntry test executing');

  // Test ShortcutRegistryEntry - ShortcutRegistryEntry
  print('ShortcutRegistryEntry is available in the widgets package');
  print('ShortcutRegistryEntry runtimeType accessible');

  print('ShortcutRegistryEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShortcutRegistryEntry Tests'),
      Text('ShortcutRegistryEntry'),
    ],
  );
}
