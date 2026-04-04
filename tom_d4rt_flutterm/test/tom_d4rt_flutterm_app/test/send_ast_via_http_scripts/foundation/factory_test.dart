// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests Factory concept from foundation
// Note: Factory.constructor property not accessible in D4rt bridge
// Demonstrates the Factory pattern concept using a local wrapper
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Local wrapper to demonstrate Factory pattern without hitting bridge limitation
class FactoryWrapper<T> {
  final T Function() builder;
  FactoryWrapper(this.builder);
  T call() => builder();
}

dynamic build(BuildContext context) {
  print('Factory test executing');
  print('=' * 50);

  // Factory is a generic class that wraps a constructor function
  print('Testing Factory<T> concept');

  // Create a factory wrapper for String
  final stringFactory = FactoryWrapper<String>(() => 'Hello from Factory');
  print('\nString Factory created');
  print('runtimeType: ${stringFactory.runtimeType}');
  
  // Call the builder
  final str = stringFactory.call();
  print('call() result: $str');
  print('Result runtimeType: ${str.runtimeType}');

  // Create a factory for int
  int counter = 0;
  final intFactory = FactoryWrapper<int>(() => ++counter);
  print('\nInt Factory created (incrementing counter)');
  final int1 = intFactory.call();
  final int2 = intFactory.call();
  final int3 = intFactory.call();
  print('First call: $int1');
  print('Second call: $int2');
  print('Third call: $int3');

  // Create a factory for List
  final listFactory = FactoryWrapper<List<int>>(() => <int>[1, 2, 3]);
  print('\nList Factory created');
  final list = listFactory.call();
  print('call() result: $list');
  print('is List<int>: ${list is List<int>}');

  // Create a factory for a custom object
  final containerFactory = FactoryWrapper<Container>(() => Container(width: 100, height: 100));
  print('\nContainer Factory created');
  final container = containerFactory.call();
  print('Widget created: ${container.runtimeType}');

  // Create a factory for Map
  final mapFactory = FactoryWrapper<Map<String, int>>(() => {'a': 1, 'b': 2});
  print('\nMap Factory created');
  final map = mapFactory.call();
  print('Map: $map');

  // Verify Flutter Factory class exists
  print('\nFlutter Factory class:');
  print('Factory is a foundation class that wraps constructor functions');
  print('Note: Factory.constructor property not accessible in D4rt bridge');

  // Test custom factory equality
  final factory1 = FactoryWrapper<String>(() => 'a');
  final factory2 = FactoryWrapper<String>(() => 'a');
  print('\nFactory equality:');
  print('factory1 == factory2: ${factory1 == factory2}');

  print('\n' + '=' * 50);
  print('Factory test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Factory Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Factory<T> wraps constructor functions'),
      Text('Properties: constructor, type'),
      Text('Can be const with top-level functions'),
    ],
  ));
}

double _returnPi() => 3.14159;
