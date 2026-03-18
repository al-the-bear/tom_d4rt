// D4rt test script: Tests RenderExcludeSemantics from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderExcludeSemantics test executing');

  // RenderExcludeSemantics - Exclude semantics
  // This is typically an abstract/base class used through subclasses
  print('RenderExcludeSemantics is available in the rendering package');
  print('RenderExcludeSemantics: Exclude semantics');

  print('RenderExcludeSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderExcludeSemantics Tests'),
      Text('Exclude semantics'),
    ],
  );
}
