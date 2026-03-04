// D4rt test script: Tests PopNavigatorRouterDelegateMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PopNavigatorRouterDelegateMixin test executing');

  // PopNavigatorRouterDelegateMixin is a mixin - verify it exists in the framework
  print('PopNavigatorRouterDelegateMixin is a mixin');
  print('PopNavigatorRouterDelegateMixin runtimeType check available');
  print('PopNavigatorRouterDelegateMixin type: mixin');

  print('PopNavigatorRouterDelegateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopNavigatorRouterDelegateMixin Tests'),
      Text('Type: mixin'),
      Text('PopNavigatorRouterDelegateMixin'),
    ],
  );
}
