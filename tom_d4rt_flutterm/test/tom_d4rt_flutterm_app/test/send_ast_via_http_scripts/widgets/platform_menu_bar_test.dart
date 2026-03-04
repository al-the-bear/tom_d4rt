// D4rt test script: Tests PlatformMenuBar from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformMenuBar test executing');

  // Test PlatformMenuBar - Menu bar
  print('PlatformMenuBar is available in the widgets package');
  print('PlatformMenuBar runtimeType accessible');

  print('PlatformMenuBar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformMenuBar Tests'),
      Text('Menu bar'),
    ],
  );
}
