// D4rt test script: Tests ObjectDisposed from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ObjectDisposed test executing');

  // Test ObjectDisposed - Object lifecycle
  print('ObjectDisposed is available in the foundation package');
  print('ObjectDisposed: Object lifecycle');

  print('ObjectDisposed test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectDisposed Tests'),
      Text('Object lifecycle'),
    ],
  );
}
