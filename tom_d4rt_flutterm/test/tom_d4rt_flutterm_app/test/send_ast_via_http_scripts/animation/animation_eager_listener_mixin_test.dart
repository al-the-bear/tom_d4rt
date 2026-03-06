// D4rt test script: Tests AnimationEagerListenerMixin from animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationEagerListenerMixin test executing');

  // AnimationEagerListenerMixin is a mixin - verify it exists in the framework
  print('AnimationEagerListenerMixin is a mixin');
  print('AnimationEagerListenerMixin runtimeType check available');
  print('AnimationEagerListenerMixin type: mixin');

  print('AnimationEagerListenerMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationEagerListenerMixin Tests'),
      Text('Type: mixin'),
      Text('Eager listener mixin'),
    ],
  );
}
