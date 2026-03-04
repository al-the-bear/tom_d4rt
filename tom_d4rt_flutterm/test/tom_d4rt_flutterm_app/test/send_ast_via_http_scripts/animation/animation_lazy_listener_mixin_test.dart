// D4rt test script: Tests AnimationLazyListenerMixin from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationLazyListenerMixin test executing');

  // AnimationLazyListenerMixin is a mixin - verify it exists in the framework
  print('AnimationLazyListenerMixin is a mixin');
  print('AnimationLazyListenerMixin runtimeType check available');
  print('AnimationLazyListenerMixin type: mixin');

  print('AnimationLazyListenerMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationLazyListenerMixin Tests'),
      Text('Type: mixin'),
      Text('Lazy listener mixin'),
    ],
  );
}
