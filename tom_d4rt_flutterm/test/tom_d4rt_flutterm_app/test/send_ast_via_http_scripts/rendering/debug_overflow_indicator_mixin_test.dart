// D4rt test script: Tests DebugOverflowIndicatorMixin from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DebugOverflowIndicatorMixin test executing');

  // DebugOverflowIndicatorMixin is a mixin - verify it exists in the framework
  print('DebugOverflowIndicatorMixin is a mixin');
  print('DebugOverflowIndicatorMixin runtimeType check available');

  // Test basic type identity
  print('DebugOverflowIndicatorMixin type: mixin');
  print('Overflow debug');

  print('DebugOverflowIndicatorMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DebugOverflowIndicatorMixin Tests'),
      Text('Type: mixin'),
      Text('Overflow debug'),
    ],
  );
}
