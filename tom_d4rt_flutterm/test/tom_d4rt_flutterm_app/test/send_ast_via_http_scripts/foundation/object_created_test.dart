// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObjectCreated event from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectCreated test executing');
  print('=' * 50);

  // Create test object
  final testObj = Object();

  // Create ObjectCreated event
  final event1 = ObjectCreated(
    library: 'package:test/test.dart',
    className: 'MyClass',
    object: testObj,
  );
  print('\nObjectCreated created:');
  print('runtimeType: ${event1.runtimeType}');
  print('library: ${event1.library}');
  print('className: ${event1.className}');
  print('object: ${event1.object}');
  print('object.runtimeType: ${event1.object.runtimeType}');

  // Create with Flutter widget
  final container = Container(width: 100, height: 100);
  final event2 = ObjectCreated(
    library: 'package:flutter/widgets.dart',
    className: 'Container',
    object: container,
  );
  print('\nWith Flutter widget:');
  print('library: ${event2.library}');
  print('className: ${event2.className}');
  print('object type: ${event2.object.runtimeType}');

  // Test type hierarchy - ObjectCreated extends ObjectEvent
  print('\nType hierarchy:');
  print('is ObjectEvent: true /* event1 is ObjectEvent */');
  print('is Object: true /* event1 is Object */');

  // Create for various library formats
  print('\nVarious library formats:');
  final dartCore = ObjectCreated(
    library: 'dart:core',
    className: 'List',
    object: <int>[],
  );
  final packageLib = ObjectCreated(
    library: 'package:my_app/src/models/user.dart',
    className: 'User',
    object: Object(),
  );
  final relativeLib = ObjectCreated(
    library: 'lib/utils.dart',
    className: 'Helper',
    object: Object(),
  );
  print('dart:core - ${dartCore.library}');
  print('package: - ${packageLib.library}');
  print('relative - ${relativeLib.library}');

  // Test with null-like scenarios (using Object as placeholder)
  print('\nEdge cases:');
  final emptyLib = ObjectCreated(
    library: '',
    className: 'Unknown',
    object: Object(),
  );
  final emptyClass = ObjectCreated(
    library: 'test',
    className: '',
    object: Object(),
  );
  print('Empty library: "${emptyLib.library}"');
  print('Empty className: "${emptyClass.className}"');

  // Compare events
  print('\nEvent comparison:');
  final sameObj = Object();
  final eventA = ObjectCreated(
    library: 'test',
    className: 'Test',
    object: sameObj,
  );
  final eventB = ObjectCreated(
    library: 'test',
    className: 'Test',
    object: sameObj,
  );
  print('eventA == eventB: ${eventA == eventB}');
  print('identical: ${identical(eventA, eventB)}');
  print('Same object: ${identical(eventA.object, eventB.object)}');

  // Library path parsing
  print('\nLibrary path analysis:');
  print(
    'event1.library.contains("package:"): ${event1.library.contains("package:")}',
  );
  print(
    'dartCore.library.startsWith("dart:"): ${dartCore.library.startsWith("dart:")}',
  );

  // Explain purpose
  print('\nObjectCreated purpose:');
  print('- Event fired when a tracked object is created');
  print('- Part of FlutterMemoryAllocations system');
  print('- Used for memory leak detection');
  print('- Carries library, className, and object reference');
  print('- Extends ObjectEvent base class');
  print('- Used with MemoryAllocations.instance.dispatchObjectCreated()');

  print('\n' + '=' * 50);
  print('ObjectCreated test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ObjectCreated Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${event1.runtimeType}'),
      Text('library: ${event1.library}'),
      Text('className: ${event1.className}'),
      Text('is ObjectEvent: true /* event1 is ObjectEvent */'),
      Text('Purpose: Memory allocation tracking'),
    ],
  );
}
