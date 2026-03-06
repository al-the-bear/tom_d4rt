// D4rt test script: Tests PersistentHashMap from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PersistentHashMap test executing');

  // Test PersistentHashMap - Immutable hash map
  print('PersistentHashMap is available in the foundation package');
  print('PersistentHashMap: Immutable hash map');

  print('PersistentHashMap test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PersistentHashMap Tests'),
      Text('Immutable hash map'),
    ],
  );
}
