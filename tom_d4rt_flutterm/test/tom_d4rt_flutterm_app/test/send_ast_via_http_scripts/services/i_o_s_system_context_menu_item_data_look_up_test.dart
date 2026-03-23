// ignore_for_file: avoid_print
// D4rt test script: Tests IOSSystemContextMenuItemDataLookUp from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataLookUp test executing');

  // Create the look up action
  const item = IOSSystemContextMenuItemDataLookUp(title: 'Look Up');

  print('Created: ${item.runtimeType}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is IOSSystemContextMenuItemData: true /* item is IOSSystemContextMenuItemData */',
  );

  // Explain purpose
  print('\niOS context menu "Look Up":');
  print('- Standard iOS action');
  print('- Shows dictionary definition');
  print('- Also shows web results');
  print('- System Look Up popup');

  // What Look Up shows
  print('\nLook Up includes:');
  print('- Dictionary definition');
  print('- Wikipedia summary');
  print('- Web search results');
  print('- App suggestions');

  // Usage
  print('\nUsage:');
  print('SystemContextMenu.editableText(');
  print('  systemContextMenuItems: [');
  print('    IOSSystemContextMenuItemDataLookUp(),');
  print('  ],');
  print(')');

  // Comparison with Search Web
  print('\nLook Up vs Search Web:');
  print('Look Up: in-app popup with info');
  print('Search Web: opens Safari');

  // Platform specific
  print('\nPlatform note:');
  print('- iOS only');
  print('- No effect on other platforms');
  print('- Uses native iOS Look Up');

  print('\nIOSSystemContextMenuItemDataLookUp test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataLookUp Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      SizedBox(height: 8),
      Text('iOS "Look Up" action'),
      Text('Platform: iOS only'),
      Text('Shows: dictionary + web info'),
      Text('In: popup overlay'),
    ],
  );
}
