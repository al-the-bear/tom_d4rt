// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationRailLabelType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationRailLabelType test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nNavigationRailLabelType values:');
  for (final value in NavigationRailLabelType.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('NavigationRailLabelType has ${NavigationRailLabelType.values.length} values');

  // First and last
  final first = NavigationRailLabelType.values.first;
  final last = NavigationRailLabelType.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('none: ${NavigationRailLabelType.none.name} (index ${NavigationRailLabelType.none.index})');
  print('selected: ${NavigationRailLabelType.selected.name} (index ${NavigationRailLabelType.selected.index})');
  print('all: ${NavigationRailLabelType.all.name} (index ${NavigationRailLabelType.all.index})');

  // Usage description
  print('\nUsage context:');
  print('none: No labels are shown on the rail');
  print('selected: Only the selected destination shows its label');
  print('all: All destinations show their labels');

  // Equality
  print('\nEquality tests:');
  print('none == none: ${NavigationRailLabelType.none == NavigationRailLabelType.none}');
  print('none == selected: ${NavigationRailLabelType.none == NavigationRailLabelType.selected}');
  print('none == all: ${NavigationRailLabelType.none == NavigationRailLabelType.all}');
  print('identical: ${identical(NavigationRailLabelType.none, NavigationRailLabelType.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is NavigationRailLabelType: ${first is NavigationRailLabelType}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in NavigationRailLabelType.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with NavigationRail
  print('\nNavigationRail integration:');
  for (final labelType in NavigationRailLabelType.values) {
    final rail = NavigationRail(
      labelType: labelType,
      selectedIndex: 0,
      destinations: [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
        NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
      ],
    );
    print('  NavigationRail with ${labelType.name}: ${rail.labelType}');
  }

  // NavigationRailThemeData
  print('\nNavigationRailThemeData integration:');
  final theme = NavigationRailThemeData(labelType: NavigationRailLabelType.all);
  print('Theme labelType: ${theme.labelType}');

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
      Text('Values: ${NavigationRailLabelType.values.length}'),
      for (final v in NavigationRailLabelType.values)
        Text('  ${v.name} (${v.index})'),
      Text('Used with NavigationRail.labelType'),
    ],
  );
}
