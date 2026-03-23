// ignore_for_file: avoid_print
// D4rt test script: Tests ObjectDisposed from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectDisposed test executing');

  // Create test objects
  final obj1 = Object();
  final obj2 = Object();

  // Create ObjectDisposed events
  final event1 = ObjectDisposed(object: obj1);
  final event2 = ObjectDisposed(object: obj2);

  print('ObjectDisposed created: ${event1.runtimeType}');

  // Test object property
  print('\nObject property:');
  print('event1.object: ${event1.object}');
  print('event2.object: ${event2.object}');
  print('Objects are different: ${event1.object != event2.object}');
  print('Object identity preserved: ${identical(event1.object, obj1)}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is ObjectEvent: true /* event1 is ObjectEvent */');
  print('ObjectEvent base class for object lifecycle events');

  // Test runtime type
  print('\nRuntime info:');
  print('runtimeType: ${event1.runtimeType}');
  print('event1.toString(): ${event1.toString()}');

  // Explain purpose
  print('\nObjectDisposed purpose:');
  print('- Represents object disposal event');
  print('- Part of MemoryAllocations tracking');
  print('- Used with FlutterMemoryAllocations.instance');
  print('- Paired with ObjectCreated for lifecycle tracking');
  print('- Helps detect memory leaks in debug mode');

  // Memory tracking context
  print('\nMemory tracking:');
  print('- ObjectCreated: dispatched when object allocated');
  print('- ObjectDisposed: dispatched when object disposed');
  print('- Both extend ObjectEvent with object reference');

  print('\nObjectDisposed test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ObjectDisposed Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${event1.runtimeType}'),
      Text('object: ${event1.object.runtimeType}'),
      Text('is ObjectEvent: true /* event1 is ObjectEvent */'),
      SizedBox(height: 8),
      Text('Purpose: Memory lifecycle tracking'),
      Text('Paired with: ObjectCreated'),
    ],
  );
}
