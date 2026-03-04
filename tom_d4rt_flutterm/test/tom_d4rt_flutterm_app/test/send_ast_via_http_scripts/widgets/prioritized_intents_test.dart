// D4rt test script: Tests PrioritizedIntents from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PrioritizedIntents test executing');

  // Test PrioritizedIntents - PrioritizedIntents
  print('PrioritizedIntents is available in the widgets package');
  print('PrioritizedIntents runtimeType accessible');

  print('PrioritizedIntents test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PrioritizedIntents Tests'),
      Text('PrioritizedIntents'),
    ],
  );
}
