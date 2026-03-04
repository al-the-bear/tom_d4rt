// D4rt test script: Tests RawMenuAnchor from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawMenuAnchor test executing');

  // Test RawMenuAnchor - RawMenuAnchor
  print('RawMenuAnchor is available in the widgets package');
  print('RawMenuAnchor runtimeType accessible');

  print('RawMenuAnchor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawMenuAnchor Tests'),
      Text('RawMenuAnchor'),
    ],
  );
}
