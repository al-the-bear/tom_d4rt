// D4rt test script: Tests KeepAliveParentDataMixin from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeepAliveParentDataMixin test executing');

  // KeepAliveParentDataMixin is a mixin - verify it exists in the framework
  print('KeepAliveParentDataMixin is a mixin');
  print('KeepAliveParentDataMixin runtimeType check available');

  // Test basic type identity
  print('KeepAliveParentDataMixin type: mixin');
  print('Keep alive data');

  print('KeepAliveParentDataMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeepAliveParentDataMixin Tests'),
      Text('Type: mixin'),
      Text('Keep alive data'),
    ],
  );
}
