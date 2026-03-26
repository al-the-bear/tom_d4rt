// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Factory from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Factory test executing');
  print('=' * 50);

  // Factory<T> overview
  print('\nFactory<T> overview:');
  print('Purpose: Wraps a factory function (ValueGetter<T>)');
  print('Property: constructor (the wrapped function)');
  print('Generic: parameterized by the type it creates');

  // Create Factory<String>
  final stringFactory = Factory<String>(() => 'Hello, Factory!');
  print('\nFactory<String> created');
  print('runtimeType: ${stringFactory.runtimeType}');
  print('constructor result: ${stringFactory.constructor()}');
  print('is Factory: ${stringFactory is Factory}');
  print('is Factory<String>: ${stringFactory is Factory<String>}');
  print('toString: $stringFactory');

  // Create Factory<int>
  final intFactory = Factory<int>(() => 42);
  print('\nFactory<int> created');
  print('runtimeType: ${intFactory.runtimeType}');
  print('constructor result: ${intFactory.constructor()}');
  print('is Factory<int>: ${intFactory is Factory<int>}');
  print('toString: $intFactory');

  // Create Factory<List<double>>
  final listFactory = Factory<List<double>>(() => [1.0, 2.0, 3.0]);
  print('\nFactory<List<double>> created');
  print('constructor result: ${listFactory.constructor()}');
  print('result length: ${listFactory.constructor().length}');
  print('toString: $listFactory');

  // Stateful factory
  var counter = 0;
  final counterFactory = Factory<int>(() => ++counter);
  print('\nStateful Factory<int> (counter):');
  print('Call 1: ${counterFactory.constructor()}');
  print('Call 2: ${counterFactory.constructor()}');
  print('Call 3: ${counterFactory.constructor()}');
  print('Counter after 3 calls: $counter');

  // Factory<Widget>
  final widgetFactory = Factory<Widget>(() => const Text('Factory Widget'));
  print('\nFactory<Widget> created');
  print('runtimeType: ${widgetFactory.runtimeType}');
  final widget = widgetFactory.constructor();
  print('Widget created: ${widget.runtimeType}');
  print('is Widget: ${widget is Widget}');

  // Factory for Map
  final mapFactory = Factory<Map<String, int>>(() => {'a': 1, 'b': 2, 'c': 3});
  print('\nFactory<Map<String, int>> created');
  final map = mapFactory.constructor();
  print('Map: $map');
  print('Keys: ${map.keys.toList()}');
  print('Values: ${map.values.toList()}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Factory<String> is Factory: ${stringFactory is Factory}');
  print('Factory<int> is Factory: ${intFactory is Factory}');
  print('Same runtimeType: ${stringFactory.runtimeType == intFactory.runtimeType}');

  // Equality
  final f1 = Factory<int>(() => 1);
  final f2 = Factory<int>(() => 1);
  print('\nEquality:');
  print('f1 == f2: ${f1 == f2}');
  print('f1 == f1: ${f1 == f1}');
  print('identical(f1, f1): ${identical(f1, f1)}');

  print('\n' + '=' * 50);
  print('Factory test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Factory Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Factory<String>: ${stringFactory.constructor()}'),
      Text('Factory<int>: ${intFactory.constructor()}'),
      Text('Factory<List>: ${listFactory.constructor()}'),
      Text('Stateful counter: $counter calls'),
      Text('Factory<Widget>: ${widget.runtimeType}'),
    ],
  );
}
