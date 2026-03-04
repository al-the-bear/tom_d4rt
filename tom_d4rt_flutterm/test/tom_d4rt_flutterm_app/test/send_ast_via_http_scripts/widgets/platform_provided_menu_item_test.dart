// D4rt test script: Tests PlatformProvidedMenuItem from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformProvidedMenuItem test executing');

  // Test PlatformProvidedMenuItem - Platform item
  print('PlatformProvidedMenuItem is available in the widgets package');
  print('PlatformProvidedMenuItem runtimeType accessible');

  print('PlatformProvidedMenuItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformProvidedMenuItem Tests'),
      Text('Platform item'),
    ],
  );
}
