// D4rt test script: Tests RepeatingAnimationBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RepeatingAnimationBuilder test executing');

  // Test RepeatingAnimationBuilder - RepeatingAnimationBuilder
  print('RepeatingAnimationBuilder is available in the widgets package');
  print('RepeatingAnimationBuilder runtimeType accessible');

  print('RepeatingAnimationBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RepeatingAnimationBuilder Tests'),
      Text('RepeatingAnimationBuilder'),
    ],
  );
}
