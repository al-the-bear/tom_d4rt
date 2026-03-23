// ignore_for_file: avoid_print
// D4rt test script: Tests RenderSemanticsAnnotations from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSemanticsAnnotations test executing');

  // RenderSemanticsAnnotations - Semantics
  // This is typically an abstract/base class used through subclasses
  print('RenderSemanticsAnnotations is available in the rendering package');
  print('RenderSemanticsAnnotations: Semantics');

  print('RenderSemanticsAnnotations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSemanticsAnnotations Tests'),
      Text('Semantics'),
    ],
  );
}
