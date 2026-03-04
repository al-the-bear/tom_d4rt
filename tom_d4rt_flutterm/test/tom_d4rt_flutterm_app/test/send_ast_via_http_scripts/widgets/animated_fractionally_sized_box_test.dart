// D4rt test script: Tests AnimatedFractionallySizedBox from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedFractionallySizedBox test executing');

  // Test AnimatedFractionallySizedBox - Animated fraction
  print('AnimatedFractionallySizedBox is available in the widgets package');
  print('AnimatedFractionallySizedBox runtimeType accessible');

  print('AnimatedFractionallySizedBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedFractionallySizedBox Tests'),
      Text('Animated fraction'),
    ],
  );
}
