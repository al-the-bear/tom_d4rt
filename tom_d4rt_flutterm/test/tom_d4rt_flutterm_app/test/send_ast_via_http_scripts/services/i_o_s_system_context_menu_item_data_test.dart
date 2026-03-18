// D4rt test script: Tests IOSSystemContextMenuItemData from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemData test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemData base class
  print('\nIOSSystemContextMenuItemData:');
  print('Base class for iOS system context menu items');
  print('Used with SystemContextMenuController');

  // Purpose
  print('\nPurpose:');
  print('Represents iOS native context menu actions');
  print('Cut, Copy, Paste, Select All, etc.');
  print('Shows in iOS text selection menu');

  // Subclasses
  print('\nConcrete subclasses:');
  print('- IOSSystemContextMenuItemDataCut');
  print('- IOSSystemContextMenuItemDataCopy');
  print('- IOSSystemContextMenuItemDataPaste');
  print('- IOSSystemContextMenuItemDataSelectAll');
  print('- IOSSystemContextMenuItemDataLiveText');
  print('- IOSSystemContextMenuItemDataCustom');

  // Properties
  print('\nCommon properties:');
  print('type: Identifier for the action type');
  print('label: Display text (localized)');

  // iOS context menu system
  print('\niOS context menu system:');
  print('- UIMenuController (pre-iOS 16)');
  print('- UIEditMenuInteraction (iOS 16+)');
  print('- Native look and feel');
  print('- Integrates with selection');

  // Usage with controller
  print('\nUsage with SystemContextMenuController:');
  print('SystemContextMenuController.show(');
  print('  targetRect: rect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataCopy(),');
  print('    IOSSystemContextMenuItemDataPaste(),');
  print('  ],');
  print(');');

  // Platform specifics
  print('\nPlatform: iOS only');
  print('On other platforms use regular context menus');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData (base)');
  print('  \u251c\u2500 IOSSystemContextMenuItemDataCut');
  print('  \u251c\u2500 IOSSystemContextMenuItemDataCopy');
  print('  \u251c\u2500 IOSSystemContextMenuItemDataPaste');
  print('  \u251c\u2500 IOSSystemContextMenuItemDataSelectAll');
  print('  \u251c\u2500 IOSSystemContextMenuItemDataLiveText');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataCustom');

  // Explain purpose
  print('\nIOSSystemContextMenuItemData purpose:');
  print('- Base class for iOS menu items');
  print('- SystemContextMenuController integration');
  print('- Native iOS context menu support');
  print('- Standard text editing actions');
  print('- Subclass for specific actions');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemData Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract base class'),
      Text('Platform: iOS only'),
      Text('Actions: Cut, Copy, Paste, etc.'),
      Text('Purpose: iOS context menu items'),
    ],
  );
}
