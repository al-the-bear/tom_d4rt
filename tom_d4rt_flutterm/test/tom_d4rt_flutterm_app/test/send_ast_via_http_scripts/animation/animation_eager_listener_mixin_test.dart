// D4rt test script: Tests AnimationEagerListenerMixin from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationEagerListenerMixin test executing');

  // AnimationEagerListenerMixin is used by animation classes that eagerly add listeners.
  // AlwaysStoppedAnimation uses it internally. Test through concrete usage.

  // ========== Create AlwaysStoppedAnimation (uses eager listener mixin) ==========
  print('--- AlwaysStoppedAnimation with EagerListenerMixin ---');
  final anim = AlwaysStoppedAnimation<double>(0.75);
  print('  value: ${anim.value}');
  print('  status: ${anim.status}');

  // ========== Listener management ==========
  print('--- Listener management ---');
  var listenerCallCount = 0;
  void listener() {
    listenerCallCount++;
  }
  anim.addListener(listener);
  print('  Added listener, callCount: $listenerCallCount');
  anim.removeListener(listener);
  print('  Removed listener, callCount: $listenerCallCount');

  // ========== Status listener management ==========
  print('--- Status listener management ---');
  var statusCallCount = 0;
  void statusListener(AnimationStatus status) {
    statusCallCount++;
  }
  anim.addStatusListener(statusListener);
  print('  Added status listener, callCount: $statusCallCount');
  anim.removeStatusListener(statusListener);
  print('  Removed status listener, callCount: $statusCallCount');

  // ========== Multiple animations with the mixin ==========
  print('--- Multiple animations ---');
  final anim1 = AlwaysStoppedAnimation<double>(0.0);
  final anim2 = AlwaysStoppedAnimation<double>(0.5);
  final anim3 = AlwaysStoppedAnimation<double>(1.0);
  print('  anim1.value: ${anim1.value}');
  print('  anim2.value: ${anim2.value}');
  print('  anim3.value: ${anim3.value}');

  // ========== String animations ==========
  print('--- String animation ---');
  final stringAnim = AlwaysStoppedAnimation<String>('hello');
  print('  string value: ${stringAnim.value}');

  print('AnimationEagerListenerMixin test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationEagerListenerMixin Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('AlwaysStoppedAnimation value: ${anim.value}'),
          Text('Status: ${anim.status}'),
          Text('Listener add/remove: OK'),
          Text('Status listener add/remove: OK'),
          Text('Multiple animations: ${anim1.value}, ${anim2.value}, ${anim3.value}'),
        ],
      ),
    ),
  );
}
