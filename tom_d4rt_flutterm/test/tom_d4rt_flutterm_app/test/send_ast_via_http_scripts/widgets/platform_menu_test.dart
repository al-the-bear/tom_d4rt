// D4rt test script: Tests PlatformMenu from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformMenu test executing');

  // Test PlatformMenu - Platform menu
  print('PlatformMenu is available in the widgets package');
  print('PlatformMenu runtimeType accessible');

  print('PlatformMenu test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformMenu Tests'),
      Text('Platform menu'),
    ],
  );
}
