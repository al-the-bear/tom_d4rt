// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownMenuCloseBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenuCloseBehavior test executing');
  print('=' * 50);

  // DropdownMenuCloseBehavior enum for menu closing
  print('DropdownMenuCloseBehavior overview:');
  print('  - Enum for dropdown menu close behavior');
  print('  - Used with DropdownMenu widget');
  print('  - Controls how menu closes on selection');

  // All enum values
  print('\nAll DropdownMenuCloseBehavior values:');
  for (final value in DropdownMenuCloseBehavior.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${DropdownMenuCloseBehavior.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const all = DropdownMenuCloseBehavior.all;
  const self = DropdownMenuCloseBehavior.self;
  const none = DropdownMenuCloseBehavior.none;

  print('  all: $all');
  print('    - Closes all open menus in widget tree');
  print('    - Use for nested menus');
  print('    - Dismisses entire menu hierarchy');
  print('    - Standard single-select behavior');

  print('  self: $self');
  print('    - Closes only the current dropdown');
  print('    - Parent menus stay open');
  print('    - Good for sub-menus');
  print('    - Cascading menu pattern');

  print('  none: $none');
  print('    - Does not close any menus');
  print('    - Selection updates without closing');
  print('    - User must close manually');
  print('    - Multi-select pattern');

  // Usage in DropdownMenu
  print('\nUsage in DropdownMenu:');
  print('  DropdownMenu<String>(');
  print('    closeBehavior: DropdownMenuCloseBehavior.all,');
  print('    dropdownMenuEntries: [');
  print('      DropdownMenuEntry(value: "a", label: "A"),');
  print('      DropdownMenuEntry(value: "b", label: "B"),');
  print('    ],');
  print('    onSelected: (value) { ... },');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = DropdownMenuCloseBehavior.values.first;
  final last = DropdownMenuCloseBehavior.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Default behavior
  print('\nDefault:');
  print('  Default behavior is DropdownMenuCloseBehavior.all');
  print('  Set via DropdownMenuThemeData for app-wide');

  // Nested dropdown use case
  print('\nNested dropdown use case:');
  print('  OuterMenu with closeBehavior.all:');
  print('    - InnerMenu1 selection closes both');
  print('    - InnerMenu2 selection closes both');
  print('  OuterMenu with closeBehavior.self:');
  print('    - InnerMenu1 selection closes only inner');
  print('    - OuterMenu remains open');

  // Common patterns
  print('\nCommon patterns:');
  print('  Single dropdown: use .all (default)');
  print('  Multi-select dropdown: use .none');
  print('  Cascading menus: use .self');

  print('\n' + '=' * 50);
  print('DropdownMenuCloseBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DropdownMenuCloseBehavior Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: all, self, none'),
      Text('Use: Menu close on selection'),
    ],
  );
}
