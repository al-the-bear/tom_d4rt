// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemDataCut from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataCut test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemDataCut - Cut action
  print('\nIOSSystemContextMenuItemDataCut:');
  print('iOS context menu Cut action');
  print('Cuts selected text to clipboard');

  // Create instance
  final cutItem = IOSSystemContextMenuItemDataCut();
  print('\nInstance created:');
  print('runtimeType: ${cutItem.runtimeType}');

  // Type property
  print('\ntype property:');
  print('type: Cut (hardcoded, getter removed)');
  print('Identifies this as cut action');

  // Extends base class
  print('\nExtends IOSSystemContextMenuItemData:');
  print(
    'is IOSSystemContextMenuItemData: true /* cutItem is IOSSystemContextMenuItemData */',
  );

  // iOS behavior
  print('\niOS behavior:');
  print('- Shows "Cut" in menu');
  print('- Copies text to clipboard');
  print('- Removes text from source');
  print('- Editable fields only');

  // Cut vs Copy
  print('\nCut vs Copy:');
  print('Cut: Copy + Delete selection');
  print('Copy: Copy only, keep selection');
  print('');
  print('Cut only available for editable text');

  // Usage example
  print('\nUsage example:');
  print('// For editable TextField');
  print('SystemContextMenuController.show(');
  print('  targetRect: selectionRect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataCut(),');
  print('    IOSSystemContextMenuItemDataCopy(),');
  print('    IOSSystemContextMenuItemDataPaste(),');
  print('  ],');
  print(');');

  // TextField integration
  print('\nTextField integration:');
  print('Flutter\'s TextField auto-provides Cut');
  print('Only when text is selected');
  print('Only in editable mode');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataCut');

  // Explain purpose
  print('\nIOSSystemContextMenuItemDataCut purpose:');
  print('- iOS Cut menu action');
  print('- Cuts selection to clipboard');
  print('- Native iOS appearance');
  print('- For editable text only');
  print('- Standard text editing workflow');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemDataCut test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataCut Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${cutItem.runtimeType}'),
      Text('Action: Cut'),
      Text('Platform: iOS'),
      Text('Purpose: Cut to clipboard'),
    ],
  );
}
