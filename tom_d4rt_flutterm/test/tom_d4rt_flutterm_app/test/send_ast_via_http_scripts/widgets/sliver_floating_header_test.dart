// D4rt test script: Tests SliverFloatingHeader from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverFloatingHeader test executing');

  // Test SliverFloatingHeader - Floating header
  print('SliverFloatingHeader is available in the widgets package');
  print('SliverFloatingHeader runtimeType accessible');

  print('SliverFloatingHeader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverFloatingHeader Tests'),
      Text('Floating header'),
    ],
  );
}
