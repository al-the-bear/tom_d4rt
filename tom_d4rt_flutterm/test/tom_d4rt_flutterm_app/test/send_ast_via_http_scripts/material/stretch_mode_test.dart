// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StretchMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StretchMode test executing');
  print('=' * 50);

  // StretchMode enum for FlexibleSpaceBar
  print('StretchMode overview:');
  print('  - Enum for FlexibleSpaceBar stretch effects');
  print('  - Used with FlexibleSpaceBar widget');
  print('  - Controls overscroll behavior');

  // All enum values
  print('\nAll StretchMode values:');
  for (final value in StretchMode.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${StretchMode.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const zoomBackground = StretchMode.zoomBackground;
  const blurBackground = StretchMode.blurBackground;
  const fadeTitle = StretchMode.fadeTitle;

  print('  zoomBackground: $zoomBackground');
  print('    - Background zooms on overscroll');
  print('    - Scales up image');
  print('    - Common effect');
  print('    - Default stretch mode');

  print('  blurBackground: $blurBackground');
  print('    - Background blurs on overscroll');
  print('    - Progressive blur effect');
  print('    - iOS-style behavior');

  print('  fadeTitle: $fadeTitle');
  print('    - Title fades on overscroll');
  print('    - Opacity transition');
  print('    - Subtle effect');

  // Usage in FlexibleSpaceBar
  print('\nUsage in FlexibleSpaceBar:');
  print('  FlexibleSpaceBar(');
  print('    stretchModes: [');
  print('      StretchMode.zoomBackground,');
  print('      StretchMode.fadeTitle,');
  print('    ],');
  print('    background: Image.asset(...),');
  print('    title: Text("Title"),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = StretchMode.values.first;
  final last = StretchMode.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Multi-mode usage
  print('\nMulti-mode usage:');
  print('  Can combine multiple modes in list');
  print('  Each mode applies independently');

  // Default value
  print('\nDefault: [StretchMode.zoomBackground]');

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
      Text('Type: enum'),
      Text('Values: zoomBackground, blurBackground, fadeTitle'),
      Text('Use: FlexibleSpaceBar stretch'),
    ],
  );
}
