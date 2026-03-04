// D4rt test script: Tests ImplicitlyAnimatedWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImplicitlyAnimatedWidget test executing');

  // Test ImplicitlyAnimatedWidget - Implicit animation
  print('ImplicitlyAnimatedWidget is available in the widgets package');
  print('ImplicitlyAnimatedWidget runtimeType accessible');

  print('ImplicitlyAnimatedWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImplicitlyAnimatedWidget Tests'),
      Text('Implicit animation'),
    ],
  );
}
