// D4rt test script: Tests Factory from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Factory test executing');

  final factory = Factory<List<int>>(() => [1, 2, 3]);
  print('Factory: ${factory.runtimeType}');
  final result1 = factory.constructor();
  print('result1: $result1');
  final result2 = factory.constructor();
  print('result2: $result2');
  print('same instance: ${identical(result1, result2)}');

  final factory2 = Factory<String>(() => 'hello');
  print('String factory: ${factory2.constructor()}');

  print('Factory test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Factory Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Creates new instances each call'),
      Text('Result: $result1'),
      Text('Not same: ${!identical(result1, result2)}'),
    ],
  );
}
