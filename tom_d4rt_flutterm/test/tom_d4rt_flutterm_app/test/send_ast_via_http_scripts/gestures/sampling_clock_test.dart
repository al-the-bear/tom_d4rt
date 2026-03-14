// D4rt test script: Tests SamplingClock from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SamplingClock test executing');

  // SamplingClock provides time for input resampling
  // Default implementation uses system clock
  print('SamplingClock: Interface for resampling time source');
  print('Type: ${SamplingClock}');

  // Get default/system clock via GestureBinding
  print('\nDefault clock usage:');
  print('- GestureBinding.samplingClock');
  print('- Returns system SamplingClock by default');

  // Interface definition
  print('\nSamplingClock interface:');
  print('- now(): Returns current Duration timestamp');
  print('- Used by PointerEventResampler');
  print('- Called during event resampling');

  // Create simple mock for demonstration
  print('\nSamplingClock purpose:');
  print('- Provides consistent time source');
  print('- Used for input event resampling');
  print('- Allows testing with mock time');
  print('- Enables deterministic playback');

  // Usage in gesture system
  print('\nUsage in gesture system:');
  print('1. Pointer events arrive with timestamps');
  print('2. Resampler needs current time');
  print('3. SamplingClock.now() provides time');
  print('4. Events resampled to frame boundaries');

  // Testing considerations
  print('\nTesting implications:');
  print('- Can inject custom SamplingClock');
  print('- Allows time-based gesture testing');
  print('- Makes tests deterministic');
  print('- Avoids flaky timing-dependent tests');

  print('\nSamplingClock test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SamplingClock Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Interface for resampling time'),
      Text('Method: now() -> Duration'),
      Text('Used by: PointerEventResampler'),
      Text('Purpose: consistent time source'),
    ],
  );
}
