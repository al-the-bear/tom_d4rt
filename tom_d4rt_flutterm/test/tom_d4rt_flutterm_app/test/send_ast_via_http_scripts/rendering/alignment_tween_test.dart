// D4rt test script: Tests AlignmentTween from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlignmentTween test executing');

  // AlignmentTween - Animates between two AlignmentGeometry values
  // Used for smooth alignment transitions in animations
  
  // Create an AlignmentTween
  final tween = AlignmentTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  print('AlignmentTween created: $tween');
  print('begin: ${tween.begin}');
  print('end: ${tween.end}');
  
  // Test lerp at various points
  print('\nLerp values:');
  print('lerp(0.0): ${tween.lerp(0.0)}');
  print('lerp(0.25): ${tween.lerp(0.25)}');
  print('lerp(0.5): ${tween.lerp(0.5)}');
  print('lerp(0.75): ${tween.lerp(0.75)}');
  print('lerp(1.0): ${tween.lerp(1.0)}');
  
  // Test with directional alignment (RTL-aware)
  final directionalTween = AlignmentTween(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
  );
  print('\nDirectional AlignmentTween:');
  print('begin: ${directionalTween.begin}');
  print('end: ${directionalTween.end}');
  print('lerp(0.5): ${directionalTween.lerp(0.5)}');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('AlignmentTween extends Tween<AlignmentGeometry>');
  print('Tween<T> extends Animatable<T>');
  print('Supports both Alignment and AlignmentDirectional');
  
  // Use cases
  print('\nUse cases:');
  print('- Animated alignment changes');
  print('- AnimatedAlign widget');
  print('- Custom animated containers');
  print('- RTL-aware alignment animations');

  print('\nAlignmentTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AlignmentTween Tests'),
      Text('begin: topLeft, end: bottomRight'),
      Text('lerp(0.5): center'),
      Text('Supports directional alignment'),
    ],
  );
}
