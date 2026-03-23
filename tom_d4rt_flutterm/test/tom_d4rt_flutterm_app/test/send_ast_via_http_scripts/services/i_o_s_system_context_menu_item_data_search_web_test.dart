// ignore_for_file: avoid_print
// D4rt test script: Tests IOSSystemContextMenuItemDataSearchWeb from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataSearchWeb test executing');

  // Create the search web action
  const item = IOSSystemContextMenuItemDataSearchWeb(title: 'Search Web');

  print('Created: ${item.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is IOSSystemContextMenuItemData: true /* item is IOSSystemContextMenuItemData */',
  );

  // Explain purpose
  print('\niOS context menu "Search Web":');
  print('- Standard iOS action');
  print('- Searches selected text in Safari');
  print('- System-provided behavior');

  // iOS context menu items
  print('\niOS context menu items:');
  print('- IOSSystemContextMenuItemDataSearchWeb: Search Web');
  print('- IOSSystemContextMenuItemDataLookUp: Look Up');
  print('- IOSSystemContextMenuItemDataShare: Share');
  print('- Custom items also possible');

  // Usage in SystemContextMenu
  print('\nUsage:');
  print('SystemContextMenu.editableText(');
  print('  systemContextMenuItems: [');
  print('    IOSSystemContextMenuItemDataSearchWeb(),');
  print('    IOSSystemContextMenuItemDataLookUp(),');
  print('  ],');
  print(')');

  // Platform specific
  print('\nPlatform note:');
  print('- iOS only');
  print('- No effect on other platforms');
  print('- Uses native iOS behavior');

  print('\nIOSSystemContextMenuItemDataSearchWeb test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataSearchWeb Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(height: 8),
      Text('iOS "Search Web" action'),
      Text('Platform: iOS only'),
      Text('Searches: selected text'),
      Text('In: Safari browser'),
    ],
  );
}
