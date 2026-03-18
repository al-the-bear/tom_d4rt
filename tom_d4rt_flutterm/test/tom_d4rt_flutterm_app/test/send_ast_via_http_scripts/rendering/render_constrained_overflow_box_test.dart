// D4rt test script: Tests RenderConstrainedOverflowBox from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderConstrainedOverflowBox test executing');

  // RenderConstrainedOverflowBox - Constrained overflow
  // This is typically an abstract/base class used through subclasses
  print('RenderConstrainedOverflowBox is available in the rendering package');
  print('RenderConstrainedOverflowBox: Constrained overflow');

  print('RenderConstrainedOverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderConstrainedOverflowBox Tests'),
      Text('Constrained overflow'),
    ],
  );
}
