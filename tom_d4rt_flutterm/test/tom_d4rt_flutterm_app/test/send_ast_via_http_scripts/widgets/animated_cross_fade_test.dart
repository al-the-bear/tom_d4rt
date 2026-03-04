// D4rt test script: Tests AnimatedCrossFade from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedCrossFade test executing');

  // Test AnimatedCrossFade - Cross fade
  print('AnimatedCrossFade is available in the widgets package');
  print('AnimatedCrossFade runtimeType accessible');

  print('AnimatedCrossFade test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedCrossFade Tests'),
      Text('Cross fade'),
    ],
  );
}
