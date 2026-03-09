// D4rt test script: Tests AggregatedTimedBlock from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AggregatedTimedBlock test executing');

  final block = AggregatedTimedBlock(name: 'test_block', duration: 1500.0, count: 5);
  print('AggregatedTimedBlock name: ${block.name}');
  print('duration: ${block.duration}');
  print('count: ${block.count}');

  final block2 = AggregatedTimedBlock(name: 'render', duration: 3200.5, count: 10);
  print('block2 name: ${block2.name}');
  print('block2 duration: ${block2.duration}');
  print('block2 count: ${block2.count}');

  print('AggregatedTimedBlock test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('AggregatedTimedBlock Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('test_block duration: ${block.duration}'),
    Text('render count: ${block2.count}'),
  ]);
}
