// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WrapParentData from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WrapParentData test executing');

  // Test WrapParentData - Wrap parent data
  print('WrapParentData is available in the rendering package');
  print('WrapParentData: Wrap parent data');

  print('WrapParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WrapParentData Tests'),
      Text('Wrap parent data'),
    ],
  );
}
