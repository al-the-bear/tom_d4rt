// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StretchMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StretchMode test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nStretchMode values:');
  for (final value in StretchMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('StretchMode has ${StretchMode.values.length} values');

  // First and last
  final first = StretchMode.values.first;
  final last = StretchMode.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('zoomBackground: ${StretchMode.zoomBackground.name} (index ${StretchMode.zoomBackground.index})');
  print('blurBackground: ${StretchMode.blurBackground.name} (index ${StretchMode.blurBackground.index})');
  print('fadeTitle: ${StretchMode.fadeTitle.name} (index ${StretchMode.fadeTitle.index})');

  // Usage description
  print('\nUsage context:');
  print('zoomBackground: Zoom the background widget during overscroll');
  print('  Creates a parallax-like effect on the background image');
  print('blurBackground: Blur the background widget during overscroll');
  print('  Applies increasing blur as user overscrolls');
  print('fadeTitle: Fade the title text during overscroll');
  print('  Title becomes transparent as the header stretches');

  // Equality
  print('\nEquality tests:');
  print('zoomBackground == zoomBackground: ${StretchMode.zoomBackground == StretchMode.zoomBackground}');
  print('zoomBackground == fadeTitle: ${StretchMode.zoomBackground == StretchMode.fadeTitle}');
  print('identical: ${identical(StretchMode.zoomBackground, StretchMode.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is StretchMode: ${first is StretchMode}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in StretchMode.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage in FlexibleSpaceBar
  print('\nFlexibleSpaceBar integration:');
  for (final mode in StretchMode.values) {
    print('  StretchMode.${mode.name} can be passed to FlexibleSpaceBar.stretchModes');
  }

  // List of stretch modes
  print('\nMultiple stretch modes:');
  final allModes = StretchMode.values.toList();
  print('  All modes: $allModes');
  print('  Length: ${allModes.length}');
  final subset = [StretchMode.zoomBackground, StretchMode.fadeTitle];
  print('  Subset: $subset');
  print('  Subset length: ${subset.length}');

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < StretchMode.values.length; i++) {
    final v = StretchMode.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('StretchMode test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StretchMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${StretchMode.values.length}'),
      for (final v in StretchMode.values)
        Text('  ${v.name} (${v.index})'),
      Text('FlexibleSpaceBar: all modes supported'),
    ],
  );
}
