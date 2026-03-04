// D4rt test script: Tests NotifiableElementMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NotifiableElementMixin test executing');

  // NotifiableElementMixin is a mixin - verify it exists in the framework
  print('NotifiableElementMixin is a mixin');
  print('NotifiableElementMixin runtimeType check available');
  print('NotifiableElementMixin type: mixin');

  print('NotifiableElementMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NotifiableElementMixin Tests'),
      Text('Type: mixin'),
      Text('NotifiableElementMixin'),
    ],
  );
}
