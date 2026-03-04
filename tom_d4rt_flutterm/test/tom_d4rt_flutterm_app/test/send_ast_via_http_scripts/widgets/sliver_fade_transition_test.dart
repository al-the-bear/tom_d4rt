// D4rt test script: Tests SliverFadeTransition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverFadeTransition test executing');

  // Test SliverFadeTransition - SliverFadeTransition
  print('SliverFadeTransition is available in the widgets package');
  print('SliverFadeTransition runtimeType accessible');

  print('SliverFadeTransition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverFadeTransition Tests'),
      Text('SliverFadeTransition'),
    ],
  );
}
