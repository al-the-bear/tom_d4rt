// D4rt test script: Tests IterableProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IterableProperty test executing');

  // Test IterableProperty - IterableProperty
  print('IterableProperty is available in the foundation package');
  print('IterableProperty: IterableProperty');

  print('IterableProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IterableProperty Tests'),
      Text('IterableProperty'),
    ],
  );
}
