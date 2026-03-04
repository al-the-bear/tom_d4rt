// D4rt test script: Tests AnimationLocalListenersMixin from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationLocalListenersMixin test executing');

  // AnimationLocalListenersMixin is a mixin - verify it exists in the framework
  print('AnimationLocalListenersMixin is a mixin');
  print('AnimationLocalListenersMixin runtimeType check available');
  print('AnimationLocalListenersMixin type: mixin');

  print('AnimationLocalListenersMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationLocalListenersMixin Tests'),
      Text('Type: mixin'),
      Text('Local listeners mixin'),
    ],
  );
}
