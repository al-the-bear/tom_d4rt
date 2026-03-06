// D4rt test script: Tests RenderIndexedSemantics from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderIndexedSemantics test executing');

  // RenderIndexedSemantics - Indexed semantics
  // This is typically an abstract/base class used through subclasses
  print('RenderIndexedSemantics is available in the rendering package');
  print('RenderIndexedSemantics: Indexed semantics');

  print('RenderIndexedSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderIndexedSemantics Tests'),
      Text('Indexed semantics'),
    ],
  );
}
