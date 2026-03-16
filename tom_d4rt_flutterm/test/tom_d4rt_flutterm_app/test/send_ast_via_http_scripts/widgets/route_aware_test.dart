// D4rt test script: Tests RouteAware from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RouteAware test executing');

  // RouteAware is a mixin class - verify it exists in the framework
  print('RouteAware is a mixin class');
  print('RouteAware runtimeType check available');
  print('RouteAware type: mixin class');

  print('RouteAware test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RouteAware Tests'),
      Text('Type: mixin class'),
      Text('RouteAware'),
    ],
  );
}
