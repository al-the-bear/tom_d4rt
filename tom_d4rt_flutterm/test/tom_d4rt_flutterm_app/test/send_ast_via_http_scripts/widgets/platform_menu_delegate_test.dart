// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformMenuDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuDelegate test executing');
  print('=' * 50);

  // === Test PlatformMenuDelegate abstract class ===
  print('\nPlatformMenuDelegate handles platform menu generation');

  // Describe PlatformMenuDelegate
  print('\n--- Understanding PlatformMenuDelegate ---');
  print('Abstract class for platform menu systems');
  print('Used by PlatformMenuBar widget');
  print('macOS implementation uses flutter/menu channel');

  // Key method: setMenus
  print('\n--- Key method: setMenus ---');
  print('void setMenus(List<PlatformMenuItem> topLevelMenus)');
  print('Sets entire menu hierarchy');
  print('Overwrites previous menu state');

  // Key method: clearMenus
  print('\n--- Key method: clearMenus ---');
  print('void clearMenus()');
  print('Removes all platform menus');

  // Debug methods
  print('\n--- Debug methods ---');
  print('bool debugLockDelegate(BuildContext)');
  print('bool debugUnlockDelegate(BuildContext)');
  print('Ensure only one PlatformMenuBar active');

  // Accessing default delegate
  print('\n--- Accessing delegate ---');
  print('WidgetsBinding.instance.platformMenuDelegate');
  print('DefaultPlatformMenuDelegate on macOS');

  // Test with PlatformMenuBar
  print('\n--- Testing with PlatformMenuBar ---');
  final menuBar = PlatformMenuBar(
    menus: [
      PlatformMenu(
        label: 'App',
        menus: [
          PlatformMenuItem(
            label: 'Quit',
            onSelected: () => print('Quit selected'),
          ),
        ],
      ),
    ],
    child: Text('App content'),
  );
  print('Created PlatformMenuBar');
  print('Uses platform delegate internally');

  // Platform support
  print('\n--- Platform support ---');
  print('macOS: Full support via DefaultPlatformMenuDelegate');
  print('Windows/Linux/iOS/Android: Limited/no support');

  // Menu hierarchy
  print('\n--- Menu hierarchy ---');
  print('PlatformMenu: submenu container');
  print('PlatformMenuItem: clickable item');
  print('PlatformMenuItemGroup: divider group');

  print('\n' + '=' * 50);
  print('PlatformMenuDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformMenuDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract class'),
      Text('Key: setMenus(), clearMenus()'),
      Text('Platform: macOS native menus'),
    ],
  );
}
