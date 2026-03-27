// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemPaste from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemPaste test executing');
  print('=' * 50);

  // === IOSSystemContextMenuItemPaste class tests ===
  // IOSSystemContextMenuItemPaste is a final class that represents
  // the system's built-in paste button in iOS context menus.
  // It should only appear when the field can receive pasted content.
  // The title and action are both handled by the platform.

  // Test 1: Create instance with const constructor
  print('\nTest 1: Create instance');
  const paste1 = IOSSystemContextMenuItemPaste();
  print('Created IOSSystemContextMenuItemPaste with const constructor');
  print('Type: ${paste1.runtimeType}');

  // Test 2: Verify title is not exposed (handled by platform)
  print('\nTest 2: Title property');
  print('Title: ${paste1.title}');
  print('Title is null (platform-handled): ${paste1.title == null}');

  // Test 3: Test IOSSystemContextMenuItem hierarchy
  print('\nTest 3: Type hierarchy');
  print('paste1 is IOSSystemContextMenuItem: ${paste1 is IOSSystemContextMenuItem}');

  // Test 4: Hash code and equality
  print('\nTest 4: Equality and hashCode');
  const paste2 = IOSSystemContextMenuItemPaste();
  const paste3 = IOSSystemContextMenuItemPaste();
  print('paste1 == paste2: ${paste1 == paste2}');
  print('paste2 == paste3: ${paste2 == paste3}');
  print('paste1.hashCode: ${paste1.hashCode}');
  print('paste2.hashCode: ${paste2.hashCode}');
  print('Hash codes equal: ${paste1.hashCode == paste2.hashCode}');

  // Test 5: Const constructability
  print('\nTest 5: Const constructability');
  const items = [
    IOSSystemContextMenuItemPaste(),
    IOSSystemContextMenuItemPaste(),
    IOSSystemContextMenuItemPaste(),
  ];
  print('Created const list with ${items.length} identical items');
  print('All items equal: ${items[0] == items[1] && items[1] == items[2]}');

  // Test 6: Runtime type verification
  print('\nTest 6: Runtime type verification');
  print('runtimeType: ${paste1.runtimeType}');
  print('toString: $paste1');

  // Test 7: Identity and const canonicalization
  print('\nTest 7: Const canonicalization');
  const pasteA = IOSSystemContextMenuItemPaste();
  const pasteB = IOSSystemContextMenuItemPaste();
  print('identical(pasteA, pasteB): ${identical(pasteA, pasteB)}');

  // Test 8: Usage pattern verification
  print('\nTest 8: Typical usage pattern');
  final menuItems = <IOSSystemContextMenuItem>[
    const IOSSystemContextMenuItemPaste(),
  ];
  print('Can add to IOSSystemContextMenuItem list: ${menuItems.length == 1}');
  print('List item type: ${menuItems.first.runtimeType}');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemPaste test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemPaste Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 8 categories executed'),
      Text('Class type: sealed final class'),
      Text('Platform: iOS context menu'),
      Text('Purpose: System paste action'),
    ],
  );
}
