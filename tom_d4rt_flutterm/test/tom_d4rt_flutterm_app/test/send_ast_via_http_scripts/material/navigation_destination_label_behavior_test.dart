// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationDestinationLabelBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDestinationLabelBehavior test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nNavigationDestinationLabelBehavior values:');
  for (final value in NavigationDestinationLabelBehavior.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('NavigationDestinationLabelBehavior has ${NavigationDestinationLabelBehavior.values.length} values');

  // First and last
  final first = NavigationDestinationLabelBehavior.values.first;
  final last = NavigationDestinationLabelBehavior.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('alwaysShow: ${NavigationDestinationLabelBehavior.alwaysShow.name} (index ${NavigationDestinationLabelBehavior.alwaysShow.index})');
  print('alwaysHide: ${NavigationDestinationLabelBehavior.alwaysHide.name} (index ${NavigationDestinationLabelBehavior.alwaysHide.index})');
  print('onlyShowSelected: ${NavigationDestinationLabelBehavior.onlyShowSelected.name} (index ${NavigationDestinationLabelBehavior.onlyShowSelected.index})');

  // Usage description
  print('\nUsage context:');
  print('alwaysShow: All destination labels are always visible');
  print('alwaysHide: All destination labels are always hidden');
  print('onlyShowSelected: Only the selected destination label is shown');

  // Equality
  print('\nEquality tests:');
  print('alwaysShow == alwaysShow: ${NavigationDestinationLabelBehavior.alwaysShow == NavigationDestinationLabelBehavior.alwaysShow}');
  print('alwaysShow == alwaysHide: ${NavigationDestinationLabelBehavior.alwaysShow == NavigationDestinationLabelBehavior.alwaysHide}');
  print('identical: ${identical(NavigationDestinationLabelBehavior.alwaysShow, NavigationDestinationLabelBehavior.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is NavigationDestinationLabelBehavior: ${first is NavigationDestinationLabelBehavior}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in NavigationDestinationLabelBehavior.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with NavigationBar
  print('\nNavigationBar integration:');
  for (final behavior in NavigationDestinationLabelBehavior.values) {
    final bar = NavigationBar(
      labelBehavior: behavior,
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      ],
    );
    print('  NavigationBar with ${behavior.name}: ${bar.labelBehavior}');
  }

  print('\n' + '=' * 50);
  print('NavigationDestinationLabelBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NavigationDestinationLabelBehavior Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${NavigationDestinationLabelBehavior.values.length}'),
      for (final v in NavigationDestinationLabelBehavior.values)
        Text('  ${v.name} (${v.index})'),
      Text('Used with NavigationBar.labelBehavior'),
    ],
  );
}
