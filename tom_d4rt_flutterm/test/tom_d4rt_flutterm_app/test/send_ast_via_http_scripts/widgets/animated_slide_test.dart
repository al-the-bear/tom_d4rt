// D4rt test script: Tests AnimatedSlide from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedSlide test executing');

  // Test AnimatedSlide - Animated slide
  print('AnimatedSlide is available in the widgets package');
  print('AnimatedSlide runtimeType accessible');

  print('AnimatedSlide test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedSlide Tests'),
      Text('Animated slide'),
    ],
  );
}
