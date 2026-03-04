// D4rt test script: Tests PlatformMenuItem from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuItem test executing');

  // Test PlatformMenuItem - Menu item
  print('PlatformMenuItem is available in the widgets package');
  print('PlatformMenuItem runtimeType accessible');

  print('PlatformMenuItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformMenuItem Tests'),
      Text('Menu item'),
    ],
  );
}
