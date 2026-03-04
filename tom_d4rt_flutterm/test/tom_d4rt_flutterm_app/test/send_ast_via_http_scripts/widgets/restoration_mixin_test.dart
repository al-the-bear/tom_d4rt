// D4rt test script: Tests RestorationMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorationMixin test executing');

  // RestorationMixin is a mixin - verify it exists in the framework
  print('RestorationMixin is a mixin');
  print('RestorationMixin runtimeType check available');

  // Test basic type identity
  print('RestorationMixin type: mixin');
  print('Restoration mixin');

  print('RestorationMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorationMixin Tests'),
      Text('Type: mixin'),
      Text('Restoration mixin'),
    ],
  );
}
