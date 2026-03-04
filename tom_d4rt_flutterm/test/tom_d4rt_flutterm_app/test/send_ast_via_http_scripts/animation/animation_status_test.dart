// D4rt test script: Tests AnimationStatus enum, AnimationMax, AnimationMin,
// AnimationMean from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationStatus test executing');

  // ========== ANIMATIONSTATUS ==========
  print('--- AnimationStatus Tests ---');

  print('AnimationStatus.dismissed: ${AnimationStatus.dismissed}');
  print('AnimationStatus.forward: ${AnimationStatus.forward}');
  print('AnimationStatus.reverse: ${AnimationStatus.reverse}');
  print('AnimationStatus.completed: ${AnimationStatus.completed}');
  print('AnimationStatus.values: ${AnimationStatus.values}');
  print('AnimationStatus.values count: ${AnimationStatus.values.length}');

  // Test enum properties
  final dismissed = AnimationStatus.dismissed;
  print('dismissed.name: ${dismissed.name}');
  print('dismissed.index: ${dismissed.index}');

  final completed = AnimationStatus.completed;
  print('completed.name: ${completed.name}');
  print('completed.index: ${completed.index}');

  // Test isDismissed / isCompleted
  print('dismissed.isDismissed: ${dismissed.isDismissed}');
  print('dismissed.isCompleted: ${dismissed.isCompleted}');
  print('completed.isDismissed: ${completed.isDismissed}');
  print('completed.isCompleted: ${completed.isCompleted}');

  // ========== ANIMATIONMAX ==========
  print('--- AnimationMax Tests ---');

  // AnimationMax returns the max of two animations
  final anim1 = AlwaysStoppedAnimation<double>(0.3);
  final anim2 = AlwaysStoppedAnimation<double>(0.7);

  final animMax = AnimationMax<double>(anim1, anim2);
  print('AnimationMax(0.3, 0.7) created');
  print('AnimationMax.value: ${animMax.value}');
  print('AnimationMax.first: ${animMax.first.value}');
  print('AnimationMax.next: ${animMax.next.value}');

  // Test with different values
  final animMax2 = AnimationMax<double>(
    AlwaysStoppedAnimation<double>(0.9),
    AlwaysStoppedAnimation<double>(0.1),
  );
  print('AnimationMax(0.9, 0.1).value: ${animMax2.value}');

  // Test with equal values
  final animMaxEqual = AnimationMax<double>(
    AlwaysStoppedAnimation<double>(0.5),
    AlwaysStoppedAnimation<double>(0.5),
  );
  print('AnimationMax(0.5, 0.5).value: ${animMaxEqual.value}');

  // ========== ANIMATIONMIN ==========
  print('--- AnimationMin Tests ---');

  final animMin = AnimationMin<double>(anim1, anim2);
  print('AnimationMin(0.3, 0.7) created');
  print('AnimationMin.value: ${animMin.value}');
  print('AnimationMin.first: ${animMin.first.value}');
  print('AnimationMin.next: ${animMin.next.value}');

  final animMin2 = AnimationMin<double>(
    AlwaysStoppedAnimation<double>(0.9),
    AlwaysStoppedAnimation<double>(0.1),
  );
  print('AnimationMin(0.9, 0.1).value: ${animMin2.value}');

  // ========== ANIMATIONMEAN ==========
  print('--- AnimationMean Tests ---');

  final animMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.2),
    right: AlwaysStoppedAnimation<double>(0.8),
  );
  print('AnimationMean(0.2, 0.8) created');
  print('AnimationMean.value: ${animMean.value}');

  final animMean2 = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.0),
    right: AlwaysStoppedAnimation<double>(1.0),
  );
  print('AnimationMean(0.0, 1.0).value: ${animMean2.value}');

  final animMean3 = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.4),
    right: AlwaysStoppedAnimation<double>(0.4),
  );
  print('AnimationMean(0.4, 0.4).value: ${animMean3.value}');

  print('All AnimationStatus tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Animation Status Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('AnimationStatus values: ${AnimationStatus.values.length}'),
            SizedBox(height: 4.0),
            Text('AnimationMax(0.3, 0.7) = ${animMax.value}'),
            Text('AnimationMin(0.3, 0.7) = ${animMin.value}'),
            Text('AnimationMean(0.2, 0.8) = ${animMean.value}'),
          ],
        ),
      ),
    ),
  );
}
