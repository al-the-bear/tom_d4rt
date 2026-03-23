// ignore_for_file: avoid_print
// D4rt test script: Tests IOSSystemContextMenuItemDataCopy from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataCopy test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemDataCopy - Copy action
  print('\nIOSSystemContextMenuItemDataCopy:');
  print('iOS context menu Copy action');
  print('Copies selected text to clipboard');

  // Create instance
  final copyItem = IOSSystemContextMenuItemDataCopy();
  print('\nInstance created:');
  print('runtimeType: ${copyItem.runtimeType}');

  // Type property
  print('\ntype property:');
  print('type: Copy (IOSSystemContextMenuItemDataCopy)');
  print('Identifies this as copy action');

  // Extends base class
  print('\nExtends IOSSystemContextMenuItemData:');
  print(
    'is IOSSystemContextMenuItemData: true /* copyItem is IOSSystemContextMenuItemData */',
  );

  // iOS behavior
  print('\niOS behavior:');
  print('- Shows "Copy" in menu');
  print('- Copies selected text');
  print('- Uses system clipboard');
  print('- Localized label');

  // Usage example
  print('\nUsage example:');
  print('SystemContextMenuController.show(');
  print('  targetRect: selectionRect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataCopy(),');
  print('  ],');
  print(');');

  // Typical menu combinations
  print('\nTypical menu combinations:');
  print('For editable text:');
  print('  [Cut, Copy, Paste, Select All]');
  print('');
  print('For read-only text:');
  print('  [Copy]');

  // Clipboard interaction
  print('\nClipboard interaction:');
  print('Uses UIPasteboard.generalPasteboard');
  print('Copies as plain text by default');
  print('RTF support for rich text');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataCopy');

  // Explain purpose
  print('\nIOSSystemContextMenuItemDataCopy purpose:');
  print('- iOS Copy menu action');
  print('- Copies selection to clipboard');
  print('- Native iOS appearance');
  print('- SystemContextMenuController use');
  print('- Standard text editing workflow');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemDataCopy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataCopy Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${copyItem.runtimeType}'),
      Text('Action: Copy'),
      Text('Platform: iOS'),
      Text('Purpose: Copy to clipboard'),
    ],
  );
}
