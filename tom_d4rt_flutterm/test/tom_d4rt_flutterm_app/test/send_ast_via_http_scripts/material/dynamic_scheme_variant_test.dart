// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DynamicSchemeVariant from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DynamicSchemeVariant test executing');
  print('=' * 50);

  // DynamicSchemeVariant enum for Material 3 color schemes
  print('DynamicSchemeVariant overview:');
  print('  - Enum for Material 3 dynamic color scheme variants');
  print('  - Used with ColorScheme.fromSeed');
  print('  - Controls palette generation algorithm');

  // All enum values
  print('\nAll DynamicSchemeVariant values:');
  for (final value in DynamicSchemeVariant.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${DynamicSchemeVariant.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  print('  tonalSpot: ${DynamicSchemeVariant.tonalSpot}');
  print('    - Default Material 3 scheme');
  print('    - Balanced tonal palette');

  print('  fidelity: ${DynamicSchemeVariant.fidelity}');
  print('    - High color fidelity');
  print('    - Closer to seed color');

  print('  monochrome: ${DynamicSchemeVariant.monochrome}');
  print('    - Grayscale palette');
  print('    - No chroma (color)');

  print('  neutral: ${DynamicSchemeVariant.neutral}');
  print('    - Neutral palette');
  print('    - Low chroma');

  print('  vibrant: ${DynamicSchemeVariant.vibrant}');
  print('    - Vibrant palette');
  print('    - High chroma colors');

  print('  expressive: ${DynamicSchemeVariant.expressive}');
  print('    - Expressive palette');
  print('    - Creative color combinations');

  print('  content: ${DynamicSchemeVariant.content}');
  print('    - Content-focused palette');
  print('    - For image-based theming');

  print('  rainbow: ${DynamicSchemeVariant.rainbow}');
  print('    - Rainbow palette');
  print('    - Multi-hue distribution');

  print('  fruitSalad: ${DynamicSchemeVariant.fruitSalad}');
  print('    - Fruit salad palette');
  print('    - Playful color mix');

  // Usage in ColorScheme.fromSeed
  print('\nUsage in ColorScheme.fromSeed:');
  print('  ColorScheme.fromSeed(');
  print('    seedColor: Colors.blue,');
  print('    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,');
  print('  )');

  // Default value
  print('\nDefault: DynamicSchemeVariant.tonalSpot');

  print('\n' + '=' * 50);
  print('DynamicSchemeVariant test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DynamicSchemeVariant Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: 9 variants'),
      Text('Use: Material 3 color schemes'),
    ],
  );
}
