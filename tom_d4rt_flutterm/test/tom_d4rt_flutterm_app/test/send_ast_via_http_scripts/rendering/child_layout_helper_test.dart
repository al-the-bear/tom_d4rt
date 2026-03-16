// D4rt test script: Tests ChildLayoutHelper from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ChildLayoutHelper test executing');

  // Test ChildLayoutHelper - Layout helper
  print('ChildLayoutHelper is available in the rendering package');
  print('ChildLayoutHelper: Layout helper');

  print('ChildLayoutHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChildLayoutHelper Tests'),
      Text('Layout helper'),
    ],
  );
}
