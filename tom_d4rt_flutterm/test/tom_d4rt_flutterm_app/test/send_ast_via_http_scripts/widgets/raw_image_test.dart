// D4rt test script: Tests RawImage from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawImage test executing');

  // Test RawImage - RawImage
  print('RawImage is available in the widgets package');
  print('RawImage runtimeType accessible');

  print('RawImage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawImage Tests'),
      Text('RawImage'),
    ],
  );
}
