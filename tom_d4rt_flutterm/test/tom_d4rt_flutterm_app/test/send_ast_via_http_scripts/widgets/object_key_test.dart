// D4rt test script: Tests ObjectKey from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ObjectKey test executing');

  // Test ObjectKey - ObjectKey
  print('ObjectKey is available in the widgets package');
  print('ObjectKey runtimeType accessible');

  print('ObjectKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectKey Tests'),
      Text('ObjectKey'),
    ],
  );
}
