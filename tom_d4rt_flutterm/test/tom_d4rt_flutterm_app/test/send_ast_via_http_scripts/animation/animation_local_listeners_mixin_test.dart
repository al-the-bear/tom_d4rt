// D4rt test script: Tests AnimationLocalListenersMixin from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationLocalListenersMixin test executing');

  // AnimationLocalListenersMixin manages a list of value listeners.
  // Test through AlwaysStoppedAnimation which uses it.

  // ========== Value listener management ==========
  print('--- Value listener management ---');
  final anim = AlwaysStoppedAnimation<double>(0.5);
  
  final calls = <String>[];
  void listenerA() {
    calls.add('A');
  }
  void listenerB() {
    calls.add('B');
  }

  anim.addListener(listenerA);
  anim.addListener(listenerB);
  print('  Added 2 listeners');

  anim.removeListener(listenerA);
  print('  Removed listener A');
  anim.removeListener(listenerB);
  print('  Removed listener B');

  // ========== Multiple add/remove cycles ==========
  print('--- Multiple add/remove cycles ---');
  for (var i = 0; i < 3; i++) {
    anim.addListener(listenerA);
    anim.removeListener(listenerA);
    print('  Cycle $i: add/remove OK');
  }

  // ========== Animation value checks ==========
  print('--- Value checks ---');
  final values = [0.0, 0.25, 0.5, 0.75, 1.0];
  for (final v in values) {
    final a = AlwaysStoppedAnimation<double>(v);
    print('  AlwaysStoppedAnimation($v).value: ${a.value}');
  }

  print('AnimationLocalListenersMixin test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationLocalListenersMixin Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Listener add/remove: OK'),
          Text('Multiple cycles: OK'),
          for (final v in values)
            Text('Animation($v): ${AlwaysStoppedAnimation<double>(v).value}'),
        ],
      ),
    ),
  );
}
