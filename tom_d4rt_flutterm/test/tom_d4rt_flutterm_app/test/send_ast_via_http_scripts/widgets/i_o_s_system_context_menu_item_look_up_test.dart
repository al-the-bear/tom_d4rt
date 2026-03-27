// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemLookUp from widgets
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemLookUp test executing');
  print('=' * 50);

  // === IOSSystemContextMenuItemLookUp class tests ===
  // IOSSystemContextMenuItemLookUp is a final class that represents
  // the system's built-in look up button in iOS context menus.
  // It should only appear when content is selected.

  // Test 1: Create with default (null) title
  print('\nTest 1: Default constructor (null title)');
  const lookUp1 = IOSSystemContextMenuItemLookUp();
  print('Created IOSSystemContextMenuItemLookUp with const constructor');
  print('Type: ${lookUp1.runtimeType}');
  print('Title (default): ${lookUp1.title}');
  print('Is title null: ${lookUp1.title == null}');

  // Test 2: Create with custom title
  print('\nTest 2: Constructor with custom title');
  const lookUp2 = IOSSystemContextMenuItemLookUp(title: 'Look Up Selection');
  print('Created with title: "${lookUp2.title}"');
  print('Type: ${lookUp2.runtimeType}');

  // Test 3: Test Diagnosticable mixin
  print('\nTest 3: Diagnosticable mixin');
  print('lookUp1 is Diagnosticable: ${lookUp1 is Diagnosticable}');
  final builder = DiagnosticPropertiesBuilder();
  lookUp2.debugFillProperties(builder);
  print('Has DiagnosticsProperty for title: ${builder.properties.any((p) => p.name == "title")}');

  // Test 4: Hash code and equality
  print('\nTest 4: Equality and hashCode');
  const lookUp3 = IOSSystemContextMenuItemLookUp();
  const lookUp4 = IOSSystemContextMenuItemLookUp(title: 'Look Up Selection');
  print('lookUp1 == lookUp3 (both null title): ${lookUp1 == lookUp3}');
  print('lookUp2 == lookUp4 (same title): ${lookUp2 == lookUp4}');
  print('lookUp1 == lookUp2 (different title): ${lookUp1 == lookUp2}');
  print('lookUp1.hashCode: ${lookUp1.hashCode}');
  print('lookUp3.hashCode: ${lookUp3.hashCode}');
  print('lookUp1.hashCode == lookUp3.hashCode: ${lookUp1.hashCode == lookUp3.hashCode}');

  // Test 5: Test IOSSystemContextMenuItem hierarchy
  print('\nTest 5: IOSSystemContextMenuItem hierarchy');
  print('lookUp1 is IOSSystemContextMenuItem: ${lookUp1 is IOSSystemContextMenuItem}');

  // Test 6: Const constructability
  print('\nTest 6: Const constructability');
  const items = [
    IOSSystemContextMenuItemLookUp(),
    IOSSystemContextMenuItemLookUp(title: 'Dictionary'),
    IOSSystemContextMenuItemLookUp(title: 'Define'),
  ];
  print('Created const list with ${items.length} items');
  for (final item in items) {
    print('  - title: ${item.title ?? "(default)"}');
  }

  // Test 7: Different instances
  print('\nTest 7: Multiple instances');
  final instances = [
    const IOSSystemContextMenuItemLookUp(),
    const IOSSystemContextMenuItemLookUp(title: 'Look Up'),
    const IOSSystemContextMenuItemLookUp(title: 'Search Dictionary'),
  ];
  print('Instance 1 title: ${instances[0].title}');
  print('Instance 2 title: ${instances[1].title}');
  print('Instance 3 title: ${instances[2].title}');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemLookUp test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemLookUp Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 7 categories executed'),
      Text('Class type: sealed final class'),
      Text('Mixin: Diagnosticable'),
      Text('Purpose: iOS system look up button'),
    ],
  );
}
