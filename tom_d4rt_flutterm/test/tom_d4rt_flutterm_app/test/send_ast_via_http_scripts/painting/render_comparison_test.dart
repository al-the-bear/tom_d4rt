// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderComparison from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderComparison test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nRenderComparison values:');
  for (final value in RenderComparison.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('RenderComparison has ${RenderComparison.values.length} values');

  // First and last
  final first = RenderComparison.values.first;
  final last = RenderComparison.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values, ordered by severity
  print('\nValues by severity (least to most expensive):');
  print('identical: ${RenderComparison.identical.name} (index ${RenderComparison.identical.index})');
  print('  Objects are identical — absolutely no work needed');
  print('  Cheapest: no repaint, no relayout, no rebuild');
  print('metadata: ${RenderComparison.metadata.name} (index ${RenderComparison.metadata.index})');
  print('  Only non-visual metadata changed (e.g., semantics)');
  print('  Needs semantics update but no repaint or relayout');
  print('paint: ${RenderComparison.paint.name} (index ${RenderComparison.paint.index})');
  print('  Visual appearance changed but layout is the same');
  print('  Needs repaint but not relayout');
  print('layout: ${RenderComparison.layout.name} (index ${RenderComparison.layout.index})');
  print('  Layout changed, most expensive comparison result');
  print('  Needs full relayout and repaint of the subtree');

  // Comparison ordering
  print('\nSeverity ordering:');
  print('  identical < metadata < paint < layout');
  print('  index comparison: ${RenderComparison.identical.index} < ${RenderComparison.metadata.index} < ${RenderComparison.paint.index} < ${RenderComparison.layout.index}');

  // TextStyle comparison example
  print('\nTextStyle comparison context:');
  print('  Changing color: RenderComparison.paint');
  print('  Changing fontSize: RenderComparison.layout');
  print('  Changing fontFamily: RenderComparison.layout');
  print('  Changing decoration: RenderComparison.paint');
  print('  No change: RenderComparison.identical');

  // Framework usage
  print('\nFramework usage:');
  print('  TextSpan.compareTo returns RenderComparison');
  print('  TextStyle.compareTo returns RenderComparison');
  print('  Used internally to minimize re-rendering work');

  // Equality tests
  print('\nEquality tests:');
  print('identical == identical: ${RenderComparison.identical == RenderComparison.identical}');
  print('identical == layout: ${RenderComparison.identical == RenderComparison.layout}');
  print('identical check: ${identical(RenderComparison.identical, RenderComparison.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is RenderComparison: ${first is RenderComparison}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in RenderComparison.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < RenderComparison.values.length; i++) {
    final v = RenderComparison.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('RenderComparison test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderComparison Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${RenderComparison.values.length}'),
      for (final v in RenderComparison.values)
        Text('  ${v.name} (${v.index})'),
      Text('Rendering: invalidation severity levels'),
    ],
  );
}
