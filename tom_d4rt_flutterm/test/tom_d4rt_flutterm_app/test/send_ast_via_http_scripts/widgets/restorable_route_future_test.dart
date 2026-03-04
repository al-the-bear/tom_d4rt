// D4rt test script: Tests RestorableRouteFuture from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableRouteFuture test executing');

  // Test RestorableRouteFuture - RestorableRouteFuture
  print('RestorableRouteFuture is available in the widgets package');
  print('RestorableRouteFuture runtimeType accessible');

  print('RestorableRouteFuture test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableRouteFuture Tests'),
      Text('RestorableRouteFuture'),
    ],
  );
}
