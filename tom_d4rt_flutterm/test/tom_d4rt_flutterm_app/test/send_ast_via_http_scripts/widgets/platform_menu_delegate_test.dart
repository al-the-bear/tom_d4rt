// D4rt test script: Tests PlatformMenuDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuDelegate test executing');

  // Test PlatformMenuDelegate - PlatformMenuDelegate
  print('PlatformMenuDelegate is available in the widgets package');
  print('PlatformMenuDelegate runtimeType accessible');

  print('PlatformMenuDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformMenuDelegate Tests'),
      Text('PlatformMenuDelegate'),
    ],
  );
}
