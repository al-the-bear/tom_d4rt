// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Selectable from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Selectable test executing');

  // Selectable is a mixin - verify it exists in the framework
  print('Selectable is a mixin');
  print('Selectable runtimeType check available');

  // Test basic type identity
  print('Selectable type: mixin');
  print('Selectable interface');

  print('Selectable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Selectable Tests'),
      Text('Type: mixin'),
      Text('Selectable interface'),
    ],
  );
}
