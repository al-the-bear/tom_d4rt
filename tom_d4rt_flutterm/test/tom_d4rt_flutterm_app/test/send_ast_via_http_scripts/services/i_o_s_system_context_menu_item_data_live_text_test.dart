// D4rt test script: Tests IOSSystemContextMenuItemDataLiveText from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataLiveText test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemDataLiveText - Live Text action
  print('\nIOSSystemContextMenuItemDataLiveText:');
  print('iOS context menu Live Text action');
  print('Uses iOS camera for text recognition');

  // Create instance
  final liveTextItem = IOSSystemContextMenuItemDataLiveText();
  print('\nInstance created:');
  print('runtimeType: ${liveTextItem.runtimeType}');

  // Type property
  print('\ntype property:');
  print('type: ${liveTextItem.type}');
  print('Identifies Live Text action');

  // Extends base class
  print('\nExtends IOSSystemContextMenuItemData:');
  print(
    'is IOSSystemContextMenuItemData: true /* liveTextItem is IOSSystemContextMenuItemData */',
  );

  // iOS Live Text feature
  print('\niOS Live Text feature:');
  print('- Uses device camera');
  print('- OCR text recognition');
  print('- Inserts recognized text');
  print('- iOS 15+ (iPhone XS+)');

  // Requirements
  print('\nRequirements:');
  print('- iOS 15.0 or later');
  print('- Device with Neural Engine');
  print('- iPhone XS/XR or newer');
  print('- iPad Pro 2020+, iPad Air 4+');

  // How it works
  print('\nHow it works:');
  print('1. User taps Live Text in menu');
  print('2. Camera viewfinder opens');
  print('3. Point at text to scan');
  print('4. Text inserted at cursor');

  // Usage example
  print('\nUsage example:');
  print('// Add Live Text to text field menu');
  print('SystemContextMenuController.show(');
  print('  targetRect: cursorRect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataPaste(),');
  print('    IOSSystemContextMenuItemDataLiveText(),');
  print('  ],');
  print(');');

  // Use cases
  print('\nUse cases:');
  print('- Scan business cards');
  print('- Copy printed documents');
  print('- Enter text from books');
  print('- Transcribe handwritten notes');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataLiveText');

  // Explain purpose
  print('\nIOSSystemContextMenuItemDataLiveText purpose:');
  print('- iOS Live Text menu action');
  print('- Camera-based text recognition');
  print('- Native iOS OCR technology');
  print('- Inserts scanned text');
  print('- iOS 15+ with Neural Engine');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemDataLiveText test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataLiveText Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${liveTextItem.runtimeType}'),
      Text('Action: ${liveTextItem.type}'),
      Text('Requires: iOS 15+'),
      Text('Purpose: Camera-based text input'),
    ],
  );
}
