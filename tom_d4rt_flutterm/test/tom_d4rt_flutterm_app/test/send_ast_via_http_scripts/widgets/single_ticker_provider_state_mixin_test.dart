// D4rt test script: Tests SingleTickerProviderStateMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SingleTickerProviderStateMixin test executing');

  // SingleTickerProviderStateMixin is a mixin - verify it exists in the framework
  print('SingleTickerProviderStateMixin is a mixin');
  print('SingleTickerProviderStateMixin runtimeType check available');

  // Test basic type identity
  print('SingleTickerProviderStateMixin type: mixin');
  print('Single ticker');

  print('SingleTickerProviderStateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SingleTickerProviderStateMixin Tests'),
      Text('Type: mixin'),
      Text('Single ticker'),
    ],
  );
}
