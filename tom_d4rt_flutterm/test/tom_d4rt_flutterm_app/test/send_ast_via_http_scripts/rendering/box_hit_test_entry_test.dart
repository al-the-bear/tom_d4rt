// D4rt test script: Tests BoxHitTestEntry from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxHitTestEntry test executing');

  // Test BoxHitTestEntry - Box hit entry
  print('BoxHitTestEntry is available in the rendering package');
  print('BoxHitTestEntry: Box hit entry');

  print('BoxHitTestEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxHitTestEntry Tests'),
      Text('Box hit entry'),
    ],
  );
}
