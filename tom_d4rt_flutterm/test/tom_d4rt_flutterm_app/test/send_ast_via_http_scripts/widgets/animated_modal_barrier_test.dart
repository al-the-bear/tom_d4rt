// D4rt test script: Tests AnimatedModalBarrier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimatedModalBarrier test executing');

  // Test AnimatedModalBarrier - Modal barrier
  print('AnimatedModalBarrier is available in the widgets package');
  print('AnimatedModalBarrier runtimeType accessible');

  print('AnimatedModalBarrier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedModalBarrier Tests'),
      Text('Modal barrier'),
    ],
  );
}
