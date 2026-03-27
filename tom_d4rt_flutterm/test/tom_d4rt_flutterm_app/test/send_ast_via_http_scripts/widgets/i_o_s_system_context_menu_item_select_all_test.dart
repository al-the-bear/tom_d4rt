// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemSelectAll from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemSelectAll test executing');
  print('=' * 50);

  // === IOSSystemContextMenuItemSelectAll class tests ===
  // IOSSystemContextMenuItemSelectAll creates an iOS context menu item
  // for the system's built-in select all button.
  // Should only appear when the field can have its selection changed.
  // The title and action are both handled by the platform.

  // Test 1: Create instance with const constructor
  print('\nTest 1: Create instance');
  const selectAll1 = IOSSystemContextMenuItemSelectAll();
  print('Created IOSSystemContextMenuItemSelectAll');
  print('Type: ${selectAll1.runtimeType}');

  // Test 2: Verify title is not exposed (platform-handled)
  print('\nTest 2: Title property');
  print('Title: ${selectAll1.title}');
  print('Title is null (platform-handled): ${selectAll1.title == null}');

  // Test 3: Test IOSSystemContextMenuItem hierarchy
  print('\nTest 3: Type hierarchy');
  print('selectAll1 is IOSSystemContextMenuItem: ${selectAll1 is IOSSystemContextMenuItem}');

  // Test 4: Hash code and equality
  print('\nTest 4: Equality and hashCode');
  const selectAll2 = IOSSystemContextMenuItemSelectAll();
  const selectAll3 = IOSSystemContextMenuItemSelectAll();
  print('selectAll1 == selectAll2: ${selectAll1 == selectAll2}');
  print('selectAll2 == selectAll3: ${selectAll2 == selectAll3}');
  print('selectAll1.hashCode: ${selectAll1.hashCode}');
  print('selectAll2.hashCode: ${selectAll2.hashCode}');
  print('Hash codes equal: ${selectAll1.hashCode == selectAll2.hashCode}');

  // Test 5: Const constructability
  print('\nTest 5: Const constructability');
  const items = [
    IOSSystemContextMenuItemSelectAll(),
    IOSSystemContextMenuItemSelectAll(),
    IOSSystemContextMenuItemSelectAll(),
  ];
  print('Created const list with ${items.length} identical items');
  print('All items equal: ${items[0] == items[1] && items[1] == items[2]}');

  // Test 6: Runtime type verification
  print('\nTest 6: Runtime type verification');
  print('runtimeType: ${selectAll1.runtimeType}');
  print('toString: $selectAll1');

  // Test 7: Identity and const canonicalization
  print('\nTest 7: Const canonicalization');
  const selectAllA = IOSSystemContextMenuItemSelectAll();
  const selectAllB = IOSSystemContextMenuItemSelectAll();
  print('identical(selectAllA, selectAllB): ${identical(selectAllA, selectAllB)}');

  // Test 8: Usage in menu item list
  print('\nTest 8: Usage in menu item list');
  final menuItems = <IOSSystemContextMenuItem>[
    const IOSSystemContextMenuItemSelectAll(),
  ];
  print('Can add to IOSSystemContextMenuItem list: ${menuItems.length == 1}');
  print('List item type: ${menuItems.first.runtimeType}');

  // Test 9: Comparison with other menu items
  print('\nTest 9: Comparison with other items');
  const paste = IOSSystemContextMenuItemPaste();
  print('selectAll == paste: ${selectAll1 == paste}');
  print('Different types: ${selectAll1.runtimeType != paste.runtimeType}');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemSelectAll test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemSelectAll Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 9 categories executed'),
      Text('Class type: sealed final class'),
      Text('Platform: iOS context menu'),
      Text('Purpose: System select all action'),
    ],
  );
}
