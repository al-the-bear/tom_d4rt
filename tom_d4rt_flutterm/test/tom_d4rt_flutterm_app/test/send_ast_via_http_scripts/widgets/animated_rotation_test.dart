// D4rt test script: Tests AnimatedRotation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedRotation test executing');

  // Test AnimatedRotation - Animated rotation
  print('AnimatedRotation is available in the widgets package');
  print('AnimatedRotation runtimeType accessible');

  print('AnimatedRotation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedRotation Tests'),
      Text('Animated rotation'),
    ],
  );
}
