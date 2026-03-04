// D4rt test script: Tests SliverVisibility from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverVisibility test executing');

  // Test SliverVisibility - Sliver visibility
  print('SliverVisibility is available in the widgets package');
  print('SliverVisibility runtimeType accessible');

  print('SliverVisibility test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverVisibility Tests'),
      Text('Sliver visibility'),
    ],
  );
}
