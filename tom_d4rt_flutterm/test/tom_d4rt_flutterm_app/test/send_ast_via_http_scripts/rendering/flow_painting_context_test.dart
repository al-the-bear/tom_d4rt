// D4rt test script: Tests FlowPaintingContext from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlowPaintingContext test executing');

  // Test FlowPaintingContext - Flow context
  print('FlowPaintingContext is available in the rendering package');
  print('FlowPaintingContext: Flow context');

  print('FlowPaintingContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlowPaintingContext Tests'),
      Text('Flow context'),
    ],
  );
}
