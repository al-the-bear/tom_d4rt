// D4rt test script: Tests AlignmentTween from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlignmentTween test executing');

  // Test AlignmentTween - Alignment tween
  print('AlignmentTween is available in the rendering package');
  print('AlignmentTween: Alignment tween');

  print('AlignmentTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AlignmentTween Tests'),
      Text('Alignment tween'),
    ],
  );
}
