// D4rt test script: Tests const from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('const test executing');

  // Test const - const
  print('const is available in the rendering package');
  print('const: const');

  print('const test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('const Tests'),
      Text('const'),
    ],
  );
}
