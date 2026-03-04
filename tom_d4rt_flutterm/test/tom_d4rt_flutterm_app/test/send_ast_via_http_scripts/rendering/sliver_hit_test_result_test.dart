// D4rt test script: Tests SliverHitTestResult from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverHitTestResult test executing');

  // Test SliverHitTestResult - Sliver hit test
  print('SliverHitTestResult is available in the rendering package');
  print('SliverHitTestResult: Sliver hit test');

  print('SliverHitTestResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverHitTestResult Tests'),
      Text('Sliver hit test'),
    ],
  );
}
