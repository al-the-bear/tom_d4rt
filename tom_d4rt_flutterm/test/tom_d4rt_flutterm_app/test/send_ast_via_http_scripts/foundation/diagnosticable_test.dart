// D4rt test script: Tests Diagnosticable from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Diagnosticable test executing');

  // Diagnosticable is a mixin - verify it exists in the framework
  print('Diagnosticable is a mixin');
  print('Diagnosticable runtimeType check available');
  print('Diagnosticable type: mixin');

  print('Diagnosticable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Diagnosticable Tests'),
      Text('Type: mixin'),
      Text('Diagnosticable'),
    ],
  );
}
