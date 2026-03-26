// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshIndicatorTriggerMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RefreshIndicatorTriggerMode test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nRefreshIndicatorTriggerMode values:');
  for (final value in RefreshIndicatorTriggerMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('RefreshIndicatorTriggerMode has ${RefreshIndicatorTriggerMode.values.length} values');

  // First and last
  final first = RefreshIndicatorTriggerMode.values.first;
  final last = RefreshIndicatorTriggerMode.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('onEdge: ${RefreshIndicatorTriggerMode.onEdge.name} (index ${RefreshIndicatorTriggerMode.onEdge.index})');
  print('anywhere: ${RefreshIndicatorTriggerMode.anywhere.name} (index ${RefreshIndicatorTriggerMode.anywhere.index})');

  // Usage description
  print('\nUsage context:');
  print('onEdge: Refresh only triggers when scrolled to the edge');
  print('  Default behavior - pull from top to refresh');
  print('  User must scroll to the very top first');
  print('anywhere: Refresh triggers regardless of scroll position');
  print('  Pull down from any position to start refresh');
  print('  Useful for short lists that do not scroll');

  // Equality
  print('\nEquality tests:');
  print('onEdge == onEdge: ${RefreshIndicatorTriggerMode.onEdge == RefreshIndicatorTriggerMode.onEdge}');
  print('onEdge == anywhere: ${RefreshIndicatorTriggerMode.onEdge == RefreshIndicatorTriggerMode.anywhere}');
  print('identical: ${identical(RefreshIndicatorTriggerMode.onEdge, RefreshIndicatorTriggerMode.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is RefreshIndicatorTriggerMode: ${first is RefreshIndicatorTriggerMode}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in RefreshIndicatorTriggerMode.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with RefreshIndicator
  print('\nRefreshIndicator integration:');
  final onEdgeIndicator = RefreshIndicator(
    onRefresh: () async {},
    triggerMode: RefreshIndicatorTriggerMode.onEdge,
    child: ListView(children: [ListTile(title: Text('Item'))]),
  );
  print('onEdge indicator: triggerMode=${onEdgeIndicator.triggerMode}');
  print('displacement: ${onEdgeIndicator.displacement}');

  final anywhereIndicator = RefreshIndicator(
    onRefresh: () async {},
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    displacement: 60.0,
    child: ListView(children: [ListTile(title: Text('Item'))]),
  );
  print('anywhere indicator: triggerMode=${anywhereIndicator.triggerMode}');
  print('displacement: ${anywhereIndicator.displacement}');

  // Default value
  final defaultIndicator = RefreshIndicator(
    onRefresh: () async {},
    child: ListView(children: []),
  );
  print('\nDefault triggerMode: ${defaultIndicator.triggerMode}');

  print('\n' + '=' * 50);
  print('RefreshIndicatorTriggerMode test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RefreshIndicatorTriggerMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${RefreshIndicatorTriggerMode.values.length}'),
      for (final v in RefreshIndicatorTriggerMode.values)
        Text('  ${v.name} (${v.index})'),
      Text('Default: ${defaultIndicator.triggerMode}'),
    ],
  );
}
