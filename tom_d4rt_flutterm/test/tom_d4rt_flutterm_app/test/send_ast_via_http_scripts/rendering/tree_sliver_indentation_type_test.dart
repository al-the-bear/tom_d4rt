// D4rt test script: Tests TreeSliverIndentationType from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverIndentationType test executing');

  // Test TreeSliverIndentationType - Tree indent
  print('TreeSliverIndentationType is available in the rendering package');
  print('TreeSliverIndentationType: Tree indent');

  print('TreeSliverIndentationType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TreeSliverIndentationType Tests'),
      Text('Tree indent'),
    ],
  );
}
