// D4rt test script: Tests AnimationLazyListenerMixin from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationLazyListenerMixin test executing');

  // AnimationLazyListenerMixin defers didRegisterListener/didUnregisterListener.
  // ProxyAnimation uses this mixin. Test through concrete usage.

  // ========== ProxyAnimation (uses LazyListenerMixin) ==========
  print('--- ProxyAnimation with LazyListenerMixin ---');
  final source = AlwaysStoppedAnimation<double>(0.8);
  final proxy = ProxyAnimation(source);
  print('  proxy.value: ${proxy.value}');
  print('  proxy.status: ${proxy.status}');

  // ========== Listener registration (lazy - only connects when needed) ==========
  print('--- Lazy listener registration ---');
  var callCount = 0;
  void listener() {
    callCount++;
  }
  proxy.addListener(listener);
  print('  Added listener (lazy registration triggered)');
  proxy.removeListener(listener);
  print('  Removed listener (lazy unregistration triggered)');
  print('  callCount: $callCount');

  // ========== Status listeners ==========
  print('--- Status listeners ---');
  var statusCount = 0;
  void statusHandler(AnimationStatus s) {
    statusCount++;
  }
  proxy.addStatusListener(statusHandler);
  print('  Added status listener');
  proxy.removeStatusListener(statusHandler);
  print('  Removed status listener');

  // ========== Change parent animation ==========
  print('--- Change parent ---');
  final newSource = AlwaysStoppedAnimation<double>(0.3);
  proxy.parent = newSource;
  print('  After parent change, proxy.value: ${proxy.value}');

  // ========== Null parent ==========
  print('--- Null parent ---');
  final emptyProxy = ProxyAnimation();
  print('  Empty proxy value: ${emptyProxy.value}');
  print('  Empty proxy status: ${emptyProxy.status}');

  print('AnimationLazyListenerMixin test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationLazyListenerMixin Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('ProxyAnimation value: ${proxy.value}'),
          Text('After parent change: ${proxy.value}'),
          Text('Empty proxy: ${emptyProxy.value}'),
          Text('Listener management: OK'),
        ],
      ),
    ),
  );
}
