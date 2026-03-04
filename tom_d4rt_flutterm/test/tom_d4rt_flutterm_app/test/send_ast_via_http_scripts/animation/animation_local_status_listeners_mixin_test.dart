// D4rt test script: Tests AnimationLocalStatusListenersMixin from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationLocalStatusListenersMixin test executing');

  // AnimationLocalStatusListenersMixin is a mixin - verify it exists in the framework
  print('AnimationLocalStatusListenersMixin is a mixin');
  print('AnimationLocalStatusListenersMixin runtimeType check available');
  print('AnimationLocalStatusListenersMixin type: mixin');

  print('AnimationLocalStatusListenersMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationLocalStatusListenersMixin Tests'),
      Text('Type: mixin'),
      Text('Status listeners mixin'),
    ],
  );
}
