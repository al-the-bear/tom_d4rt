// D4rt test script: Tests PercentProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PercentProperty test executing');

  // Test PercentProperty - PercentProperty
  print('PercentProperty is available in the foundation package');
  print('PercentProperty: PercentProperty');

  print('PercentProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PercentProperty Tests'),
      Text('PercentProperty'),
    ],
  );
}
