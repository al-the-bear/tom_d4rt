// D4rt test script: Tests HitTestDispatcher from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HitTestDispatcher test executing');

  // HitTestDispatcher is an interface implemented by GestureBinding
  final binding = GestureBinding.instance;
  print('GestureBinding.instance: ${binding.runtimeType}');
  print('is HitTestDispatcher: ${binding is HitTestDispatcher}');

  // Test HitTestDispatcher interface
  print('\nHitTestDispatcher interface:');
  print('- dispatchEvent(PointerEvent event, HitTestResult result)');
  print('- Used to route pointer events to hit targets');

  // Test hit test result creation
  print('\nHitTestResult:');
  final hitTestResult = HitTestResult();
  print('Created HitTestResult: ${hitTestResult.runtimeType}');
  print('path (entries): ${hitTestResult.path.length}');

  // Test BoxHitTestResult
  print('\nBoxHitTestResult (subtype):');
  final boxResult = BoxHitTestResult();
  print('BoxHitTestResult: ${boxResult.runtimeType}');

  // Explain purpose
  print('\nHitTestDispatcher purpose:');
  print('- Interface for dispatching pointer events');
  print('- Routes events to hit test targets');
  print('- Implemented by GestureBinding');
  print('- Part of Flutter\'s gesture recognition system');

  // Hit testing flow
  print('\nHit testing flow:');
  print('1. Pointer event received');
  print('2. hitTest() called on render tree');
  print('3. HitTestResult populated with targets');
  print('4. dispatchEvent() routes to targets');
  print('5. Gesture recognizers process event');

  print('\nHitTestDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'HitTestDispatcher Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Interface for dispatching hit test events'),
      Text('Implemented by: GestureBinding'),
      Text('Method: dispatchEvent(event, result)'),
      Text('Routes pointer events to targets'),
    ],
  );
}
