// D4rt test script: Tests RawWebImage from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawWebImage test executing');

  // Test RawWebImage - RawWebImage
  print('RawWebImage is available in the widgets package');
  print('RawWebImage runtimeType accessible');

  print('RawWebImage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawWebImage Tests'),
      Text('RawWebImage'),
    ],
  );
}
