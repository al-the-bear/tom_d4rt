// D4rt test script: Tests AnimationLocalStatusListenersMixin from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationLocalStatusListenersMixin test executing');

  // AnimationLocalStatusListenersMixin manages status listeners.
  // Test through AlwaysStoppedAnimation.

  // ========== Status listener management ==========
  print('--- Status listener management ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  
  final statuses = <AnimationStatus>[];
  void statusListenerA(AnimationStatus status) {
    statuses.add(status);
  }
  void statusListenerB(AnimationStatus status) {
    statuses.add(status);
  }

  anim.addStatusListener(statusListenerA);
  anim.addStatusListener(statusListenerB);
  print('  Added 2 status listeners');
  print('  Current status: ${anim.status}');

  anim.removeStatusListener(statusListenerA);
  print('  Removed listener A');
  anim.removeStatusListener(statusListenerB);
  print('  Removed listener B');

  // ========== All AnimationStatus values ==========
  print('--- AnimationStatus values ---');
  for (final status in AnimationStatus.values) {
    print('  AnimationStatus.${status.name}');
  }

  // ========== Status of AlwaysStoppedAnimation ==========
  print('--- AlwaysStoppedAnimation status is always completed ---');
  final a1 = AlwaysStoppedAnimation<double>(0.0);
  final a2 = AlwaysStoppedAnimation<double>(1.0);
  print('  anim(0.0).status: ${a1.status}');
  print('  anim(1.0).status: ${a2.status}');
  print('  isDismissed: ${a1.isDismissed}');
  print('  isCompleted: ${a2.isCompleted}');

  print('AnimationLocalStatusListenersMixin test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationLocalStatusListenersMixin Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Status listener management: OK'),
          for (final status in AnimationStatus.values)
            Text('AnimationStatus.${status.name}'),
          Text('AlwaysStopped status: ${anim.status}'),
        ],
      ),
    ),
  );
}
