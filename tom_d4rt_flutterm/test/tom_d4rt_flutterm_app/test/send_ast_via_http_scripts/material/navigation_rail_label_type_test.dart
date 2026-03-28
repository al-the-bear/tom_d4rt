// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationRailLabelType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationRailLabelType test executing');
  print('=' * 50);

  // NavigationRailLabelType enum
  print('NavigationRailLabelType overview:');
  print('  - Enum for NavigationRail label display');
  print('  - Used with NavigationRail widget');
  print('  - Controls when labels appear');

  // All enum values
  print('\nAll NavigationRailLabelType values:');
  for (final value in NavigationRailLabelType.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${NavigationRailLabelType.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const none = NavigationRailLabelType.none;
  const selected = NavigationRailLabelType.selected;
  const all = NavigationRailLabelType.all;

  print('  none: $none');
  print('    - No labels shown');
  print('    - Icons only');
  print('    - Most compact');
  print('    - Requires tooltips');

  print('  selected: $selected');
  print('    - Label only for selected');
  print('    - Unselected show icons');
  print('    - Default behavior');
  print('    - Balanced approach');

  print('  all: $all');
  print('    - Labels for all destinations');
  print('    - Most informative');
  print('    - Takes more space');
  print('    - High accessibility');

  // Usage in NavigationRail
  print('\nUsage in NavigationRail:');
  print('  NavigationRail(');
  print('    labelType: NavigationRailLabelType.selected,');
  print('    destinations: [');
  print('      NavigationRailDestination(');
  print('        icon: Icon(Icons.home),');
  print('        label: Text("Home"),');
  print('      ),');
  print('    ],');
  print('    selectedIndex: 0,');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = NavigationRailLabelType.values.first;
  final last = NavigationRailLabelType.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Related enum
  print('\nRelated:');
  print('  NavigationDestinationLabelBehavior for NavigationBar');

  // Default value
  print('\nDefault: NavigationRailLabelType.none');

  print('\n' + '=' * 50);
  print('NavigationRailLabelType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NavigationRailLabelType Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: none, selected, all'),
      Text('Use: NavigationRail labels'),
    ],
  );
}
