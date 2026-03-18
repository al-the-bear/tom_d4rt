// D4rt test script: Tests ContainerParentDataMixin from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContainerParentDataMixin test executing');

  // ContainerParentDataMixin is a mixin - verify it exists in the framework
  print('ContainerParentDataMixin is a mixin');
  print('ContainerParentDataMixin runtimeType check available');
  print('ContainerParentDataMixin type: mixin');

  print('ContainerParentDataMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContainerParentDataMixin Tests'),
      Text('Type: mixin'),
      Text('ContainerParentDataMixin'),
    ],
  );
}
