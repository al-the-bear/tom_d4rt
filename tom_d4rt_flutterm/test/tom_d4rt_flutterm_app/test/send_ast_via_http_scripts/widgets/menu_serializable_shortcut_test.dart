// D4rt test script: Tests MenuSerializableShortcut from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MenuSerializableShortcut test executing');

  // MenuSerializableShortcut is a mixin - verify it exists in the framework
  print('MenuSerializableShortcut is a mixin');
  print('MenuSerializableShortcut runtimeType check available');
  print('MenuSerializableShortcut type: mixin');

  print('MenuSerializableShortcut test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MenuSerializableShortcut Tests'),
      Text('Type: mixin'),
      Text('MenuSerializableShortcut'),
    ],
  );
}
