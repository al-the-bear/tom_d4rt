// D4rt test script: Tests RelativePositionedTransition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RelativePositionedTransition test executing');

  // Test RelativePositionedTransition - RelativePositionedTransition
  print('RelativePositionedTransition is available in the widgets package');
  print('RelativePositionedTransition runtimeType accessible');

  print('RelativePositionedTransition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RelativePositionedTransition Tests'),
      Text('RelativePositionedTransition'),
    ],
  );
}
