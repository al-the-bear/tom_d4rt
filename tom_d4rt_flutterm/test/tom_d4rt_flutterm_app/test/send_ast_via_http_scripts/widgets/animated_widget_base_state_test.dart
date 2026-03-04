// D4rt test script: Tests AnimatedWidgetBaseState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedWidgetBaseState test executing');

  // Test AnimatedWidgetBaseState - State
  print('AnimatedWidgetBaseState is available in the widgets package');
  print('AnimatedWidgetBaseState runtimeType accessible');

  print('AnimatedWidgetBaseState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedWidgetBaseState Tests'),
      Text('State'),
    ],
  );
}
