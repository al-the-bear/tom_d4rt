// D4rt test script: Tests AndroidMotionEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('AndroidMotionEvent comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: AndroidMotionEvent creation with basic parameters
  print('\n--- Test 1: AndroidMotionEvent creation ---');
  try {
    final pointerCoords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 100.0,
        y: 200.0,
      ),
    ];
    final pointerProperties = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 1000,
      eventTime: 1001,
      action: 0,
      pointerCount: 1,
      pointerProperties: pointerProperties,
      pointerCoords: pointerCoords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 123,
    );
    assert(event.downTime == 1000);
    assert(event.eventTime == 1001);
    assert(event.action == 0);
    assert(event.pointerCount == 1);
    print('Event downTime: ${event.downTime}');
    print('Event eventTime: ${event.eventTime}');
    print('Event action: ${event.action}');
    print('Event pointerCount: ${event.pointerCount}');
    recordTest('AndroidMotionEvent creation with basic parameters', true);
  } catch (e) {
    print('Error: $e');
    recordTest('AndroidMotionEvent creation with basic parameters', false);
  }

  // Test 2: AndroidMotionEvent with multiple pointers
  print('\n--- Test 2: Multi-pointer AndroidMotionEvent ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 100.0,
        y: 200.0,
      ),
      AndroidPointerCoords(
        orientation: 0.5,
        pressure: 0.8,
        size: 0.4,
        toolMajor: 8.0,
        toolMinor: 8.0,
        touchMajor: 12.0,
        touchMinor: 12.0,
        x: 300.0,
        y: 400.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
      AndroidPointerProperties(id: 1, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 2000,
      eventTime: 2001,
      action: 5,
      pointerCount: 2,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 456,
    );
    assert(event.pointerCount == 2);
    assert(event.pointerCoords.length == 2);
    assert(event.pointerProperties.length == 2);
    print('Multi-pointer event created with ${event.pointerCount} pointers');
    recordTest('Multi-pointer AndroidMotionEvent creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Multi-pointer AndroidMotionEvent creation', false);
  }

  // Test 3: Motion event actions
  print('\n--- Test 3: Motion event action values ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 50.0,
        y: 50.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];

    // ACTION_DOWN = 0
    final downEvent = AndroidMotionEvent(
      downTime: 3000,
      eventTime: 3001,
      action: 0,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 789,
    );
    assert(downEvent.action == 0);
    print('ACTION_DOWN event action: ${downEvent.action}');

    // ACTION_UP = 1
    final upEvent = AndroidMotionEvent(
      downTime: 3000,
      eventTime: 3100,
      action: 1,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 790,
    );
    assert(upEvent.action == 1);
    print('ACTION_UP event action: ${upEvent.action}');
    recordTest('Motion event action values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Motion event action values', false);
  }

  // Test 4: Meta state flags
  print('\n--- Test 4: Meta state flags ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 150.0,
        y: 250.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 4000,
      eventTime: 4001,
      action: 2,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 65, // SHIFT + ALT
      buttonState: 1,
      xPrecision: 1.0,
      yPrecision: 1.0,
      deviceId: 1,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 1000,
    );
    assert(event.metaState == 65);
    assert(event.buttonState == 1);
    print('Meta state: ${event.metaState}');
    print('Button state: ${event.buttonState}');
    recordTest('Meta state flags handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Meta state flags handling', false);
  }

  // Test 5: Device and source information
  print('\n--- Test 5: Device and source information ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 200.0,
        y: 300.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 5000,
      eventTime: 5001,
      action: 0,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 2.0,
      yPrecision: 2.0,
      deviceId: 5,
      edgeFlags: 3,
      source: 0x1002,
      flags: 128,
      motionEventId: 2000,
    );
    assert(event.deviceId == 5);
    assert(event.source == 0x1002);
    assert(event.flags == 128);
    assert(event.edgeFlags == 3);
    print('Device ID: ${event.deviceId}');
    print('Source: ${event.source}');
    print('Flags: ${event.flags}');
    print('Edge flags: ${event.edgeFlags}');
    recordTest('Device and source information', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Device and source information', false);
  }

  // Test 6: Precision values
  print('\n--- Test 6: Precision values ---');
  try {
    final coords = <AndroidPointerCoords>[
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 15.0,
        touchMinor: 15.0,
        x: 250.0,
        y: 350.0,
      ),
    ];
    final props = <AndroidPointerProperties>[
      AndroidPointerProperties(id: 0, toolType: 1),
    ];
    final event = AndroidMotionEvent(
      downTime: 6000,
      eventTime: 6001,
      action: 2,
      pointerCount: 1,
      pointerProperties: props,
      pointerCoords: coords,
      metaState: 0,
      buttonState: 0,
      xPrecision: 3.5,
      yPrecision: 4.5,
      deviceId: 0,
      edgeFlags: 0,
      source: 0x1002,
      flags: 0,
      motionEventId: 3000,
    );
    assert(event.xPrecision == 3.5);
    assert(event.yPrecision == 4.5);
    print('X Precision: ${event.xPrecision}');
    print('Y Precision: ${event.yPrecision}');
    recordTest('Precision values handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Precision values handling', false);
  }

  // Print summary
  print('\n========================================');
  print('AndroidMotionEvent Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'AndroidMotionEvent Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
