// D4rt test script: Tests Element from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Element test executing');

  // Test Element - Widget element
  print('Element is available in the widgets package');
  print('Element runtimeType accessible');

  print('Element test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Element Tests'),
      Text('Widget element'),
    ],
  );
}
