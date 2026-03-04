// D4rt test script: Tests SchedulerServiceExtensions from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SchedulerServiceExtensions test executing');

  // Enumerate all SchedulerServiceExtensions values
  print('SchedulerServiceExtensions values:');
  for (final value in SchedulerServiceExtensions.values) {
    print('  ${value.name}: $value');
  }
  print('SchedulerServiceExtensions has ${ SchedulerServiceExtensions.values.length} values');

  final first = SchedulerServiceExtensions.values.first;
  final last = SchedulerServiceExtensions.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SchedulerServiceExtensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SchedulerServiceExtensions Tests'),
      Text('Values: ${ SchedulerServiceExtensions.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
