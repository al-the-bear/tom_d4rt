// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Priority, SchedulerPhase from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scheduler misc test executing');

  // ========== SCHEDULERPHASE ==========
  print('--- SchedulerPhase Tests ---');

  print('SchedulerPhase.idle: ${SchedulerPhase.idle}');
  print(
    'SchedulerPhase.transientCallbacks: ${SchedulerPhase.transientCallbacks}',
  );
  print(
    'SchedulerPhase.midFrameMicrotasks: ${SchedulerPhase.midFrameMicrotasks}',
  );
  print(
    'SchedulerPhase.persistentCallbacks: ${SchedulerPhase.persistentCallbacks}',
  );
  print(
    'SchedulerPhase.postFrameCallbacks: ${SchedulerPhase.postFrameCallbacks}',
  );
  print('SchedulerPhase.values count: ${SchedulerPhase.values.length}');

  // Test enum names and indices
  print('idle.name: ${SchedulerPhase.idle.name}');
  print('idle.index: ${SchedulerPhase.idle.index}');
  print('transientCallbacks.index: ${SchedulerPhase.transientCallbacks.index}');
  print(
    'persistentCallbacks.index: ${SchedulerPhase.persistentCallbacks.index}',
  );

  // Get current scheduler phase
  final binding = SchedulerBinding.instance;
  print('Current schedulerPhase: ${binding.schedulerPhase}');

  // ========== PRIORITY ==========
  print('--- Priority Tests ---');

  // Priority class defines scheduler task priorities
  print('Priority.idle: ${Priority.idle}');
  print('Priority.animation: ${Priority.animation}');
  print('Priority.touch: ${Priority.touch}');
  print('Priority.kMaxOffset: ${Priority.kMaxOffset}');

  // Test priority values
  final idlePriority = Priority.idle;
  print('idle.value: ${idlePriority.value}');

  final animPriority = Priority.animation;
  print('animation.value: ${animPriority.value}');

  final touchPriority = Priority.touch;
  print('touch.value: ${touchPriority.value}');

  // Test priority arithmetic (+ operator)
  final offsetPriority = Priority.idle + 100;
  print('Priority.idle + 100: ${offsetPriority.value}');

  final negOffset = Priority.animation + (-50);
  print('Priority.animation + (-50): ${negOffset.value}');

  // Priority comparison (higher value = higher priority)
  print('touch > animation: ${touchPriority.value > animPriority.value}');
  print('animation > idle: ${animPriority.value > idlePriority.value}');

  print('All scheduler misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduler Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('SchedulerPhase values: ${SchedulerPhase.values.length}'),
            Text('Current phase: ${binding.schedulerPhase}'),
            SizedBox(height: 8.0),
            Text('Priority.idle: ${idlePriority.value}'),
            Text('Priority.animation: ${animPriority.value}'),
            Text('Priority.touch: ${touchPriority.value}'),
          ],
        ),
      ),
    ),
  );
}
