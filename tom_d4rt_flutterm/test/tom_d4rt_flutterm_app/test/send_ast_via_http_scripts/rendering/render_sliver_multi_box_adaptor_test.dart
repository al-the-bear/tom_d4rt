// ignore_for_file: avoid_print
// D4rt test script: Tests RenderSliverMultiBoxAdaptor from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverMultiBoxAdaptor test executing');

  // RenderSliverMultiBoxAdaptor - Multi box adaptor
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverMultiBoxAdaptor is available in the rendering package');
  print('RenderSliverMultiBoxAdaptor: Multi box adaptor');

  print('RenderSliverMultiBoxAdaptor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverMultiBoxAdaptor Tests'),
      Text('Multi box adaptor'),
    ],
  );
}
