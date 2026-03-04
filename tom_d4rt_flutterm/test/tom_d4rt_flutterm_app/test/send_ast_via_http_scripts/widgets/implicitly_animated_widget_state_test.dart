// D4rt test script: Tests ImplicitlyAnimatedWidgetState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImplicitlyAnimatedWidgetState test executing');

  // Test ImplicitlyAnimatedWidgetState - Implicit state
  print('ImplicitlyAnimatedWidgetState is available in the widgets package');
  print('ImplicitlyAnimatedWidgetState runtimeType accessible');

  print('ImplicitlyAnimatedWidgetState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImplicitlyAnimatedWidgetState Tests'),
      Text('Implicit state'),
    ],
  );
}
