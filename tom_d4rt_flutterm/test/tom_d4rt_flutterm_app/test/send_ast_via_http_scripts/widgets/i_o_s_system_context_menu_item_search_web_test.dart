// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemSearchWeb from widgets
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemSearchWeb test executing');
  print('=' * 50);

  // === IOSSystemContextMenuItemSearchWeb class tests ===
  // IOSSystemContextMenuItemSearchWeb creates an iOS context menu item
  // for the system's built-in search web button.
  // Should only appear when content is selected.

  // Test 1: Create with default (null) title
  print('\nTest 1: Default constructor (null title)');
  const searchWeb1 = IOSSystemContextMenuItemSearchWeb();
  print('Created IOSSystemContextMenuItemSearchWeb');
  print('Type: ${searchWeb1.runtimeType}');
  print('Title (default): ${searchWeb1.title}');
  print('Is title null: ${searchWeb1.title == null}');

  // Test 2: Create with custom title
  print('\nTest 2: Constructor with custom title');
  const searchWeb2 = IOSSystemContextMenuItemSearchWeb(title: 'Search Web');
  print('Created with title: "${searchWeb2.title}"');
  print('Type: ${searchWeb2.runtimeType}');

  // Test 3: Test Diagnosticable mixin
  print('\nTest 3: Diagnosticable mixin');
  print('searchWeb1 is Diagnosticable: ${searchWeb1 is Diagnosticable}');
  final builder = DiagnosticPropertiesBuilder();
  searchWeb2.debugFillProperties(builder);
  print('Has DiagnosticsProperty for title: ${builder.properties.any((p) => p.name == "title")}');

  // Test 4: Hash code and equality
  print('\nTest 4: Equality and hashCode');
  const searchWeb3 = IOSSystemContextMenuItemSearchWeb();
  const searchWeb4 = IOSSystemContextMenuItemSearchWeb(title: 'Search Web');
  print('searchWeb1 == searchWeb3: ${searchWeb1 == searchWeb3}');
  print('searchWeb2 == searchWeb4: ${searchWeb2 == searchWeb4}');
  print('searchWeb1 == searchWeb2: ${searchWeb1 == searchWeb2}');
  print('searchWeb1.hashCode: ${searchWeb1.hashCode}');
  print('Equal hashCodes: ${searchWeb1.hashCode == searchWeb3.hashCode}');

  // Test 5: Test IOSSystemContextMenuItem hierarchy
  print('\nTest 5: IOSSystemContextMenuItem hierarchy');
  print('searchWeb1 is IOSSystemContextMenuItem: ${searchWeb1 is IOSSystemContextMenuItem}');

  // Test 6: Const constructability
  print('\nTest 6: Const constructability');
  const items = [
    IOSSystemContextMenuItemSearchWeb(),
    IOSSystemContextMenuItemSearchWeb(title: 'Google Search'),
    IOSSystemContextMenuItemSearchWeb(title: 'Web Search'),
  ];
  print('Created const list with ${items.length} items');
  for (int i = 0; i < items.length; i++) {
    print('  Item $i title: ${items[i].title ?? "(default)"}');
  }

  // Test 7: Different title values
  print('\nTest 7: Different title values');
  final variations = [
    const IOSSystemContextMenuItemSearchWeb(title: 'Search the Web'),
    const IOSSystemContextMenuItemSearchWeb(title: 'Find Online'),
    const IOSSystemContextMenuItemSearchWeb(title: 'Web Lookup'),
  ];
  for (final v in variations) {
    print('  Title: ${v.title}');
  }

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemSearchWeb test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemSearchWeb Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 7 categories executed'),
      Text('Class type: sealed final class'),
      Text('Mixin: Diagnosticable'),
      Text('Purpose: iOS web search action'),
    ],
  );
}
