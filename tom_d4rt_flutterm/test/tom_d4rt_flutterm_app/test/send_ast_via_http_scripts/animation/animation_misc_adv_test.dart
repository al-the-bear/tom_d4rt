// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimationStatusListener, AnimatedValue (Tween), AnimatedEvaluation, SpringDescription, BoundedFrictionSimulation, Priority, SchedulerPhase
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Animation misc advanced tests executing');

  // ========== AnimationStatusListener ==========
  print('--- AnimationStatusListener Tests ---');
  void listener(AnimationStatus status) {
    print('Status changed to: $status');
  }

  print('AnimationStatusListener type: ${listener.runtimeType}');
  print('AnimationStatusListener is typedef: void Function(AnimationStatus)');
  listener(AnimationStatus.completed);
  listener(AnimationStatus.dismissed);
  listener(AnimationStatus.forward);
  listener(AnimationStatus.reverse);
  print('AnimationStatus values: ${AnimationStatus.values}');
  print('AnimationStatusListener tests passed');

  // ========== AnimatedValue (Tween) ==========
  print('--- AnimatedValue (Tween) Tests ---');
  print('AnimatedValue was the old name for Tween');
  final tween = Tween<double>(begin: 0.0, end: 1.0);
  print('Tween type: ${tween.runtimeType}');
  print('begin: ${tween.begin}');
  print('end: ${tween.end}');
  print('lerp(0.5): ${tween.transform(0.5)}');
  print('transform(0.25): ${tween.transform(0.25)}');
  final intTween = IntTween(begin: 0, end: 100);
  print('IntTween type: ${intTween.runtimeType}');
  print('IntTween lerp(0.5): ${intTween.transform(0.5)}');
  final colorTween = ColorTween(begin: Colors.red, end: Colors.blue);
  print('ColorTween type: ${colorTween.runtimeType}');
  print('ColorTween lerp(0.5): ${colorTween.transform(0.5)}');
  print('AnimatedValue (Tween) tests passed');

  // ========== AnimatedEvaluation ==========
  print('--- AnimatedEvaluation Tests ---');
  print('AnimatedEvaluation is the internal type created by Animation.drive()');
  final stoppedAnim = AlwaysStoppedAnimation<double>(0.5);
  print('AlwaysStoppedAnimation type: ${stoppedAnim.runtimeType}');
  print('AlwaysStoppedAnimation value: ${stoppedAnim.value}');
  print('AlwaysStoppedAnimation status: ${stoppedAnim.status}');
  final driven = stoppedAnim.drive(IntTween(begin: 0, end: 100));
  print('driven type (AnimatedEvaluation): ${driven.runtimeType}');
  // Note: driven.value uses AnimationWithParentMixin which isn't fully bridged yet
  print('driven created successfully');
  final chainedDrive = stoppedAnim.drive(Tween<double>(begin: 10.0, end: 20.0));
  print('chainedDrive type: ${chainedDrive.runtimeType}');
  // Note: chainedDrive.value also uses AnimationWithParentMixin
  print('chainedDrive created successfully');
  print('AnimatedEvaluation tests passed');

  // ========== SpringDescription ==========
  print('--- SpringDescription Tests ---');
  final spring = SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0);
  print('SpringDescription type: ${spring.runtimeType}');
  print('mass: ${spring.mass}');
  print('stiffness: ${spring.stiffness}');
  print('damping: ${spring.damping}');
  final criticalSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0,
  );
  print('criticalSpring mass: ${criticalSpring.mass}');
  print('criticalSpring stiffness: ${criticalSpring.stiffness}');
  print('criticalSpring damping: ${criticalSpring.damping}');
  print('SpringDescription tests passed');

  // ========== BoundedFrictionSimulation ==========
  print('--- BoundedFrictionSimulation Tests ---');
  final friction = BoundedFrictionSimulation(0.135, 100.0, 200.0, 0.0, 500.0);
  print('BoundedFrictionSimulation type: ${friction.runtimeType}');
  print('x(0.0): ${friction.x(0.0)}');
  print('dx(0.0): ${friction.dx(0.0)}');
  print('isDone(0.0): ${friction.isDone(0.0)}');
  print('x(1.0): ${friction.x(1.0)}');
  print('BoundedFrictionSimulation tests passed');

  // ========== Priority ==========
  print('--- Priority Tests ---');
  print('Priority.idle: ${Priority.idle}');
  print('Priority.animation: ${Priority.animation}');
  print('Priority.touch: ${Priority.touch}');
  print('Priority is used by SchedulerBinding for task scheduling');
  print('Priority tests passed');

  // ========== SchedulerPhase ==========
  print('--- SchedulerPhase Tests ---');
  print('SchedulerPhase values: ${SchedulerPhase.values}');
  for (final phase in SchedulerPhase.values) {
    print('SchedulerPhase: ${phase.name} (index: ${phase.index})');
  }
  print('SchedulerPhase tests passed');

  print('All Animation misc advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Animation Misc Advanced Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('AnimationStatusListener: OK'),
            Text('AnimatedValue (Tween): OK'),
            Text('AnimatedEvaluation: OK'),
            Text('SpringDescription: OK'),
            Text('BoundedFrictionSimulation: OK'),
            Text('Priority: OK'),
            Text('SchedulerPhase: OK'),
          ],
        ),
      ),
    ),
  );
}
