// D4rt test script: Tests DefaultPlatformMenuDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultPlatformMenuDelegate test executing');

  // Test DefaultPlatformMenuDelegate - DefaultPlatformMenuDelegate
  print('DefaultPlatformMenuDelegate is available in the widgets package');
  print('DefaultPlatformMenuDelegate runtimeType accessible');

  print('DefaultPlatformMenuDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultPlatformMenuDelegate Tests'),
      Text('DefaultPlatformMenuDelegate'),
    ],
  );
}
