// D4rt test script: Tests RenderSliverSemanticsAnnotations from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverSemanticsAnnotations test executing');

  // RenderSliverSemanticsAnnotations - Sliver semantics
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverSemanticsAnnotations is available in the rendering package');
  print('RenderSliverSemanticsAnnotations: Sliver semantics');

  print('RenderSliverSemanticsAnnotations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverSemanticsAnnotations Tests'),
      Text('Sliver semantics'),
    ],
  );
}
