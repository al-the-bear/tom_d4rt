// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WeakMap from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WeakMap test executing');
  print('=' * 50);

  // WeakMap holds weak references to keys
  print('WeakMap overview:');
  print('  - Generic class WeakMap<K, V>');
  print('  - Weak reference for object keys');
  print('  - Uses Expando for non-primitives');
  print('  - Uses Map for primitives');

  // Implementation strategy
  print('\nImplementation strategy:');
  print('  - Expando for object keys');
  print('  - Map for int, double, bool, String, null');
  print('  - Hybrid approach');
  print('  - Best of both worlds');

  // Key methods
  print('\nKey methods:');
  print('  - operator [](K key): get value');
  print('  - operator []=(K key, V? value): set value');
  print('  - _isPrimitive(key): check key type');
  print('  - Uses correct storage per key');

  // Expando behavior
  print('\nExpando behavior:');
  print('  - Does not prevent key GC');
  print('  - Value disappears with key');
  print('  - Cannot enumerate keys');
  print('  - Like JavaScript WeakMap');

  // Primitive handling
  print('\nPrimitive handling:');
  print('  - Primitives stored in regular Map');
  print('  - Because Expando rejects primitives');
  print('  - Primitives are their own keys');
  print('  - No weak reference needed');

  // _isPrimitive check
  print('\n_isPrimitive logic:');
  print('  bool _isPrimitive(Object key) {');
  print('    return key is num || key is bool ||');
  print('           key is String || key == null;');
  print('  }');

  // Usage in widgets
  print('\nUsage in widgets:');
  print('  - WidgetInspectorService uses it');
  print('  - Track data per Element');
  print('  - Without preventing Element disposal');
  print('  - Memory-safe metadata storage');

  // vs regular Map
  print('\nvs regular Map:');
  print('  - Map: strong reference to keys');
  print('  - WeakMap: weak reference (objects)');
  print('  - Map: prevents key GC');
  print('  - WeakMap: allows key GC');

  // Limitations
  print('\nLimitations:');
  print('  - Cannot iterate over entries');
  print('  - Cannot get size');
  print('  - Cannot check containsKey');
  print('  - Only get/set by exact key');

  print('\n' + '=' * 50);
  print('WeakMap test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WeakMap Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Generic class WeakMap<K, V>'),
      Text('Objects: Uses Expando (weak)'),
      Text('Primitives: Uses Map (strong)'),
    ],
  );
}
