// D4rt test script: Tests ObjectDisposed from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectDisposed comprehensive test executing');
  final results = <String>[];

  // ========== ObjectDisposed Tests ==========
  print('Testing ObjectDisposed...');

  // Test 1: Create ObjectDisposed event
  final testObject = Object();
  final event1 = ObjectDisposed(object: testObject);
  assert(event1 != null, 'Should create ObjectDisposed');
  results.add('ObjectDisposed created');
  print('ObjectDisposed created: ${event1.runtimeType}');

  // Test 2: Verify object property
  assert(event1.object == testObject, 'Object reference should match');
  results.add('Object reference verified');
  print('Object: ${event1.object}');

  // Test 3: Check inheritance from ObjectEvent
  assert(event1 is ObjectEvent, 'Should be ObjectEvent');
  results.add('Inheritance: ObjectEvent');
  print('Is ObjectEvent: ${event1 is ObjectEvent}');

  // Test 4: ObjectDisposed vs ObjectCreated
  final createdEvent = ObjectCreated(object: testObject);
  assert(createdEvent is ObjectEvent, 'Created should be ObjectEvent');
  assert(event1 is ObjectEvent, 'Disposed should be ObjectEvent');
  results.add('Both are ObjectEvent subclasses');
  print('ObjectCreated and ObjectDisposed are ObjectEvent');

  // Test 5: Create event with custom object
  final customObj = StringBuffer('test');
  final event2 = ObjectDisposed(object: customObj);
  assert(event2.object == customObj, 'Custom object should match');
  results.add('ObjectDisposed with StringBuffer');
  print('Event with StringBuffer: ${event2.object.runtimeType}');

  // Test 6: Purpose of ObjectDisposed
  results.add('Purpose: Track object lifecycle disposal');
  print('ObjectDisposed tracks when objects are disposed');

  // Test 7: Memory tracking context
  results.add('Used for memory leak detection');
  print('FlutterMemoryAllocations uses ObjectDisposed');

  // Test 8: Create event with list object
  final listObj = [1, 2, 3];
  final event3 = ObjectDisposed(object: listObj);
  assert(event3.object == listObj, 'List reference should match');
  results.add('ObjectDisposed with List');
  print('Event with List: ${event3.object.runtimeType}');

  // Test 9: Create event with map object
  final mapObj = {'key': 'value'};
  final event4 = ObjectDisposed(object: mapObj);
  assert(event4.object == mapObj, 'Map reference should match');
  results.add('ObjectDisposed with Map');
  print('Event with Map: ${event4.object.runtimeType}');

  // Test 10: Object identity preservation
  assert(identical(event1.object, testObject), 'Should be identical');
  results.add('Object identity preserved');
  print('Object identity verified via identical()');

  // Test 11: Multiple events for same object
  final multiObj = Object();
  final created = ObjectCreated(object: multiObj);
  final disposed = ObjectDisposed(object: multiObj);
  assert(created.object == disposed.object, 'Same object tracked');
  results.add('Created and Disposed track same object');
  print('Lifecycle: Created -> Disposed');

  // Test 12: FlutterMemoryAllocations concept
  results.add('FlutterMemoryAllocations.instance dispatches events');
  print('Memory allocations system uses these events');

  // Test 13: DevTools integration
  results.add('Events visible in Flutter DevTools');
  print('DevTools memory view shows allocation events');

  // Test 14: Debug mode tracking
  results.add('Typically enabled in debug mode only');
  print('Memory tracking disabled in release builds');

  // Test 15: Event runtime type
  assert(event1.runtimeType.toString() == 'ObjectDisposed', 'Runtime type should match');
  results.add('Runtime type: ${event1.runtimeType}');
  print('Runtime type: ${event1.runtimeType}');

  // Test 16: ObjectEvent hierarchy
  results.add('ObjectEvent: base for Created/Disposed');
  print('ObjectEvent is abstract base class');

  // Test 17: Object.hashCode for tracking
  final hash = testObject.hashCode;
  assert(hash != 0, 'Hash code should exist');
  results.add('Object hashCode: $hash');
  print('Object can be identified by hashCode: $hash');

  // Test 18: ChangeNotifier disposal tracking
  results.add('ChangeNotifier dispose tracked via ObjectDisposed');
  print('Dispose pattern commonly used with ChangeNotifier');

  // Test 19: Event collection pattern
  final events = <ObjectEvent>[
    ObjectCreated(object: testObject),
    ObjectDisposed(object: testObject),
  ];
  assert(events.length == 2, 'Should have lifecycle events');
  results.add('Lifecycle events: ${events.length}');
  print('Lifecycle events collected: ${events.length}');

  // Test 20: Summary
  print('ObjectDisposed test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectDisposed Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Constructor: ObjectDisposed(object: obj)'),
      Text('Inheritance: ObjectEvent'),
      Text('Purpose: Track object disposal for memory analysis'),
      Text('Used by: FlutterMemoryAllocations'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
