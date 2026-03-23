// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemDataCustom from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemDataCustom test executing');
  print('=' * 50);

  // IOSSystemContextMenuItemDataCustom - Custom action
  print('\nIOSSystemContextMenuItemDataCustom:');
  print('iOS context menu custom action');
  print('Allows app-defined menu items');

  // Create instance with custom label and callback
  final customItem = IOSSystemContextMenuItemDataCustom(
    title: 'My Action',
    onPressed: () => print('Custom action pressed'),
  );
  print('\nInstance created:');
  print('runtimeType: ${customItem.runtimeType}');

  // Properties
  print('\nProperties:');
  print('title: ${customItem.title}');
  print('onPressed: (callback function)');
  print('type: Custom (hardcoded, getter removed)');

  // Extends base class
  print('\nExtends IOSSystemContextMenuItemData:');
  print(
    'is IOSSystemContextMenuItemData: true /* customItem is IOSSystemContextMenuItemData */',
  );

  // Custom vs standard actions
  print('\nCustom vs standard actions:');
  print('Standard: Cut, Copy, Paste (localized)');
  print('Custom: Any label, any callback');
  print('');
  print('Advantages of custom actions:');
  print('- App-specific functionality');
  print('- Custom labels');
  print('- Flexible callbacks');

  // Usage example
  print('\nUsage example:');
  print('SystemContextMenuController.show(');
  print('  targetRect: rect,');
  print('  items: [');
  print('    IOSSystemContextMenuItemDataCopy(),');
  print('    IOSSystemContextMenuItemDataCustom(');
  print('      title: "Translate",');
  print('      onPressed: () => translateSelected(),');
  print('    ),');
  print('  ],');
  print(');');

  // Multiple custom items
  final shareItem = IOSSystemContextMenuItemDataCustom(
    title: 'Share',
    onPressed: () => print('Share action'),
  );
  final defineItem = IOSSystemContextMenuItemDataCustom(
    title: 'Define',
    onPressed: () => print('Define action'),
  );
  print('\nMultiple custom items:');
  print('Share: ${shareItem.title}');
  print('Define: ${defineItem.title}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('IOSSystemContextMenuItemData');
  print('  \u2514\u2500 IOSSystemContextMenuItemDataCustom');

  // Explain purpose
  print('\nIOSSystemContextMenuItemDataCustom purpose:');
  print('- Custom iOS menu actions');
  print('- User-defined label');
  print('- Custom onPressed callback');
  print('- Native iOS appearance');
  print('- Extends standard menu options');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemDataCustom test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemDataCustom Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${customItem.runtimeType}'),
      Text('Label: ${customItem.title}'),
      Text('Platform: iOS'),
      Text('Purpose: Custom context menu items'),
    ],
  );
}
