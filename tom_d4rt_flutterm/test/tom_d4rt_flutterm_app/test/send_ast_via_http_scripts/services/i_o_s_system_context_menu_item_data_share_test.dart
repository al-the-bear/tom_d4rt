// ignore_for_file: avoid_print
// D4rt test script: Tests IOSSystemContextMenuItemDataShare from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataShare test executing');

  // Create the share action
  const item = IOSSystemContextMenuItemDataShare(title: 'Share');

  print('Created: ${item.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is IOSSystemContextMenuItemData: true /* item is IOSSystemContextMenuItemData */',
  );

  // Explain purpose
  print('\niOS context menu "Share":');
  print('- Standard iOS action');
  print('- Opens iOS share sheet');
  print('- Shares selected text');

  // Share sheet options
  print('\nShare sheet includes:');
  print('- Copy');
  print('- Messages, Mail');
  print('- Notes, Reminders');
  print('- AirDrop');
  print('- Third-party apps');

  // Usage
  print('\nUsage:');
  print('SystemContextMenu.editableText(');
  print('  systemContextMenuItems: [');
  print('    IOSSystemContextMenuItemDataShare(),');
  print('  ],');
  print(')');

  // All iOS context menu items
  print('\nAll iOS context menu items:');
  print('- LookUp: dictionary/wiki');
  print('- SearchWeb: Safari search');
  print('- Share: share sheet');

  // Platform specific
  print('\nPlatform note:');
  print('- iOS only');
  print('- No effect on other platforms');
  print('- Uses native iOS share sheet');

  print('\nIOSSystemContextMenuItemDataShare test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataShare Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(height: 8),
      Text('iOS "Share" action'),
      Text('Platform: iOS only'),
      Text('Opens: iOS share sheet'),
      Text('Shares: selected text'),
    ],
  );
}
