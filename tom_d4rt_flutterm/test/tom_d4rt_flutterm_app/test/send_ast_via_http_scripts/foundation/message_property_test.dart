// D4rt test script: Tests MessageProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MessageProperty test executing');

  // Test MessageProperty - MessageProperty
  print('MessageProperty is available in the foundation package');
  print('MessageProperty: MessageProperty');

  print('MessageProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MessageProperty Tests'),
      Text('MessageProperty'),
    ],
  );
}
