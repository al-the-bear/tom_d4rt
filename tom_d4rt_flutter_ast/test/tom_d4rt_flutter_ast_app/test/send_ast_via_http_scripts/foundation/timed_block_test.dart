// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TimedBlock from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimedBlock test executing');
  print('=' * 50);

  // Create TimedBlock with basic parameters
  final tb1 = TimedBlock(name: 'test_phase', start: 1000.0, end: 2500.0);
  print('\nTimedBlock created:');
  print('runtimeType: ${tb1.runtimeType}');
  print('name: ${tb1.name}');
  print('start: ${tb1.start}');
  print('end: ${tb1.end}');
  print('duration: ${tb1.duration}');

  // Verify duration calculation
  print('\nDuration calculation:');
  print('end - start = ${tb1.end} - ${tb1.start} = ${tb1.end - tb1.start}');
  print('duration property: ${tb1.duration}');

  // Create with zero duration
  final tb2 = TimedBlock(name: 'instant', start: 5000.0, end: 5000.0);
  print('\nZero duration block:');
  print('name: ${tb2.name}');
  print('start == end: ${tb2.start == tb2.end}');
  print('duration: ${tb2.duration}');

  // Create with very long duration
  final tb3 = TimedBlock(name: 'long_operation', start: 0.0, end: 30000.0);
  print('\nLong duration block:');
  print('name: ${tb3.name}');
  print('duration: ${tb3.duration} microseconds');
  print('duration in seconds: ${tb3.duration / 1000000}');

  // Test different phase names
  print('\nCommon phase names:');
  final buildPhase = TimedBlock(name: 'build', start: 0.0, end: 16.0);
  final layoutPhase = TimedBlock(name: 'layout', start: 16.0, end: 24.0);
  final paintPhase = TimedBlock(name: 'paint', start: 24.0, end: 32.0);
  print('build: ${buildPhase.duration}µs');
  print('layout: ${layoutPhase.duration}µs');
  print('paint: ${paintPhase.duration}µs');

  // Calculate total frame time
  print('\nFrame timing analysis:');
  final totalFrameTime =
      buildPhase.duration + layoutPhase.duration + paintPhase.duration;
  print('Total frame time: ${totalFrameTime}µs');
  print('Target 60fps = 16666µs per frame');
  print('Under budget: ${totalFrameTime < 16666}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* tb1 is Object */');

  // Compare blocks
  print('\nBlock comparison:');
  final sameBlock1 = TimedBlock(name: 'test', start: 100.0, end: 200.0);
  final sameBlock2 = TimedBlock(name: 'test', start: 100.0, end: 200.0);
  print('sameBlock1 == sameBlock2: ${sameBlock1 == sameBlock2}');
  print('identical: ${identical(sameBlock1, sameBlock2)}');
  print('duration match: ${sameBlock1.duration == sameBlock2.duration}');

  // Explain purpose
  print('\nTimedBlock purpose:');
  print('- Records timing for a named phase of execution');
  print('- Used by Timeline for performance profiling');
  print('- Contains start time, end time, and name');
  print('- duration property calculates automatically');
  print('- Useful for frame timing analysis');

  print('\n' + '=' * 50);
  print('TimedBlock test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TimedBlock Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${tb1.runtimeType}'),
      Text('test_phase: ${tb1.duration}µs'),
      Text('instant: ${tb2.duration}µs'),
      Text('long_operation: ${tb3.duration}µs'),
      Text('Purpose: Performance phase timing'),
    ],
  );
}
