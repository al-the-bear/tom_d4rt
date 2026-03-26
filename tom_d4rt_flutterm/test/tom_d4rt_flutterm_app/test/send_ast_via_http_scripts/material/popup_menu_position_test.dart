// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PopupMenuPosition from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuPosition test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nPopupMenuPosition values:');
  for (final value in PopupMenuPosition.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('PopupMenuPosition has ${PopupMenuPosition.values.length} values');

  // First and last
  final first = PopupMenuPosition.values.first;
  final last = PopupMenuPosition.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('over: ${PopupMenuPosition.over.name} (index ${PopupMenuPosition.over.index})');
  print('under: ${PopupMenuPosition.under.name} (index ${PopupMenuPosition.under.index})');

  // Usage description
  print('\nUsage context:');
  print('over: Popup menu is positioned over the anchor widget');
  print('  Menu overlaps the button that triggered it');
  print('under: Popup menu is positioned below the anchor widget');
  print('  Menu appears beneath the triggering button');

  // Equality
  print('\nEquality tests:');
  print('over == over: ${PopupMenuPosition.over == PopupMenuPosition.over}');
  print('over == under: ${PopupMenuPosition.over == PopupMenuPosition.under}');
  print('identical: ${identical(PopupMenuPosition.over, PopupMenuPosition.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is PopupMenuPosition: ${first is PopupMenuPosition}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in PopupMenuPosition.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with PopupMenuButton
  print('\nPopupMenuButton integration:');
  final button1 = PopupMenuButton<String>(
    position: PopupMenuPosition.over,
    itemBuilder: (context) => [
      PopupMenuItem(value: 'a', child: Text('Option A')),
      PopupMenuItem(value: 'b', child: Text('Option B')),
    ],
  );
  print('PopupMenuButton with over: ${button1.position}');

  final button2 = PopupMenuButton<String>(
    position: PopupMenuPosition.under,
    itemBuilder: (context) => [
      PopupMenuItem(value: 'a', child: Text('Option A')),
    ],
  );
  print('PopupMenuButton with under: ${button2.position}');

  // PopupMenuThemeData
  print('\nPopupMenuThemeData integration:');
  final theme = PopupMenuThemeData(position: PopupMenuPosition.under);
  print('Theme position: ${theme.position}');

  print('\n' + '=' * 50);
  print('PopupMenuPosition test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PopupMenuPosition Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${PopupMenuPosition.values.length}'),
      for (final v in PopupMenuPosition.values)
        Text('  ${v.name} (${v.index})'),
      Text('PopupMenuButton: over & under'),
      Text('PopupMenuTheme: ${theme.position}'),
    ],
  );
}
