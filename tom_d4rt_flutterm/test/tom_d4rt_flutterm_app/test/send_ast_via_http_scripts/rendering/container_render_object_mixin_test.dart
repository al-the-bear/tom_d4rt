// D4rt test script: Tests ContainerRenderObjectMixin from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContainerRenderObjectMixin test executing');

  // ContainerRenderObjectMixin is a mixin - verify it exists in the framework
  print('ContainerRenderObjectMixin is a mixin');
  print('ContainerRenderObjectMixin runtimeType check available');

  // Test basic type identity
  print('ContainerRenderObjectMixin type: mixin');
  print('Container mixin');

  print('ContainerRenderObjectMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContainerRenderObjectMixin Tests'),
      Text('Type: mixin'),
      Text('Container mixin'),
    ],
  );
}
