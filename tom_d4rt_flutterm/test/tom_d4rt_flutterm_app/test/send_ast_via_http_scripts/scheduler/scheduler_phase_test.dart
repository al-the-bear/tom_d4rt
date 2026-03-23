// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SchedulerPhase from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SchedulerPhase test executing');

  // Enumerate all SchedulerPhase values
  print('SchedulerPhase values:');
  for (final value in SchedulerPhase.values) {
    print('  ${value.name}: $value');
  }
  print('SchedulerPhase has ${SchedulerPhase.values.length} values');

  final first = SchedulerPhase.values.first;
  final last = SchedulerPhase.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SchedulerPhase test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SchedulerPhase Tests'),
      Text('Values: ${SchedulerPhase.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
