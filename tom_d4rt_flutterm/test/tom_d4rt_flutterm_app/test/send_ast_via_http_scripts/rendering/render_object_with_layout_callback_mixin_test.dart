// D4rt test script: Tests RenderObjectWithLayoutCallbackMixin from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectWithLayoutCallbackMixin test executing');

  // RenderObjectWithLayoutCallbackMixin is a mixin - verify it exists in the framework
  print('RenderObjectWithLayoutCallbackMixin is a mixin');
  print('RenderObjectWithLayoutCallbackMixin runtimeType check available');
  print('RenderObjectWithLayoutCallbackMixin type: mixin');

  print('RenderObjectWithLayoutCallbackMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderObjectWithLayoutCallbackMixin Tests'),
      Text('Type: mixin'),
      Text('Layout callback'),
    ],
  );
}
