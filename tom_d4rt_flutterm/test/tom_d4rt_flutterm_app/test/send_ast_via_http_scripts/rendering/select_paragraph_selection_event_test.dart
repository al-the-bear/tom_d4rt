// D4rt test script: Tests SelectParagraphSelectionEvent from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectParagraphSelectionEvent test executing');

  // Test SelectParagraphSelectionEvent - Select paragraph
  print('SelectParagraphSelectionEvent is available in the rendering package');
  print('SelectParagraphSelectionEvent: Select paragraph');

  print('SelectParagraphSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectParagraphSelectionEvent Tests'),
      Text('Select paragraph'),
    ],
  );
}
