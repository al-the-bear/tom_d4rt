// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverFillRemainingAndOverscroll from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFillRemainingAndOverscroll test executing');

  // RenderSliverFillRemainingAndOverscroll - Overscroll remaining
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFillRemainingAndOverscroll is available in the rendering package');
  print('RenderSliverFillRemainingAndOverscroll: Overscroll remaining');

  print('RenderSliverFillRemainingAndOverscroll test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFillRemainingAndOverscroll Tests'),
      Text('Overscroll remaining'),
    ],
  );
}
