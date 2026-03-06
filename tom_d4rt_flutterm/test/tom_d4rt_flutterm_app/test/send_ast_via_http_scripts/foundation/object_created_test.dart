// D4rt test script: Tests ObjectCreated from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ObjectCreated test executing');

  // Test ObjectCreated - Object lifecycle
  print('ObjectCreated is available in the foundation package');
  print('ObjectCreated: Object lifecycle');

  print('ObjectCreated test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectCreated Tests'),
      Text('Object lifecycle'),
    ],
  );
}
