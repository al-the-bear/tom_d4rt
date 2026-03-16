// D4rt test script: Tests PersistentHashMap from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PersistentHashMap test executing');

  var map = PersistentHashMap<String, int>.empty();
  print('Empty map: ${map.runtimeType}');

  map = map.put('a', 1);
  map = map.put('b', 2);
  map = map.put('c', 3);
  print('After puts: a=${map['a']}, b=${map['b']}, c=${map['c']}');

  // Immutable — original not modified
  final map2 = map.put('d', 4);
  print('map has d: ${map['d']}');
  print('map2 has d: ${map2['d']}');

  // Overwrite
  final map3 = map.put('a', 100);
  print('map a: ${map['a']}, map3 a: ${map3['a']}');

  print('PersistentHashMap test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PersistentHashMap Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Immutable map with O(log n) operations'),
    Text('a=${map['a']}, b=${map['b']}, c=${map['c']}'),
  ]);
}
