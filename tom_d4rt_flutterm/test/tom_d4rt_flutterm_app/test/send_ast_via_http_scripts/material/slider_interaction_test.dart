// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliderInteraction from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliderInteraction test executing');
  print('=' * 50);

  // SliderInteraction enum
  print('SliderInteraction overview:');
  print('  - Enum for Slider interaction modes');
  print('  - Used with SliderThemeData');
  print('  - Controls how slider responds to input');

  // All enum values
  print('\nAll SliderInteraction values:');
  for (final value in SliderInteraction.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${SliderInteraction.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const tapAndSlide = SliderInteraction.tapAndSlide;
  const tapOnly = SliderInteraction.tapOnly;
  const slideOnly = SliderInteraction.slideOnly;
  const slideThumb = SliderInteraction.slideThumb;

  print('  tapAndSlide: $tapAndSlide');
  print('    - Tap anywhere to jump');
  print('    - Slide to adjust');
  print('    - Default behavior');

  print('  tapOnly: $tapOnly');
  print('    - Only tap to set value');
  print('    - No sliding interaction');
  print('    - Discrete selection');

  print('  slideOnly: $slideOnly');
  print('    - Only slide to adjust');
  print('    - No tap to jump');
  print('    - Precise adjustment');

  print('  slideThumb: $slideThumb');
  print('    - Must start on thumb');
  print('    - Slide from thumb only');
  print('    - Most controlled');

  // Usage in SliderTheme
  print('\nUsage in SliderTheme:');
  print('  SliderTheme(');
  print('    data: SliderThemeData(');
  print('      allowedInteraction: SliderInteraction.tapAndSlide,');
  print('    ),');
  print('    child: Slider(');
  print('      value: _value,');
  print('      onChanged: (v) => setState(() => _value = v),');
  print('    ),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = SliderInteraction.values.first;
  final last = SliderInteraction.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Default value
  print('\nDefault: SliderInteraction.tapAndSlide');

  print('\n' + '=' * 50);
  print('SliderInteraction test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SliderInteraction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: tapAndSlide, tapOnly, slideOnly, slideThumb'),
      Text('Use: Slider input modes'),
    ],
  ));
}
