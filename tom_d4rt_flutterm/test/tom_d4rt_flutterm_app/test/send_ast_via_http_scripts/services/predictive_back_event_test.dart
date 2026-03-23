// ignore_for_file: avoid_print
// D4rt test script: Tests PredictiveBackEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PredictiveBackEvent test executing');
  print('=' * 50);

  // PredictiveBackEvent is created by the system, not by user code
  // It's received via NavigatorObserver or PredictiveBackCallback
  print('\nPredictiveBackEvent overview:');
  print('- Created by system during Android 13+ predictive back gestures');
  print('- Received via callback, not instantiated directly');
  print('- Contains touchOffset, progress, and swipeEdge properties');

  // API overview
  print('\nPredictiveBackEvent properties:');
  print('- touchOffset: Offset? - current finger position');
  print('- progress: double - gesture completion 0.0 to 1.0');
  print('- swipeEdge: SwipeEdge - left or right edge origin');

  // SwipeEdge enum
  print('\nSwipeEdge enum values:');
  print('SwipeEdge.left: ${SwipeEdge.left}');
  print('SwipeEdge.right: ${SwipeEdge.right}');

  // Progress values interpretation
  print('\nProgress interpretation:');
  print('0.0 = gesture just started');
  print('0.5 = halfway through swipe');
  print('1.0 = gesture complete');

  // Usage example
  print('\nUsage example:');
  print('NavigatorObserver or PopScope callback:');
  print('  onBackGesture: (PredictiveBackEvent event) {');
  print('    print("Progress: \${event.progress}");');
  print('    print("Touch: \${event.touchOffset}");');
  print('    print("Edge: \${event.swipeEdge}");');
  print('  }');

  // Platform behavior
  print('\nPlatform behavior:');
  print('- Android 13+: Predictive back gestures');
  print('- iOS/other: Not applicable');
  print('- Web: May support in future');

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
      Text('Type: PredictiveBackEvent (system-created)'),
      Text('Properties: touchOffset, progress, swipeEdge'),
      Text('Platform: Android 13+'),
      Text('Purpose: Predictive back gesture data'),
    ],
  );
}
