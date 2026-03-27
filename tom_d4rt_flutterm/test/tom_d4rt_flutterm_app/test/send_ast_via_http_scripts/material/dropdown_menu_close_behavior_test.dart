// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests DropdownMenuCloseBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenuCloseBehavior test executing');
  print('=' * 50);

  // DropdownMenuCloseBehavior is an enum with 3 values
  print('DropdownMenuCloseBehavior enum values:');
  for (final behavior in DropdownMenuCloseBehavior.values) {
    print('  ${behavior.name}: index=${behavior.index}');
  }
  print('DropdownMenuCloseBehavior has ${DropdownMenuCloseBehavior.values.length} values');

  // Test first and last
  final first = DropdownMenuCloseBehavior.values.first;
  final last = DropdownMenuCloseBehavior.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test all
  print('\nTesting DropdownMenuCloseBehavior.all:');
  final all = DropdownMenuCloseBehavior.all;
  print('  name: ${all.name}');
  print('  index: ${all.index}');
  print('  toString: $all');
  print('  Purpose: Closes all open menus in widget tree');

  // Test self
  print('\nTesting DropdownMenuCloseBehavior.self:');
  final self = DropdownMenuCloseBehavior.self;
  print('  name: ${self.name}');
  print('  index: ${self.index}');
  print('  Purpose: Closes only current dropdown menu');

  // Test none
  print('\nTesting DropdownMenuCloseBehavior.none:');
  final none = DropdownMenuCloseBehavior.none;
  print('  name: ${none.name}');
  print('  index: ${none.index}');
  print('  Purpose: Does not close any menus');

  // Test equality
  print('\nEquality tests:');
  print('all == all: ${all == all}');
  print('all == self: ${all == self}');
  print('self == none: ${self == none}');

  // Usage with DropdownMenu
  print('\nUsage with DropdownMenu:');
  print('DropdownMenu closeBehavior property');

  // Create DropdownMenu with different behaviors
  final menu1 = DropdownMenu<String>(
    closeBehavior: DropdownMenuCloseBehavior.all,
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'a', label: 'Option A'),
      DropdownMenuEntry(value: 'b', label: 'Option B'),
    ],
  );
  print('DropdownMenu with closeBehavior.all created');

  final menu2 = DropdownMenu<String>(
    closeBehavior: DropdownMenuCloseBehavior.self,
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'x', label: 'Option X'),
    ],
  );
  print('DropdownMenu with closeBehavior.self created');

  final menu3 = DropdownMenu<String>(
    closeBehavior: DropdownMenuCloseBehavior.none,
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'z', label: 'Option Z'),
    ],
  );
  print('DropdownMenu with closeBehavior.none created');

  // Test index ordering
  print('\nIndex ordering:');
  print('all.index: ${all.index}');
  print('self.index: ${self.index}');
  print('none.index: ${none.index}');

  // Use case scenarios
  print('\nUse case scenarios:');
  print('all: Nested menus should all close');
  print('self: Keep parent menus open');
  print('none: Manual close control');

  print('\n' + '=' * 50);
  print('DropdownMenuCloseBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DropdownMenuCloseBehavior Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${DropdownMenuCloseBehavior.values.length}'),
      Text('all: close all menus'),
      Text('self: close only current'),
      Text('none: no auto-close'),
    ],
  );
}
