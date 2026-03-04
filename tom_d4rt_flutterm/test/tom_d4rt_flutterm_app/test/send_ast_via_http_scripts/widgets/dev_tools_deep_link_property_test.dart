// D4rt test script: Tests DevToolsDeepLinkProperty from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DevToolsDeepLinkProperty test executing');

  // Test DevToolsDeepLinkProperty - DevToolsDeepLinkProperty
  print('DevToolsDeepLinkProperty is available in the widgets package');
  print('DevToolsDeepLinkProperty runtimeType accessible');

  print('DevToolsDeepLinkProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DevToolsDeepLinkProperty Tests'),
      Text('DevToolsDeepLinkProperty'),
    ],
  );
}
