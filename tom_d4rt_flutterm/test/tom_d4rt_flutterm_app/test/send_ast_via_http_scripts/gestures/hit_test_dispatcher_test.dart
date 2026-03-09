// D4rt test script: Tests HitTestDispatcher from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HitTestDispatcher test executing');

  // HitTestDispatcher is an interface implemented by GestureBinding
  final binding = GestureBinding.instance;
  print('GestureBinding is HitTestDispatcher: ${binding is HitTestDispatcher}');
  print('GestureBinding type: ${binding.runtimeType}');

  print('HitTestDispatcher test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('HitTestDispatcher Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Interface for dispatching hit test events'),
    Text('Implemented by GestureBinding'),
  ]);
}
