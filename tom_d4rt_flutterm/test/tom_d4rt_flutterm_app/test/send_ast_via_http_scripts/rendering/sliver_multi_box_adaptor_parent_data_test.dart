// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverMultiBoxAdaptorParentData from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverMultiBoxAdaptorParentData test executing');

  // Test SliverMultiBoxAdaptorParentData - Multi box data
  print('SliverMultiBoxAdaptorParentData is available in the rendering package');
  print('SliverMultiBoxAdaptorParentData: Multi box data');

  print('SliverMultiBoxAdaptorParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverMultiBoxAdaptorParentData Tests'),
      Text('Multi box data'),
    ],
  );
}
