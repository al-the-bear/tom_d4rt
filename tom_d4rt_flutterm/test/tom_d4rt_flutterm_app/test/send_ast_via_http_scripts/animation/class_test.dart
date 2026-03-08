// D4rt test script: Tests Animation class hierarchy from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Animation class hierarchy test executing');

  // ========== AlwaysStoppedAnimation ==========
  print('--- AlwaysStoppedAnimation ---');
  final stopped = AlwaysStoppedAnimation<double>(0.75);
  print('  value: ${stopped.value}');
  print('  status: ${stopped.status}');
  print('  isCompleted: ${stopped.isCompleted}');
  print('  isDismissed: ${stopped.isDismissed}');
  print('  toString: ${stopped.toString()}');

  // ========== ProxyAnimation ==========
  print('--- ProxyAnimation ---');
  final proxy = ProxyAnimation(stopped);
  print('  proxy.value: ${proxy.value}');
  print('  proxy.status: ${proxy.status}');

  // ========== ReverseAnimation ==========
  print('--- ReverseAnimation ---');
  final reverse = ReverseAnimation(stopped);
  print('  reverse.value: ${reverse.value}');
  print('  reverse.status: ${reverse.status}');

  // ========== AnimationStatus enum ==========
  print('--- AnimationStatus enum ---');
  for (final status in AnimationStatus.values) {
    print('  ${status.name}: index=${status.index}');
  }

  // ========== Type checks ==========
  print('--- Type checks ---');
  print('  stopped is Animation<double>: ${stopped is Animation<double>}');
  print('  proxy is Animation<double>: ${proxy is Animation<double>}');

  print('Animation class hierarchy test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Animation Class Hierarchy',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('AlwaysStoppedAnimation(0.75): ${stopped.value}'),
          Text('ProxyAnimation: ${proxy.value}'),
          Text('ReverseAnimation: ${reverse.value}'),
          SizedBox(height: 8.0),
          Text('AnimationStatus values:'),
          for (final status in AnimationStatus.values)
            Text('  ${status.name}'),
        ],
      ),
    ),
  );
}
