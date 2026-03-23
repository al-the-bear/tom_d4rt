// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BrowserContextMenu from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BrowserContextMenu test executing');

  // BrowserContextMenu is for web platform
  print('BrowserContextMenu is web-only');
  print('Controls browser right-click menu');

  // Static methods
  print('\nStatic methods:');
  print('BrowserContextMenu.disableContextMenu()');
  print('BrowserContextMenu.enableContextMenu()');
  print('enabled getter: checks current state');

  // Check enabled state
  print('\nCurrent state:');
  print('enabled: ${BrowserContextMenu.enabled}');

  // Use cases
  print('\nUse cases:');
  print('Disable: custom context menu');
  print('Disable: prevent text selection menu');
  print('Enable: restore browser default');

  // Example usage
  print('\nExample usage:');
  print('Future<void> initState() async {');
  print('  await BrowserContextMenu.disableContextMenu();');
  print('}');
  print('');
  print('void dispose() {');
  print('  BrowserContextMenu.enableContextMenu();');
  print('  super.dispose();');
  print('}');

  // Web-only note
  print('\nWeb-only note:');
  print('- Only affects Flutter web');
  print('- No effect on mobile/desktop');
  print('- Disables browser default menu');
  print('- Allows custom Flutter menu');

  // With custom menu
  print('\nWith custom context menu:');
  print('GestureDetector(');
  print('  onSecondaryTapDown: (details) {');
  print('    showMenu(...)');
  print('  },');
  print(')');

  print('\nBrowserContextMenu test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BrowserContextMenu Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Web browser context menu'),
      Text('enabled: ${BrowserContextMenu.enabled}'),
      Text('Methods: disable/enable'),
      Text('Platform: Web only'),
    ],
  );
}
