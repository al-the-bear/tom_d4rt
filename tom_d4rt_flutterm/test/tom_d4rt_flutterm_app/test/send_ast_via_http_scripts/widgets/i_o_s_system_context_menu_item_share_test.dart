// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemShare from widgets
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IOSSystemContextMenuItemShare test executing');
  print('=' * 50);

  // === IOSSystemContextMenuItemShare class tests ===
  // IOSSystemContextMenuItemShare creates an iOS context menu item
  // for the system's built-in share button.
  // Opens the system share dialog.
  // Should only appear when shareable content is selected.

  // Test 1: Create with default (null) title
  print('\nTest 1: Default constructor (null title)');
  const share1 = IOSSystemContextMenuItemShare();
  print('Created IOSSystemContextMenuItemShare');
  print('Type: ${share1.runtimeType}');
  print('Title (default): ${share1.title}');
  print('Is title null: ${share1.title == null}');

  // Test 2: Create with custom title
  print('\nTest 2: Constructor with custom title');
  const share2 = IOSSystemContextMenuItemShare(title: 'Share Selection');
  print('Created with title: "${share2.title}"');
  print('Type: ${share2.runtimeType}');

  // Test 3: Test Diagnosticable mixin
  print('\nTest 3: Diagnosticable mixin');
  print('share1 is Diagnosticable: ${share1 is Diagnosticable}');
  final builder = DiagnosticPropertiesBuilder();
  share2.debugFillProperties(builder);
  print('Has property for title: ${builder.properties.any((p) => p.name == "title")}');

  // Test 4: Hash code and equality
  print('\nTest 4: Equality and hashCode');
  const share3 = IOSSystemContextMenuItemShare();
  const share4 = IOSSystemContextMenuItemShare(title: 'Share Selection');
  print('share1 == share3: ${share1 == share3}');
  print('share2 == share4: ${share2 == share4}');
  print('share1 == share2: ${share1 == share2}');
  print('share1.hashCode: ${share1.hashCode}');
  print('Equal hashCodes: ${share1.hashCode == share3.hashCode}');

  // Test 5: Test IOSSystemContextMenuItem hierarchy
  print('\nTest 5: IOSSystemContextMenuItem hierarchy');
  print('share1 is IOSSystemContextMenuItem: ${share1 is IOSSystemContextMenuItem}');

  // Test 6: Const constructability
  print('\nTest 6: Const constructability');
  const items = [
    IOSSystemContextMenuItemShare(),
    IOSSystemContextMenuItemShare(title: 'Share'),
    IOSSystemContextMenuItemShare(title: 'Send to...'),
  ];
  print('Created const list with ${items.length} items');
  for (int i = 0; i < items.length; i++) {
    print('  Item $i title: ${items[i].title ?? "(default)"}');
  }

  // Test 7: Different title variations
  print('\nTest 7: Different title variations');
  final variations = [
    const IOSSystemContextMenuItemShare(title: 'Share via...'),
    const IOSSystemContextMenuItemShare(title: 'Send'),
    const IOSSystemContextMenuItemShare(title: 'Export'),
  ];
  for (final v in variations) {
    print('  Title: ${v.title}');
  }

  // Test 8: Usage pattern
  print('\nTest 8: Usage pattern');
  final menuItems = <IOSSystemContextMenuItem>[
    const IOSSystemContextMenuItemShare(),
    const IOSSystemContextMenuItemShare(title: 'Custom Share'),
  ];
  print('Menu items count: ${menuItems.length}');

  print('\n' + '=' * 50);
  print('IOSSystemContextMenuItemShare test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IOSSystemContextMenuItemShare Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 8 categories executed'),
      Text('Class type: sealed final class'),
      Text('Mixin: Diagnosticable'),
      Text('Purpose: iOS share dialog action'),
    ],
  );
}
