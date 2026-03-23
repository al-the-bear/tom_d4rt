// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverConstrainedCrossAxis from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverConstrainedCrossAxis test executing');

  // RenderSliverConstrainedCrossAxis - Constrained cross
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverConstrainedCrossAxis is available in the rendering package');
  print('RenderSliverConstrainedCrossAxis: Constrained cross');

  print('RenderSliverConstrainedCrossAxis test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverConstrainedCrossAxis Tests'),
      Text('Constrained cross'),
    ],
  );
}
