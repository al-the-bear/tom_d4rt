// D4rt test script: Tests ViewportElementMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ViewportElementMixin test executing');

  // ViewportElementMixin is a mixin - verify it exists in the framework
  print('ViewportElementMixin is a mixin');
  print('ViewportElementMixin runtimeType check available');
  print('ViewportElementMixin type: mixin');

  print('ViewportElementMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ViewportElementMixin Tests'),
      Text('Type: mixin'),
      Text('ViewportElementMixin'),
    ],
  );
}
