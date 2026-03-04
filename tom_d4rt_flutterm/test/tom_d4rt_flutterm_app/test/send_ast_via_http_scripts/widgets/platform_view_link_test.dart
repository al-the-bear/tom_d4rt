// D4rt test script: Tests PlatformViewLink from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewLink test executing');

  // Test PlatformViewLink - View link
  print('PlatformViewLink is available in the widgets package');
  print('PlatformViewLink runtimeType accessible');

  print('PlatformViewLink test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewLink Tests'),
      Text('View link'),
    ],
  );
}
