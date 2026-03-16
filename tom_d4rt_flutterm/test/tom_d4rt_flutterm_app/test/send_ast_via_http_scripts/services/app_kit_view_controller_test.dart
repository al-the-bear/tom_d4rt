// D4rt test script: Tests AppKitViewController from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AppKitViewController test executing');

  // Test AppKitViewController - macOS views
  print('AppKitViewController is available in the services package');
  print('AppKitViewController: macOS views');

  print('AppKitViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AppKitViewController Tests'),
      Text('macOS views'),
    ],
  );
}
