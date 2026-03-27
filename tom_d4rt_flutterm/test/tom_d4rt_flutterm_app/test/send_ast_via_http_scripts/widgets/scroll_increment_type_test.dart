// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollIncrementType from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollIncrementType test executing');
  print('=' * 50);

  // ScrollIncrementType indicates line vs page scrolling
  print('\nScrollIncrementType Analysis:');
  print('  Type: enum');
  print('  Purpose: Type of scroll increment (line or page)');
  print('  Used by: ScrollIntent, ScrollIncrementDetails');

  // Enumerate all values
  print('\nScrollIncrementType values:');
  for (final value in ScrollIncrementType.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ScrollIncrementType has ${ScrollIncrementType.values.length} values');

  // Test each value in detail
  print('\nDetailed Value Analysis:');

  // line
  final line = ScrollIncrementType.line;
  print('\n1. ScrollIncrementType.line:');
  print('   Name: ${line.name}');
  print('   Index: ${line.index}');
  print('   Description: Scroll by one line');
  print('   Triggered by: Arrow keys, Control+Arrow');
  print('   Default amount: 50.0 logical pixels');

  // page
  final page = ScrollIncrementType.page;
  print('\n2. ScrollIncrementType.page:');
  print('   Name: ${page.name}');
  print('   Index: ${page.index}');
  print('   Description: Scroll by one page');
  print('   Triggered by: PageUp/PageDown keys');
  print('   Default amount: 80% of viewport');

  // First and last
  print('\nBoundary Values:');
  final first = ScrollIncrementType.values.first;
  final last = ScrollIncrementType.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Equality
  print('\nEquality Tests:');
  print('  line == line: ${line == ScrollIncrementType.line}');
  print('  line == page: ${line == page}');
  print('  page == page: ${page == ScrollIncrementType.page}');

  // Usage in ScrollIntent
  print('\nUsage in ScrollIntent:');
  print('  ScrollIntent(');
  print('    direction: AxisDirection.down,');
  print('    type: ScrollIncrementType.line, // or .page');
  print('  )');

  // Keyboard bindings
  print('\nTypical Keyboard Bindings:');
  print('  Arrow keys: line scroll');
  print('  Page Up/Down: page scroll');
  print('  Home/End: scroll to start/end');

  print('\n' + '=' * 50);
  print('ScrollIncrementType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollIncrementType Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Value count: ${ScrollIncrementType.values.length}'),
      Text('line: 50.0 pixels default'),
      Text('page: 80% viewport default'),
    ],
  );
}
