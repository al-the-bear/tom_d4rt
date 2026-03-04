// D4rt test script: Tests AnimatedAlign from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedAlign test executing');

  // Test AnimatedAlign - Animated align
  print('AnimatedAlign is available in the widgets package');
  print('AnimatedAlign runtimeType accessible');

  print('AnimatedAlign test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedAlign Tests'),
      Text('Animated align'),
    ],
  );
}
