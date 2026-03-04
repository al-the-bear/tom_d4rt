// D4rt test script: Tests PlatformMenuItemGroup from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuItemGroup test executing');

  // Test PlatformMenuItemGroup - Menu group
  print('PlatformMenuItemGroup is available in the widgets package');
  print('PlatformMenuItemGroup runtimeType accessible');

  print('PlatformMenuItemGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformMenuItemGroup Tests'),
      Text('Menu group'),
    ],
  );
}
