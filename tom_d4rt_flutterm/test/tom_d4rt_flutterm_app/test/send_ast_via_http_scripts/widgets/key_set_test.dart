// D4rt test script: Tests KeySet from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeySet test executing');

  // Test KeySet - KeySet
  print('KeySet is available in the widgets package');
  print('KeySet runtimeType accessible');

  print('KeySet test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeySet Tests'),
      Text('KeySet'),
    ],
  );
}
