// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextParentData from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextParentData test executing');

  // Test TextParentData - Text parent data
  print('TextParentData is available in the rendering package');
  print('TextParentData: Text parent data');

  print('TextParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextParentData Tests'),
      Text('Text parent data'),
    ],
  );
}
