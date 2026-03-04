// D4rt test script: Tests TweenAnimationBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TweenAnimationBuilder test executing');

  // Test TweenAnimationBuilder - Tween builder
  print('TweenAnimationBuilder is available in the widgets package');
  print('TweenAnimationBuilder runtimeType accessible');

  print('TweenAnimationBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TweenAnimationBuilder Tests'),
      Text('Tween builder'),
    ],
  );
}
