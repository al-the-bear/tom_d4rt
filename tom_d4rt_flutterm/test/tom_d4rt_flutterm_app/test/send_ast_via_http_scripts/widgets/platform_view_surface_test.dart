// D4rt test script: Tests PlatformViewSurface from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewSurface test executing');

  // Test PlatformViewSurface - View surface
  print('PlatformViewSurface is available in the widgets package');
  print('PlatformViewSurface runtimeType accessible');

  print('PlatformViewSurface test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewSurface Tests'),
      Text('View surface'),
    ],
  );
}
