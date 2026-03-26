// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabAlignment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabAlignment test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTabAlignment values:');
  for (final value in TabAlignment.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TabAlignment has ${TabAlignment.values.length} values');

  // First and last
  final first = TabAlignment.values.first;
  final last = TabAlignment.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('start: ${TabAlignment.start.name} (index ${TabAlignment.start.index})');
  print('startOffset: ${TabAlignment.startOffset.name} (index ${TabAlignment.startOffset.index})');
  print('fill: ${TabAlignment.fill.name} (index ${TabAlignment.fill.index})');
  print('center: ${TabAlignment.center.name} (index ${TabAlignment.center.index})');

  // Usage description
  print('\nUsage context:');
  print('start: Tabs are aligned to the start of the TabBar');
  print('  Scrollable tabs start from the leading edge');
  print('startOffset: Tabs start with an offset from the leading edge');
  print('  Common in Material 3 design for scrollable tabs');
  print('fill: Tabs expand to fill the available space equally');
  print('  Each tab takes an equal portion of the TabBar width');
  print('center: Tabs are centered within the TabBar');
  print('  Useful for a small number of tabs');

  // Equality
  print('\nEquality tests:');
  print('start == start: ${TabAlignment.start == TabAlignment.start}');
  print('start == fill: ${TabAlignment.start == TabAlignment.fill}');
  print('identical: ${identical(TabAlignment.start, TabAlignment.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TabAlignment: ${first is TabAlignment}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TabAlignment.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with TabBar
  print('\nTabBar integration:');
  for (final alignment in TabAlignment.values) {
    print('  TabAlignment.${alignment.name} can be passed to TabBar.tabAlignment');
  }

  // Comparison to isScrollable
  print('\nScrollable context:');
  print('  start: requires isScrollable=true');
  print('  startOffset: requires isScrollable=true');
  print('  fill: requires isScrollable=false');
  print('  center: requires isScrollable=false');

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < TabAlignment.values.length; i++) {
    final v = TabAlignment.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('TabAlignment test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TabAlignment Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TabAlignment.values.length}'),
      for (final v in TabAlignment.values)
        Text('  ${v.name} (${v.index})'),
      Text('TabBar: all alignments supported'),
    ],
  );
}
