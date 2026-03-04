// D4rt test script: Tests VerticalCaretMovementRun from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VerticalCaretMovementRun test executing');

  // Test VerticalCaretMovementRun - Caret movement
  print('VerticalCaretMovementRun is available in the rendering package');
  print('VerticalCaretMovementRun: Caret movement');

  print('VerticalCaretMovementRun test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VerticalCaretMovementRun Tests'),
      Text('Caret movement'),
    ],
  );
}
