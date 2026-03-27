// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests NavigationRailLabelType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationRailLabelType test executing');
  print('=' * 50);

  // NavigationRailLabelType is an enum with 3 values
  print('NavigationRailLabelType enum values:');
  for (final type in NavigationRailLabelType.values) {
    print('  ${type.name}: index=${type.index}');
  }
  print('NavigationRailLabelType has ${NavigationRailLabelType.values.length} values');

  // Test first and last
  final first = NavigationRailLabelType.values.first;
  final last = NavigationRailLabelType.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test none
  print('\nTesting NavigationRailLabelType.none:');
  final none = NavigationRailLabelType.none;
  print('  name: ${none.name}');
  print('  index: ${none.index}');
  print('  toString: $none');
  print('  Purpose: Only icons shown');

  // Test selected
  print('\nTesting NavigationRailLabelType.selected:');
  final selected = NavigationRailLabelType.selected;
  print('  name: ${selected.name}');
  print('  index: ${selected.index}');
  print('  Purpose: Only selected shows label');
  print('  Animation: Label animates in/out');

  // Test all
  print('\nTesting NavigationRailLabelType.all:');
  final all = NavigationRailLabelType.all;
  print('  name: ${all.name}');
  print('  index: ${all.index}');
  print('  Purpose: All destinations show labels');

  // Test equality
  print('\nEquality tests:');
  print('none == none: ${none == none}');
  print('none == selected: ${none == selected}');
  print('selected == all: ${selected == all}');

  // Usage with NavigationRail
  print('\nUsage with NavigationRail:');
  final rail1 = NavigationRail(
    selectedIndex: 0,
    labelType: NavigationRailLabelType.none,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
      NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
    ],
  );
  print('NavigationRail with none created');

  final rail2 = NavigationRail(
    selectedIndex: 0,
    labelType: NavigationRailLabelType.selected,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.folder), label: Text('Files')),
      NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
    ],
  );
  print('NavigationRail with selected created');

  final rail3 = NavigationRail(
    selectedIndex: 1,
    labelType: NavigationRailLabelType.all,
    destinations: [
      NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
      NavigationRailDestination(icon: Icon(Icons.analytics), label: Text('Analytics')),
    ],
  );
  print('NavigationRail with all created');

  // Index ordering
  print('\nIndex ordering:');
  print('none.index: ${none.index}');
  print('selected.index: ${selected.index}');
  print('all.index: ${all.index}');

  // Use cases
  print('\nUse cases:');
  print('none: Compact sidebar, tooltip on hover');
  print('selected: Material adaptive, balanced');
  print('all: Wide sidebar, full disclosure');

  // Comparison to NavigationDestinationLabelBehavior
  print('\nRelated to NavigationDestinationLabelBehavior');
  print('  Used by NavigationRail');
  print('  NavigationDestinationLabelBehavior for NavigationBar');

  print('\n' + '=' * 50);
  print('NavigationRailLabelType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationRailLabelType Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${NavigationRailLabelType.values.length}'),
      Text('none: icons only'),
      Text('selected: animated labels'),
      Text('all: always show labels'),
    ],
  );
}
