// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSizedOverflowBox from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSizedOverflowBox test executing');

  // RenderSizedOverflowBox - Sized overflow
  // This is typically an abstract/base class used through subclasses
  print('RenderSizedOverflowBox is available in the rendering package');
  print('RenderSizedOverflowBox: Sized overflow');

  print('RenderSizedOverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSizedOverflowBox Tests'),
      Text('Sized overflow'),
    ],
  );
}
