// D4rt test script: Tests AnimationWithParentMixin from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationWithParentMixin test executing');

  // AnimationWithParentMixin is used by classes like CurvedAnimation.
  // It delegates to a parent animation. Test through concrete usage.

  // ========== ProxyAnimation (uses parent mixin) ==========
  print('--- ProxyAnimation parent delegation ---');
  final parent = AlwaysStoppedAnimation<double>(0.6);
  final proxy = ProxyAnimation(parent);
  print('  parent.value: ${parent.value}');
  print('  proxy.value: ${proxy.value}');
  print('  proxy.status: ${proxy.status}');

  // ========== Change parent ==========
  print('--- Parent switching ---');
  final newParent = AlwaysStoppedAnimation<double>(0.2);
  proxy.parent = newParent;
  print('  After switch, proxy.value: ${proxy.value}');

  // ========== ReverseAnimation ==========
  print('--- ReverseAnimation (parent mixin) ---');
  final source = AlwaysStoppedAnimation<double>(0.3);
  final reverse = ReverseAnimation(source);
  print('  source.value: ${source.value}');
  print('  reverse.value: ${reverse.value}');
  print('  reverse.status: ${reverse.status}');

  // ========== Multiple levels of proxy ==========
  print('--- Nested proxy ---');
  final base = AlwaysStoppedAnimation<double>(0.9);
  final proxy1 = ProxyAnimation(base);
  final proxy2 = ProxyAnimation(proxy1);
  print('  base: ${base.value}');
  print('  proxy1: ${proxy1.value}');
  print('  proxy2: ${proxy2.value}');

  print('AnimationWithParentMixin test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('AnimationWithParentMixin Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Proxy delegates to parent: ${proxy.value}'),
          Text('ReverseAnimation(0.3): ${reverse.value}'),
          Text('Nested proxy: ${proxy2.value}'),
        ],
      ),
    ),
  );
}
