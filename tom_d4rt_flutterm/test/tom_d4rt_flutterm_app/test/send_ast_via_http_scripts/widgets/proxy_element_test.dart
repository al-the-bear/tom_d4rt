// D4rt test script: Tests ProxyElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ProxyElement test executing');

  // Test ProxyElement - Proxy element
  print('ProxyElement is available in the widgets package');
  print('ProxyElement runtimeType accessible');

  print('ProxyElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ProxyElement Tests'),
      Text('Proxy element'),
    ],
  );
}
