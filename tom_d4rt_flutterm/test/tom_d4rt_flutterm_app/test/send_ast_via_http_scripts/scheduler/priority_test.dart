// ignore_for_file: avoid_print
// D4rt test script: Tests Priority from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Priority test executing');
  print('=' * 50);

  // Priority class for task scheduling
  print('\nPriority:');
  print('Defines task execution priority');
  print('Used with scheduleTask()');

  // Static constants
  print('\nPriority constants:');
  print('idle: ${Priority.idle.value}');
  print('animation: ${Priority.animation.value}');
  print('touch: ${Priority.touch.value}');
  print('kMaxOffset: ${Priority.kMaxOffset}');

  // Priority descriptions
  print('\nPriority descriptions:');
  print('');
  print('idle (${Priority.idle.value}):');
  print('  - Lowest priority');
  print('  - Background tasks');
  print('  - When nothing else needs CPU');
  print('');
  print('animation (${Priority.animation.value}):');
  print('  - Animation frame work');
  print('  - Smooth 60fps priority');
  print('');
  print('touch (${Priority.touch.value}):');
  print('  - Highest priority');
  print('  - User input response');
  print('  - Touch/pointer handling');

  // offset operator
  print('\noffset operator (+):');
  final custom = Priority.animation + 10;
  print('Priority.animation + 10: ${custom.value}');
  print('Used for fine-grained ordering');

  // Usage with scheduleTask
  print('\nUsage with scheduleTask:');
  print('SchedulerBinding.instance.scheduleTask(');
  print('  () {');
  print('    // Task code');
  print('  },');
  print('  Priority.animation,');
  print(');');

  // Comparison
  print('\nPriority comparison:');
  print('Higher value = higher priority');
  print('touch > animation > idle');
  print('Tasks sorted by priority');

  // Use cases
  print('\nUse cases:');
  print('- idle: Prefetching, analytics');
  print('- animation: Frame callbacks');
  print('- touch: Input processing');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Priority (class)');
  print('  \u251c\u2500 idle (static const)');
  print('  \u251c\u2500 animation (static const)');
  print('  \u2514\u2500 touch (static const)');

  // Explain purpose
  print('\nPriority purpose:');
  print('- Task execution ordering');
  print('- value property for comparison');
  print('- + operator for offsets');
  print('- idle, animation, touch levels');
  print('- Used by scheduleTask()');

  print('\n' + '=' * 50);
  print('Priority test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Priority Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('idle: ${Priority.idle.value}'),
      Text('animation: ${Priority.animation.value}'),
      Text('touch: ${Priority.touch.value}'),
      Text('Purpose: Task scheduling'),
    ],
  );
}
