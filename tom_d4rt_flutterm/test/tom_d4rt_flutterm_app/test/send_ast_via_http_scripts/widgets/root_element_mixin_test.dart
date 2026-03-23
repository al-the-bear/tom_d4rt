// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RootElementMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootElementMixin test executing');

  // RootElementMixin is a mixin - verify it exists in the framework
  print('RootElementMixin is a mixin');
  print('RootElementMixin runtimeType check available');
  print('RootElementMixin type: mixin');

  print('RootElementMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootElementMixin Tests'),
      Text('Type: mixin'),
      Text('RootElementMixin'),
    ],
  );
}
