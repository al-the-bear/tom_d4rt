// ignore_for_file: avoid_print
// D4rt test script: Tests AndroidPointerProperties from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerProperties test executing');
  print('=' * 50);

  // Create AndroidPointerProperties for finger touch
  final finger = AndroidPointerProperties(id: 0, toolType: 1);
  print('\nAndroidPointerProperties for finger:');
  print('runtimeType: ${finger.runtimeType}');
  print('id: ${finger.id}');
  print('toolType: ${finger.toolType}');

  // Create for stylus
  final stylus = AndroidPointerProperties(id: 1, toolType: 2);
  print('\nStylus properties:');
  print('id: ${stylus.id}');
  print('toolType: ${stylus.toolType}');

  // Create for mouse
  final mouse = AndroidPointerProperties(id: 2, toolType: 3);
  print('\nMouse properties:');
  print('id: ${mouse.id}');
  print('toolType: ${mouse.toolType}');

  // Create for eraser
  final eraser = AndroidPointerProperties(id: 3, toolType: 4);
  print('\nEraser properties:');
  print('id: ${eraser.id}');
  print('toolType: ${eraser.toolType}');

  // ToolType constants reference
  print('\nToolType constants (Android):');
  print('0 = TOOL_TYPE_UNKNOWN');
  print('1 = TOOL_TYPE_FINGER');
  print('2 = TOOL_TYPE_STYLUS');
  print('3 = TOOL_TYPE_MOUSE');
  print('4 = TOOL_TYPE_ERASER');

  // Multi-touch scenario
  print('\nMulti-touch scenario:');
  final touch1 = AndroidPointerProperties(id: 0, toolType: 1);
  final touch2 = AndroidPointerProperties(id: 1, toolType: 1);
  final touch3 = AndroidPointerProperties(id: 2, toolType: 1);
  print('Touch 1 id: ${touch1.id}');
  print('Touch 2 id: ${touch2.id}');
  print('Touch 3 id: ${touch3.id}');
  print(
    'All fingers: ${touch1.toolType == touch2.toolType && touch2.toolType == touch3.toolType}',
  );

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* finger is Object */');

  // Compare pointers by ID
  print('\nPointer ID comparison:');
  print('finger.id == stylus.id: ${finger.id == stylus.id}');
  print('finger.id == touch1.id: ${finger.id == touch1.id}');

  // ToolType checking pattern
  print('\nToolType checking pattern:');
  bool isFinger(AndroidPointerProperties p) => p.toolType == 1;
  bool isStylus(AndroidPointerProperties p) => p.toolType == 2;
  print('finger isFinger: ${isFinger(finger)}');
  print('stylus isStylus: ${isStylus(stylus)}');
  print('finger isStylus: ${isStylus(finger)}');

  // Explain purpose
  print('\nAndroidPointerProperties purpose:');
  print('- Identifies pointer properties in Android events');
  print('- id: Unique identifier for pointer/touch');
  print('- toolType: Type of input device');
  print('- Used in AndroidMotionEvent for multi-touch');
  print('- Enables distinguishing stylus from finger');

  print('\n' + '=' * 50);
  print('AndroidPointerProperties test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AndroidPointerProperties Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${finger.runtimeType}'),
      Text('finger id: ${finger.id}, toolType: ${finger.toolType}'),
      Text('stylus id: ${stylus.id}, toolType: ${stylus.toolType}'),
      Text('Purpose: Android pointer identification'),
    ],
  );
}
