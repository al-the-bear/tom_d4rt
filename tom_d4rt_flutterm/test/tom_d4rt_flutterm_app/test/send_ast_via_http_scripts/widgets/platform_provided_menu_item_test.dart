// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformProvidedMenuItem from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('PlatformProvidedMenuItem test executing');
  print('=' * 50);

  // === Test PlatformProvidedMenuItem class ===
  print('\nPlatformProvidedMenuItem creates system-provided menu items');

  // Describe PlatformProvidedMenuItem
  print('\n--- Understanding PlatformProvidedMenuItem ---');
  print('Extends PlatformMenuItem');
  print('Represents platform-provided menu items');
  print('Examples: About, Quit, Services');

  // Test hasMenu static method
  print('\n--- Testing hasMenu ---');
  print('PlatformProvidedMenuItem.hasMenu(type)');
  print('Checks if current platform supports menu type');
  final aboutSupported = PlatformProvidedMenuItem.hasMenu(
    PlatformProvidedMenuItemType.about,
  );
  print('about supported on ${defaultTargetPlatform}: $aboutSupported');

  // Test enabled property
  print('\n--- Testing enabled ---');
  final menuItem = const PlatformProvidedMenuItem(
    type: PlatformProvidedMenuItemType.about,
    enabled: true,
  );
  print('menuItem.type: ${menuItem.type}');
  print('menuItem.enabled: ${menuItem.enabled}');

  // Test type property  
  print('\n--- Testing type ---');
  print('type: PlatformProvidedMenuItemType enum');
  print('Specifies which system menu to use');

  // Common types
  print('\n--- Common types (macOS) ---');
  print('about: About dialog');
  print('quit: Exit application');
  print('hide: Hide application');
  print('servicesSubmenu: System services');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('menuItem is PlatformMenuItem: ${menuItem is PlatformMenuItem}');

  // Usage in PlatformMenuBar
  print('\n--- Usage in PlatformMenuBar ---');
  print('PlatformMenuBar(menus: [');
  print('  PlatformMenu(label: "App", menus: [');
  print('    PlatformProvidedMenuItem(type: ...about),');
  print('    PlatformProvidedMenuItem(type: ...quit),');
  print('  ]),');
  print('])');

  // Platform considerations
  print('\n--- Platform considerations ---');
  print('Only macOS supports platform-provided menus');
  print('Other platforms: hasMenu returns false');
  print('Always check hasMenu before using');

  print('\n' + '=' * 50);
  print('PlatformProvidedMenuItem test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformProvidedMenuItem Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('type: ${menuItem.type}'),
      Text('enabled: ${menuItem.enabled}'),
      Text('about supported: $aboutSupported'),
    ],
  );
}
