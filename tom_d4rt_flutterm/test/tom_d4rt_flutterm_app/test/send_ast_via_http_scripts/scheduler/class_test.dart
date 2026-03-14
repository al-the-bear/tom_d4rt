// D4rt test script: Tests SchedulerBinding from scheduler
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SchedulerBinding test executing');
  print('=' * 50);

  // SchedulerBinding for frame scheduling
  print('\nSchedulerBinding:');
  print('Manages frame scheduling and callbacks');
  print('Controls animation frame timing');

  // Access instance
  print('\nAccess:');
  print('SchedulerBinding.instance');

  // schedulerPhase
  print('\nSchedulerPhase values:');
  print('idle: ${SchedulerPhase.idle.index}');
  print('transientCallbacks: ${SchedulerPhase.transientCallbacks.index}');
  print('midFrameMicrotasks: ${SchedulerPhase.midFrameMicrotasks.index}');
  print('persistentCallbacks: ${SchedulerPhase.persistentCallbacks.index}');
  print('postFrameCallbacks: ${SchedulerPhase.postFrameCallbacks.index}');

  // Callback phases
  print('\nCallback phases:');
  print('1. transientCallbacks - Animation ticks');
  print('2. midFrameMicrotasks - Microtasks');
  print('3. persistentCallbacks - Build/layout');
  print('4. postFrameCallbacks - After frame');

  // Key methods
  print('\nKey methods:');
  print('scheduleFrameCallback(callback)');
  print('addPersistentFrameCallback(callback)');
  print('addPostFrameCallback(callback)');
  print('scheduleTask(task, priority)');
  print('scheduleForcedFrame()');

  // FrameCallback typedef
  print('\nFrameCallback typedef:');
  print('void Function(Duration timeStamp)');

  // TimingsCallback typedef
  print('\nTimingsCallback typedef:');
  print('void Function(List<FrameTiming>)');

  // Frame timing
  print('\nFrame timing:');
  print('currentFrameTimeStamp - Current frame time');
  print('currentSystemFrameTimeStamp - System time');

  // Lifecycle state
  print('\nLifecycle state:');
  print('lifecycleState - AppLifecycleState');
  print('framesEnabled - Whether frames scheduled');

  // Type hierarchy
  print('\nType hierarchy:');
  print('BindingBase');
  print('  \u2514\u2500 SchedulerBinding (mixin)');
  print('       \u2514\u2500 WidgetsBinding');

  // Explain purpose
  print('\nSchedulerBinding purpose:');
  print('- Frame scheduling');
  print('- Animation timing');
  print('- Callback management');
  print('- Task scheduling');
  print('- Frame phase control');

  print('\n' + '=' * 50);
  print('SchedulerBinding test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SchedulerBinding Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Phases: ${SchedulerPhase.values.length}'),
      Text('idle phase: ${SchedulerPhase.idle.index}'),
      Text('Key: scheduleFrameCallback'),
      Text('Purpose: Frame scheduling'),
    ],
  );
}
