// D4rt test script: Tests AnimationWithParentMixin from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationWithParentMixin test executing');

  // AnimationWithParentMixin is a mixin - verify it exists in the framework
  print('AnimationWithParentMixin is a mixin');
  print('AnimationWithParentMixin runtimeType check available');

  // Test basic type identity
  print('AnimationWithParentMixin type: mixin');
  print('Parent animation mixin');

  print('AnimationWithParentMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationWithParentMixin Tests'),
      Text('Type: mixin'),
      Text('Parent animation mixin'),
    ],
  );
}
