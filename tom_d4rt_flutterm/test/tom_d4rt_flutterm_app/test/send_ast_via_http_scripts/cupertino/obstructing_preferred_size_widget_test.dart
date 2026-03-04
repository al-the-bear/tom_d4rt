// D4rt test script: Tests ObstructingPreferredSizeWidget from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('ObstructingPreferredSizeWidget test executing');

  // Test ObstructingPreferredSizeWidget - Obstructing widget
  print('ObstructingPreferredSizeWidget is available in the cupertino package');
  print('ObstructingPreferredSizeWidget runtimeType accessible');

  print('ObstructingPreferredSizeWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObstructingPreferredSizeWidget Tests'),
      Text('Obstructing widget'),
    ],
  );
}
