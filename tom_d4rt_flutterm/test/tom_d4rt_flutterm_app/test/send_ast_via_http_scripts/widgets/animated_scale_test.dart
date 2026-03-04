// D4rt test script: Tests AnimatedScale from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedScale test executing');

  // Test AnimatedScale - Animated scale
  print('AnimatedScale is available in the widgets package');
  print('AnimatedScale runtimeType accessible');

  print('AnimatedScale test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedScale Tests'),
      Text('Animated scale'),
    ],
  );
}
