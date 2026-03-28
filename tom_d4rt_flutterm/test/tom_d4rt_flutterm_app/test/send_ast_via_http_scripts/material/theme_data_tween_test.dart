// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ThemeDataTween from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeDataTween test executing');
  print('=' * 50);

  // ThemeDataTween overview
  print('ThemeDataTween overview:');
  print('  - Tween<ThemeData> subclass');
  print('  - Animates between themes');
  print('  - Uses ThemeData.lerp');

  // Test basic tween
  print('\nTest basic tween:');
  final tween1 = ThemeDataTween(
    begin: ThemeData.light(),
    end: ThemeData.dark(),
  );
  print('  Begin: ${tween1.begin?.brightness}');
  print('  End: ${tween1.end?.brightness}');

  // Test lerp at various points
  print('\nTest lerp values:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final lerped = tween1.lerp(t);
    print('  t=$t: brightness=${lerped.brightness}');
  }

  // Test null begin
  print('\nTest null begin:');
  final tween2 = ThemeDataTween(
    begin: null,
    end: ThemeData.dark(),
  );
  print('  Begin: ${tween2.begin}');
  print('  End: ${tween2.end}');

  // Test null end
  print('\nTest null end:');
  final tween3 = ThemeDataTween(
    begin: ThemeData.light(),
    end: null,
  );
  print('  Begin: ${tween3.begin}');
  print('  End: ${tween3.end}');

  // Properties that animate
  print('\nProperties that animate:');
  print('  - Colors (primary, accent, etc.)');
  print('  - Typography');
  print('  - Shape themes');
  print('  - Elevation values');

  // Usage pattern
  print('\nUsage pattern:');
  print('  TweenAnimationBuilder<ThemeData>(');
  print('    tween: ThemeDataTween(begin: light, end: dark),');
  print('    builder: (context, theme, child) {');
  print('      return Theme(data: theme, child: child!);');
  print('    },');
  print('    child: content,');
  print('  )');

  // AnimatedTheme
  print('\nAnimatedTheme widget:');
  print('  - ImplicitlyAnimatedWidget');
  print('  - Uses ThemeData.lerp internally');
  print('  - Simpler API for most cases');

  print('\n' + '=' * 50);
  print('ThemeDataTween test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ThemeDataTween Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Tween<ThemeData>'),
      Text('Purpose: Theme animation'),
    ],
  );
}
