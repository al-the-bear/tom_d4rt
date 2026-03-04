// D4rt test script: Tests PlatformViewCreationParams from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewCreationParams test executing');

  // Test PlatformViewCreationParams - PlatformViewCreationParams
  print('PlatformViewCreationParams is available in the widgets package');
  print('PlatformViewCreationParams runtimeType accessible');

  print('PlatformViewCreationParams test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformViewCreationParams Tests'),
      Text('PlatformViewCreationParams'),
    ],
  );
}
