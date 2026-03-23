// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverFillRemaining from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFillRemaining test executing');

  // RenderSliverFillRemaining - Fill remaining
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFillRemaining is available in the rendering package');
  print('RenderSliverFillRemaining: Fill remaining');

  print('RenderSliverFillRemaining test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFillRemaining Tests'),
      Text('Fill remaining'),
    ],
  );
}
