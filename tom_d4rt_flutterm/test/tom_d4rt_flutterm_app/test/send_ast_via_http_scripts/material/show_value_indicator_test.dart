// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShowValueIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShowValueIndicator test executing');
  print('=' * 50);

  // ShowValueIndicator enum for sliders
  print('ShowValueIndicator overview:');
  print('  - Enum for Slider value indicator display');
  print('  - Used with SliderThemeData');
  print('  - Controls bubble indicator visibility');

  // All enum values
  print('\nAll ShowValueIndicator values:');
  for (final value in ShowValueIndicator.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${ShowValueIndicator.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const onlyForDiscrete = ShowValueIndicator.onlyForDiscrete;
  const onlyForContinuous = ShowValueIndicator.onlyForContinuous;
  const always = ShowValueIndicator.always;
  const never = ShowValueIndicator.never;

  print('  onlyForDiscrete: $onlyForDiscrete');
  print('    - Show only for discrete sliders');
  print('    - When divisions is set');
  print('    - Default behavior');

  print('  onlyForContinuous: $onlyForContinuous');
  print('    - Show only for continuous sliders');
  print('    - When no divisions');

  print('  always: $always');
  print('    - Always show indicator');
  print('    - Both discrete and continuous');
  print('    - Deprecated: use alwaysVisible');

  print('  never: $never');
  print('    - Never show indicator');
  print('    - No bubble display');

  // Additional values
  print('\nAdditional values (Material 3):');
  print('  onDrag: Show while dragging');
  print('  alwaysVisible: Replaces deprecated always');

  // Usage in SliderTheme
  print('\nUsage in SliderTheme:');
  print('  SliderTheme(');
  print('    data: SliderThemeData(');
  print('      showValueIndicator: ShowValueIndicator.onDrag,');
  print('    ),');
  print('    child: Slider(...),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = ShowValueIndicator.values.first;
  final last = ShowValueIndicator.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Default value
  print('\nDefault: ShowValueIndicator.onlyForDiscrete');

  print('\n' + '=' * 50);
  print('ShowValueIndicator test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ShowValueIndicator Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: onlyForDiscrete, onlyForContinuous, always, never'),
      Text('Use: Slider value bubble'),
    ],
  );
}
