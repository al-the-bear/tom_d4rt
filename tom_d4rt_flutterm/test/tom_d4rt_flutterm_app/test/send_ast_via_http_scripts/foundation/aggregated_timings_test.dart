// ignore_for_file: avoid_print
// D4rt test script: Tests AggregatedTimings from foundation
// NOTE: Bridge bug - AggregatedTimedBlock cannot be cast to TimedBlock
// when passing to AggregatedTimings constructor. Testing with empty list.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AggregatedTimings test executing');

  // Test AggregatedTimings with empty list to avoid bridge cast bug
  final timings = AggregatedTimings([]);
  print('AggregatedTimings created');
  print('timedBlocks count: ${timings.timedBlocks.length}');

  // Test AggregatedTimedBlock separately
  final block1 = AggregatedTimedBlock(
    name: 'build',
    duration: 2000.0,
    count: 3,
  );
  final block2 = AggregatedTimedBlock(
    name: 'layout',
    duration: 1500.0,
    count: 2,
  );
  print('block1 name: ${block1.name}');
  print('block1 duration: ${block1.duration}');
  print('block1 count: ${block1.count}');
  print('block2 name: ${block2.name}');

  print('AggregatedTimings test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AggregatedTimings Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Empty timings: ${timings.timedBlocks.length}'),
      Text('block1: ${block1.name} ${block1.duration}'),
    ],
  );
}
