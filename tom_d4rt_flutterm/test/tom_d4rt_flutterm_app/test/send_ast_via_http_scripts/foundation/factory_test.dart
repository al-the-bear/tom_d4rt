// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests Factory from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Factory test executing');
  print('=' * 50);

  // Factory is a generic class that wraps a constructor function
  print('Testing Factory<T> class');

  // Create a factory for String
  final stringFactory = Factory<String>(() => 'Hello from Factory');
  print('\nString Factory created');
  print('runtimeType: ${stringFactory.runtimeType}');
  print('type: ${stringFactory.type}');
  print('toString: $stringFactory');
  
  // Call the constructor
  final str = stringFactory.constructor();
  print('constructor() result: $str');
  print('Result runtimeType: ${str.runtimeType}');

  // Create a factory for int
  int counter = 0;
  final intFactory = Factory<int>(() => ++counter);
  print('\nInt Factory created (incrementing counter)');
  print('type: ${intFactory.type}');
  final int1 = intFactory.constructor();
  final int2 = intFactory.constructor();
  final int3 = intFactory.constructor();
  print('First call: $int1');
  print('Second call: $int2');
  print('Third call: $int3');

  // Create a factory for List
  final listFactory = Factory<List<int>>(() => <int>[1, 2, 3]);
  print('\nList Factory created');
  print('type: ${listFactory.type}');
  final list = listFactory.constructor();
  print('constructor() result: $list');
  print('is List<int>: ${list is List<int>}');

  // Create a factory for a custom object
  final containerFactory = Factory<Container>(() => Container(width: 100, height: 100));
  print('\nContainer Factory created');
  print('type: ${containerFactory.type}');
  final container = containerFactory.constructor();
  print('Widget created: ${container.runtimeType}');

  // Create a factory for Map
  final mapFactory = Factory<Map<String, int>>(() => {'a': 1, 'b': 2});
  print('\nMap Factory created');
  print('type: ${mapFactory.type}');
  final map = mapFactory.constructor();
  print('Map: $map');

  // Test const factory
  const constFactory = Factory<double>(_returnPi);
  print('\nConst Factory created');
  print('type: ${constFactory.type}');
  print('constructor() result: ${constFactory.constructor()}');

  // Test factory equality
  final factory1 = Factory<String>(() => 'a');
  final factory2 = Factory<String>(() => 'a');
  print('\nFactory equality:');
  print('factory1 == factory2: ${factory1 == factory2}');
  print('factory1.type == factory2.type: ${factory1.type == factory2.type}');

  // Test different type factories
  print('\nType comparison:');
  print('stringFactory.type: ${stringFactory.type}');
  print('intFactory.type: ${intFactory.type}');
  print('Types equal: ${stringFactory.type == intFactory.type}');

  print('\n' + '=' * 50);
  print('Factory test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Factory Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Factory<T> wraps constructor functions'),
      Text('Properties: constructor, type'),
      Text('Can be const with top-level functions'),
    ],
  );
}

double _returnPi() => 3.14159;
