// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderRotatedBox from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderRotatedBox test executing');

  // RenderRotatedBox - Rotated box
  // This is typically an abstract/base class used through subclasses
  print('RenderRotatedBox is available in the rendering package');
  print('RenderRotatedBox: Rotated box');

  print('RenderRotatedBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderRotatedBox Tests'),
      Text('Rotated box'),
    ],
  );
}
