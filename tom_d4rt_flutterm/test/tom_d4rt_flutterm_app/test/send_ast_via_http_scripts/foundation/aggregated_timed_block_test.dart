// D4rt test script: Tests AggregatedTimedBlock from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AggregatedTimedBlock test executing');
  print('=' * 50);

  // Create basic AggregatedTimedBlock
  final block1 = AggregatedTimedBlock(
    name: 'build',
    duration: 1500.0,
    count: 5,
  );
  print('\nAggregatedTimedBlock created:');
  print('runtimeType: ${block1.runtimeType}');
  print('name: ${block1.name}');
  print('duration: ${block1.duration}');
  print('count: ${block1.count}');

  // Calculate average duration
  print('\nAverage duration:');
  final avgDuration = block1.duration / block1.count;
  print('total duration: ${block1.duration}µs');
  print('count: ${block1.count}');
  print('average: $avgDurationµs per execution');

  // Create with high count
  final highCount = AggregatedTimedBlock(
    name: 'layout',
    duration: 32000.0,
    count: 100,
  );
  print('\nHigh count block:');
  print('name: ${highCount.name}');
  print('duration: ${highCount.duration}');
  print('count: ${highCount.count}');
  print('average: ${highCount.duration / highCount.count}µs');

  // Create with single execution
  final singleExec = AggregatedTimedBlock(
    name: 'paint',
    duration: 8000.0,
    count: 1,
  );
  print('\nSingle execution:');
  print('name: ${singleExec.name}');
  print('count: ${singleExec.count}');
  print(
    'duration == average: ${singleExec.duration / singleExec.count == singleExec.duration}',
  );

  // Create with zero duration
  final zeroDuration = AggregatedTimedBlock(
    name: 'noop',
    duration: 0.0,
    count: 10,
  );
  print('\nZero duration:');
  print('name: ${zeroDuration.name}');
  print('duration: ${zeroDuration.duration}');
  print('count: ${zeroDuration.count}');

  // Common phase names
  print('\nCommon aggregated phases:');
  final phases = [
    AggregatedTimedBlock(name: 'build', duration: 5000.0, count: 10),
    AggregatedTimedBlock(name: 'layout', duration: 3000.0, count: 10),
    AggregatedTimedBlock(name: 'compositingBits', duration: 500.0, count: 10),
    AggregatedTimedBlock(name: 'paint', duration: 4000.0, count: 10),
    AggregatedTimedBlock(name: 'compositing', duration: 1000.0, count: 10),
  ];
  double totalPhaseTime = 0;
  for (final phase in phases) {
    print(
      '${phase.name}: ${phase.duration}µs (avg: ${phase.duration / phase.count}µs)',
    );
    totalPhaseTime += phase.duration;
  }
  print('Total frame time: $totalPhaseTimeµs');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: ${block1 is Object}');

  // Compare blocks
  print('\nBlock comparison:');
  final same1 = AggregatedTimedBlock(name: 'test', duration: 100.0, count: 1);
  final same2 = AggregatedTimedBlock(name: 'test', duration: 100.0, count: 1);
  print('same1 == same2: ${same1 == same2}');
  print('identical: ${identical(same1, same2)}');
  print('same name: ${same1.name == same2.name}');
  print('same duration: ${same1.duration == same2.duration}');

  // Explain purpose
  print('\nAggregatedTimedBlock purpose:');
  print('- Aggregates multiple TimedBlock executions');
  print('- Used for performance profiling summaries');
  print('- Contains name, total duration, and count');
  print('- Enables average calculation per execution');
  print('- Part of AggregatedTimings system');

  print('\n' + '=' * 50);
  print('AggregatedTimedBlock test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AggregatedTimedBlock Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${block1.runtimeType}'),
      Text('build: ${block1.duration}µs x${block1.count}'),
      Text('layout: ${highCount.duration}µs x${highCount.count}'),
      Text('avg: ${highCount.duration / highCount.count}µs'),
      Text('Purpose: Aggregated performance timing'),
    ],
  );
}
