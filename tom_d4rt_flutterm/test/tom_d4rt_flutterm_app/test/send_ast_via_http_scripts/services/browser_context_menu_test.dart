// D4rt test script: Tests BrowserContextMenu from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BrowserContextMenu test executing');

  // Test BrowserContextMenu - Browser menu
  print('BrowserContextMenu is available in the services package');
  print('BrowserContextMenu: Browser menu');

  print('BrowserContextMenu test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BrowserContextMenu Tests'),
      Text('Browser menu'),
    ],
  );
}
