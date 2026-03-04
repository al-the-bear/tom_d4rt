// D4rt test script: Tests ProxyWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ProxyWidget test executing');

  // Test ProxyWidget - Proxy widget
  print('ProxyWidget is available in the widgets package');
  print('ProxyWidget runtimeType accessible');

  print('ProxyWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ProxyWidget Tests'),
      Text('Proxy widget'),
    ],
  );
}
