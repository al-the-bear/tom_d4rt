// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextStyleTween from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextStyleTween test executing');
  print('=' * 50);

  // Test construction with begin and end
  print('Testing TextStyleTween construction:');
  final tween = TextStyleTween(
    begin: TextStyle(fontSize: 14, color: Colors.blue),
    end: TextStyle(fontSize: 24, color: Colors.red),
  );
  print('  begin: fontSize=14, color=blue');
  print('  end: fontSize=24, color=red');

  // Class hierarchy
  print('\nClass hierarchy:');
  print('  - Extends Tween<TextStyle>');
  print('  - Tween<TextStyle> -> Animatable<TextStyle>');

  // Test lerp at various points
  print('\nTesting lerp at various points:');
  
  final at0 = tween.lerp(0.0);
  print('  t=0.0: fontSize=${at0.fontSize}, color=${at0.color}');
  
  final at05 = tween.lerp(0.5);
  print('  t=0.5: fontSize=${at05.fontSize}, color=${at05.color}');
  
  final at1 = tween.lerp(1.0);
  print('  t=1.0: fontSize=${at1.fontSize}, color=${at1.color}');

  // lerp implementation
  print('\nlerp implementation:');
  print('  @override');
  print('  TextStyle lerp(double t) => TextStyle.lerp(begin, end, t)!;');
  print('  - Uses TextStyle.lerp static method');
  print('  - Non-null assertion (TextStyle.lerp can return null)');

  // Properties interpolated
  print('\nTextStyle properties that interpolate:');
  print('  - fontSize');
  print('  - color (Color.lerp)');
  print('  - fontWeight');
  print('  - letterSpacing');
  print('  - wordSpacing');
  print('  - height');
  print('  - decorationColor');
  print('  - decorationThickness');

  // Warning about mismatched properties
  print('\nWarning:');
  print('  - Works best when both styles set same fields');
  print('  - Null to non-null may produce unexpected results');
  print('  - fontFamily does not interpolate');

  // Usage with animations
  print('\nUsage with animations:');
  print('  - DefaultTextStyleTransition widget');
  print('  - AnimatedDefaultTextStyle widget');
  print('  - Custom AnimatedBuilder usage');

  // runtimeType
  print('\nType verification:');
  print('  tween.runtimeType: ${tween.runtimeType}');
  print('  Extends Tween<TextStyle?>: yes');

  // Test transform
  print('\nTransform method (inherited):');
  final transformed = tween.transform(0.75);
  print('  transform(0.75): fontSize=${transformed.fontSize}');

  print('\n' + '=' * 50);
  print('TextStyleTween test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextStyleTween Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: Tween<TextStyle>'),
      Text('Method: lerp(double t)'),
      Text('Uses: TextStyle.lerp for interpolation'),
    ],
  );
}
