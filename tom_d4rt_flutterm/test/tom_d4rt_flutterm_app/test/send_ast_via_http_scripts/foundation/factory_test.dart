// D4rt test script: Tests Factory from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Factory test executing');

  // Test Factory - Factory
  print('Factory is available in the foundation package');
  print('Factory: Factory');

  print('Factory test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Factory Tests'),
      Text('Factory'),
    ],
  );
}
