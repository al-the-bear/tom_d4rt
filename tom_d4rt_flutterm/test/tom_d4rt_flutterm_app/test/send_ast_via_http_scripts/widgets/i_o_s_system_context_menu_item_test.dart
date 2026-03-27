// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItem from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItem test executing');
  print('=' * 50);

  // === IOSSystemContextMenuItem sealed class tests ===
  // IOSSystemContextMenuItem is a sealed base class for all iOS
  // context menu items. It defines the contract for menu items
  // that appear in iOS system context menus.

  // Test 1: Test the sealed class hierarchy
  print('\nTest 1: Sealed class hierarchy');
  const copy = IOSSystemContextMenuItemCopy();
  const cut = IOSSystemContextMenuItemCut();
  const paste = IOSSystemContextMenuItemPaste();
  const selectAll = IOSSystemContextMenuItemSelectAll();
  print('IOSSystemContextMenuItemCopy is IOSSystemContextMenuItem: ${copy is IOSSystemContextMenuItem}');
  print('IOSSystemContextMenuItemCut is IOSSystemContextMenuItem: ${cut is IOSSystemContextMenuItem}');
  print('IOSSystemContextMenuItemPaste is IOSSystemContextMenuItem: ${paste is IOSSystemContextMenuItem}');
  print('IOSSystemContextMenuItemSelectAll is IOSSystemContextMenuItem: ${selectAll is IOSSystemContextMenuItem}');

  // Test 2: Title property (null for platform-handled items)
  print('\nTest 2: Title property');
  print('copy.title: ${copy.title}');
  print('cut.title: ${cut.title}');
  print('paste.title: ${paste.title}');
  print('selectAll.title: ${selectAll.title}');

  // Test 3: Items with customizable title
  print('\nTest 3: Items with customizable title');
  const lookUp = IOSSystemContextMenuItemLookUp(title: 'Look Up');
  const searchWeb = IOSSystemContextMenuItemSearchWeb(title: 'Search');
  const share = IOSSystemContextMenuItemShare(title: 'Share');
  print('lookUp.title: ${lookUp.title}');
  print('searchWeb.title: ${searchWeb.title}');
  print('share.title: ${share.title}');

  // Test 4: Equality (based on title)
  print('\nTest 4: Equality semantics');
  const copy2 = IOSSystemContextMenuItemCopy();
  print('copy == copy2: ${copy == copy2}');
  print('copy == cut (different types): ${copy == cut}');
  const lookUp2 = IOSSystemContextMenuItemLookUp(title: 'Look Up');
  print('lookUp == lookUp2 (same title): ${lookUp == lookUp2}');

  // Test 5: Hash code behavior
  print('\nTest 5: Hash code behavior');
  print('copy.hashCode: ${copy.hashCode}');
  print('copy2.hashCode: ${copy2.hashCode}');
  print('Hash codes equal: ${copy.hashCode == copy2.hashCode}');

  // Test 6: List of menu items
  print('\nTest 6: Building menu item lists');
  final menuItems = <IOSSystemContextMenuItem>[
    const IOSSystemContextMenuItemCopy(),
    const IOSSystemContextMenuItemCut(),
    const IOSSystemContextMenuItemPaste(),
    const IOSSystemContextMenuItemSelectAll(),
    const IOSSystemContextMenuItemLookUp(),
    const IOSSystemContextMenuItemSearchWeb(),
    const IOSSystemContextMenuItemShare(),
  ];
  print('Total menu items: ${menuItems.length}');
  for (final item in menuItems) {
    print('  ${item.runtimeType} - title: ${item.title ?? "(platform)"}');
  }

  // Test 7: Runtime type checking
  print('\nTest 7: Runtime type checking');
  for (final item in menuItems) {
    print('${item.runtimeType}');
  }

  // Test 8: Const canonicalization
  print('\nTest 8: Const canonicalization');
  const c1 = IOSSystemContextMenuItemCopy();
  const c2 = IOSSystemContextMenuItemCopy();
  print('identical(c1, c2): ${identical(c1, c2)}');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItem test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItem Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 8 categories executed'),
      Text('Type: sealed class'),
      Text('Subclasses: Copy, Cut, Paste, etc.'),
      Text('Purpose: iOS context menu base'),
    ],
  );
}
