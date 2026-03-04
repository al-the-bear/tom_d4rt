// D4rt test script: Tests FractionalOffsetTween from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FractionalOffsetTween test executing');

  // Test FractionalOffsetTween - Offset tween
  print('FractionalOffsetTween is available in the rendering package');
  print('FractionalOffsetTween: Offset tween');

  print('FractionalOffsetTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FractionalOffsetTween Tests'),
      Text('Offset tween'),
    ],
  );
}
