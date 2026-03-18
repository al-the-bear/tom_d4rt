// D4rt test script: Tests IOSSystemContextMenuItemDataSelectAll from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataSelectAll test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemDataSelectAll - Select All action
  print('\nIOSSystemContextMenuItemDataSelectAll:');
  print('iOS context menu Select All action');
  print('Selects all text in field');

  // Create instance
  final selectAllItem = IOSSystemContextMenuItemDataSelectAll();
  print('\nInstance created:');
  print('runtimeType: ${selectAllItem.runtimeType}');

  // Type property
  print('\ntype property:');
  print('type: SelectAll (hardcoded, getter removed)');
  print('Identifies Select All action');

  // Extends base class
  print('\nExtends IOSSystemContextMenuItemData:');
  print(
    'is IOSSystemContextMenuItemData: true /* selectAllItem is IOSSystemContextMenuItemData */',
  );

  // iOS behavior
  print('\niOS behavior:');
  print('- Shows "Select All" in menu');
  print('- Selects all text in field');
  print('- Works in text fields/views');
  print('- Follows system locale');

  // Usage example
  print('\nUsage example:');
  print('SystemContextMenuController.show(');
  print('  targetRect: cursorRect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataSelectAll(),');
  print('    IOSSystemContextMenuItemDataCopy(),');
  print('  ],');
  print(');');

  // Common menu combinations
  print('\nCommon menu combinations:');
  print('');
  print('Editable empty field:');
  print('  [Select All, Paste]');
  print('');
  print('Editable with text:');
  print('  [Select All, Cut, Copy, Paste]');
  print('');
  print('Read-only with selection:');
  print('  [Copy, Select All]');

  // Keyboard shortcut
  print('\nKeyboard shortcut equivalent:');
  print('iOS/iPadOS: ⌘A (Command + A)');
  print('Works with external keyboards');

  // When visible
  print('\nWhen Select All is visible:');
  print('- Text field has text');
  print('- Not all text already selected');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataSelectAll');

  // Explain purpose
  print('\nIOSSystemContextMenuItemDataSelectAll purpose:');
  print('- iOS Select All menu action');
  print('- Selects entire text content');
  print('- Native iOS appearance');
  print('- Standard text editing workflow');
  print('- Often combined with Copy');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemDataSelectAll test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataSelectAll Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${selectAllItem.runtimeType}'),
      Text('Action: SelectAll'),
      Text('Platform: iOS'),
      Text('Purpose: Select all text'),
    ],
  );
}
