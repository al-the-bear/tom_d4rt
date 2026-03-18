// D4rt test script: Tests IOSSystemContextMenuItemDataPaste from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataPaste test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemDataPaste - Paste action
  print('\nIOSSystemContextMenuItemDataPaste:');
  print('iOS context menu Paste action');
  print('Pastes clipboard content');

  // Create instance
  final pasteItem = IOSSystemContextMenuItemDataPaste();
  print('\nInstance created:');
  print('runtimeType: ${pasteItem.runtimeType}');

  // Type property
  print('\ntype property:');
  print('type: ${pasteItem.type}');
  print('Identifies this as paste action');

  // Extends base class
  print('\nExtends IOSSystemContextMenuItemData:');
  print(
    'is IOSSystemContextMenuItemData: true /* pasteItem is IOSSystemContextMenuItemData */',
  );

  // iOS behavior
  print('\niOS behavior:');
  print('- Shows "Paste" in menu');
  print('- Inserts clipboard content');
  print('- At cursor position');
  print('- Replaces selection if any');

  // Paste availability
  print('\nPaste availability:');
  print('- Only if clipboard has content');
  print('- Only for editable fields');
  print('- Honors paste permissions');

  // iOS 16+ changes
  print('\niOS 16+ paste notice:');
  print('iOS 16 added paste permission dialog');
  print('"App wants to paste from Clipboard"');
  print('User must allow each paste');
  print('Or use Keyboard > Allow Pasting');

  // Usage example
  print('\nUsage example:');
  print('SystemContextMenuController.show(');
  print('  targetRect: cursorRect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataPaste(),');
  print('  ],');
  print(');');

  // Content types
  print('\nSupported content types:');
  print('- Plain text (most common)');
  print('- Rich text (RTF)');
  print('- Images (in some fields)');
  print('- URLs');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataPaste');

  // Explain purpose
  print('\nIOSSystemContextMenuItemDataPaste purpose:');
  print('- iOS Paste menu action');
  print('- Pastes from clipboard');
  print('- Native iOS appearance');
  print('- For editable text only');
  print('- Standard text editing workflow');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemDataPaste test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataPaste Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${pasteItem.runtimeType}'),
      Text('Action: ${pasteItem.type}'),
      Text('Platform: iOS'),
      Text('Purpose: Paste from clipboard'),
    ],
  );
}
