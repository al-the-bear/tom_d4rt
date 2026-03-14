// D4rt test script: Tests PredictiveBackEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PredictiveBackEvent test executing');
  print('=' * 50);

  // Create PredictiveBackEvent with basic parameters
  final event1 = PredictiveBackEvent(
    touchOffset: Offset(100, 200),
    progress: 0.5,
    swipeEdge: SwipeEdge.left,
  );
  print('\nPredictiveBackEvent created:');
  print('runtimeType: ${event1.runtimeType}');
  print('touchOffset: ${event1.touchOffset}');
  print('progress: ${event1.progress}');
  print('swipeEdge: ${event1.swipeEdge}');

  // Create with right edge swipe
  final rightSwipe = PredictiveBackEvent(
    touchOffset: Offset(350, 300),
    progress: 0.75,
    swipeEdge: SwipeEdge.right,
  );
  print('\nRight edge swipe:');
  print('touchOffset: ${rightSwipe.touchOffset}');
  print('progress: ${rightSwipe.progress}');
  print('swipeEdge: ${rightSwipe.swipeEdge}');

  // Create at start of gesture (progress = 0)
  final startEvent = PredictiveBackEvent(
    touchOffset: Offset(0, 100),
    progress: 0.0,
    swipeEdge: SwipeEdge.left,
  );
  print('\nGesture start:');
  print('progress: ${startEvent.progress}');
  print('touchOffset.dx: ${startEvent.touchOffset?.dx}');

  // Create at end of gesture (progress = 1)
  final endEvent = PredictiveBackEvent(
    touchOffset: Offset(200, 100),
    progress: 1.0,
    swipeEdge: SwipeEdge.left,
  );
  print('\nGesture end:');
  print('progress: ${endEvent.progress}');
  print('touchOffset.dx: ${endEvent.touchOffset?.dx}');

  // Create with null touchOffset
  final noOffset = PredictiveBackEvent(
    touchOffset: null,
    progress: 0.3,
    swipeEdge: SwipeEdge.left,
  );
  print('\nWith null touchOffset:');
  print('touchOffset: ${noOffset.touchOffset}');
  print('progress: ${noOffset.progress}');

  // Test SwipeEdge enum
  print('\nSwipeEdge enum values:');
  print('SwipeEdge.left: ${SwipeEdge.left}');
  print('SwipeEdge.right: ${SwipeEdge.right}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: ${event1 is Object}');

  // Progress values interpretation
  print('\nProgress interpretation:');
  print('0.0 = gesture just started');
  print('0.5 = halfway through swipe');
  print('1.0 = gesture complete');
  print('Current progress: ${event1.progress}');

  // Compare events
  print('\nEvent comparison:');
  final same1 = PredictiveBackEvent(
    touchOffset: Offset(10, 10),
    progress: 0.2,
    swipeEdge: SwipeEdge.left,
  );
  final same2 = PredictiveBackEvent(
    touchOffset: Offset(10, 10),
    progress: 0.2,
    swipeEdge: SwipeEdge.left,
  );
  print('same1 == same2: ${same1 == same2}');

  // Explain purpose
  print('\nPredictiveBackEvent purpose:');
  print('- Android 13+ predictive back gesture data');
  print('- touchOffset: current finger position');
  print('- progress: 0.0 to 1.0 gesture completion');
  print('- swipeEdge: left or right edge origin');
  print('- Used with PopScope and predictive back');
  print('- Enables animated back navigation preview');

  print('\n' + '=' * 50);
  print('PredictiveBackEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PredictiveBackEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${event1.runtimeType}'),
      Text('touchOffset: ${event1.touchOffset}'),
      Text('progress: ${event1.progress}'),
      Text('swipeEdge: ${event1.swipeEdge}'),
      Text('Purpose: Predictive back gesture'),
    ],
  );
}
