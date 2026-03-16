// D4rt test script: Tests TimedBlock from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimedBlock test executing');

  final tb = TimedBlock(name: 'test_phase', start: 1000.0, end: 2500.0);
  print('TimedBlock: name=${tb.name}, start=${tb.start}, end=${tb.end}');
  print('duration: ${tb.duration}');

  final tb2 = TimedBlock(name: 'render', start: 0.0, end: 500.0);
  print('tb2: duration=${tb2.duration}');

  print('TimedBlock test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('TimedBlock Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('test_phase: ${tb.duration}'),
    Text('render: ${tb2.duration}'),
  ]);
}
