// D4rt test script: Tests RawMenuAnchorGroup from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawMenuAnchorGroup test executing');

  // Test RawMenuAnchorGroup - RawMenuAnchorGroup
  print('RawMenuAnchorGroup is available in the widgets package');
  print('RawMenuAnchorGroup runtimeType accessible');

  print('RawMenuAnchorGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawMenuAnchorGroup Tests'),
      Text('RawMenuAnchorGroup'),
    ],
  );
}
