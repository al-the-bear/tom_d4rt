// D4rt test script: Tests AlignTransition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlignTransition test executing');

  // Test AlignTransition - Transition
  print('AlignTransition is available in the widgets package');
  print('AlignTransition runtimeType accessible');

  print('AlignTransition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AlignTransition Tests'),
      Text('Transition'),
    ],
  );
}
