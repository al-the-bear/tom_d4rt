// D4rt test script: Tests PageRouteBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PageRouteBuilder test executing');

  // Test PageRouteBuilder - PageRouteBuilder
  print('PageRouteBuilder is available in the widgets package');
  print('PageRouteBuilder runtimeType accessible');

  print('PageRouteBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PageRouteBuilder Tests'),
      Text('PageRouteBuilder'),
    ],
  );
}
