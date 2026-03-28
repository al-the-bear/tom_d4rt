// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BrowserContextMenu from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BrowserContextMenu test executing');
  print('=' * 50);

  // BrowserContextMenu class overview
  print('BrowserContextMenu class overview:');
  print('  - Controls browser context menu');
  print('  - Singleton pattern with private instance');
  print('  - Web-specific functionality');

  // Static properties
  print('\nStatic properties:');
  print('  enabled: ${BrowserContextMenu.enabled}');
  print('    - Whether context menu is enabled');
  print('    - Default: true');
  print('    - Reflects current state');

  // Instance check
  print('\nInstance behavior:');
  print('  Singleton pattern');
  print('  One instance per app');
  print('  Global state management');
  print('  Thread-safe access');

  // Static methods
  print('\nStatic methods:');
  print('  BrowserContextMenu.disableContextMenu()');
  print('    - Disables browser context menu');
  print('    - Returns Future<void>');
  print('    - Sets enabled to false');
  print('  BrowserContextMenu.enableContextMenu()');
  print('    - Enables browser context menu');
  print('    - Returns Future<void>');
  print('    - Sets enabled to true');

  // Platform behavior
  print('\nPlatform behavior:');
  print('  Web: Controls right-click menu');
  print('  Mobile: No effect');
  print('  Desktop: No effect');

  // Use cases
  print('\nUse cases:');
  print('  Custom context menus');
  print('  Canvas applications');
  print('  Game interfaces');
  print('  Drawing apps');
  print('  Image editors');

  // Integration
  print('\nIntegration:');
  print('  Works with SelectableText');
  print('  Works with TextField');
  print('  Custom widgets can use');

  // State management
  print('\nState management:');
  print('  enabled getter tracks state');
  print('  Async methods for changes');
  print('  Platform message passing');
  print('  No rebuild needed');

  // Web implementation
  print('\nWeb implementation:');
  print('  Prevents default context menu');
  print('  JavaScript interop');
  print('  Document listener');

  print('\n' + '=' * 50);
  print('BrowserContextMenu test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BrowserContextMenu Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Singleton class'),
      Text('Key: enabled, disableContextMenu()'),
      Text('Purpose: Web context menu control'),
    ],
  );
}
