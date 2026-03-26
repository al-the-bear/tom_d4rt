// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('Scheduler class smoke test executing');
  print('=' * 50);

  runCase('SchedulerPhase has expected values', () {
    return SchedulerPhase.values.contains(SchedulerPhase.idle) &&
        SchedulerPhase.values.contains(SchedulerPhase.persistentCallbacks);
  });

  runCase('Priority values are ordered', () {
    return Priority.idle.value < Priority.animation.value;
  });

  runCase('SchedulerBinding instance exists', () {
    return SchedulerBinding.instance.runtimeType.toString().isNotEmpty;
  });

  runCase('Current scheduler phase is valid enum', () {
    final SchedulerPhase phase = SchedulerBinding.instance.schedulerPhase;
    return SchedulerPhase.values.contains(phase);
  });

  runCase('FrameCallback typedef type exists', () {
    final Type t = FrameCallback;
    return t.toString().contains('FrameCallback');
  });

  runCase('SchedulingStrategy typedef type exists', () {
    final Type t = SchedulingStrategy;
    return t.toString().contains('SchedulingStrategy');
  });

  runCase('TaskCallback typedef type exists', () {
    final Type t = TaskCallback;
    return t.toString().contains('TaskCallback');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('Scheduler Class Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: SchedulerPhase values available'),
      const Text('Check: Priority ordering validated'),
      const Text('Check: SchedulerBinding.instance reachable'),
      const Text('Scheduler API checks completed'),
    ],
  );
}
