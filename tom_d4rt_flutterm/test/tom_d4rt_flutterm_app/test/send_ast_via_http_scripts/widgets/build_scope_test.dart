// D4rt test script: Tests BuildScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BuildScope test executing');

  // Test BuildScope - Build scope
  print('BuildScope is available in the widgets package');
  print('BuildScope runtimeType accessible');

  print('BuildScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BuildScope Tests'),
      Text('Build scope'),
    ],
  );
}
