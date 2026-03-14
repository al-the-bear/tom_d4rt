// D4rt test script: Tests SerialTapCancelDetails concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapCancelDetails comprehensive test executing');
  final results = <String>[];

  // ========== SerialTapCancelDetails Tests ==========
  print('Testing SerialTapCancelDetails...');

  // Test 1: Create SerialTapCancelDetails with count 1
  final cancelDetails1 = SerialTapCancelDetails(count: 1);
  assert(cancelDetails1.count == 1, 'Count should be 1');
  results.add('Cancel details count=1 created');
  print('SerialTapCancelDetails: count=${cancelDetails1.count}');

  // Test 2: Create SerialTapCancelDetails with count 2 (double tap cancel)
  final cancelDetails2 = SerialTapCancelDetails(count: 2);
  assert(cancelDetails2.count == 2, 'Count should be 2');
  results.add('Cancel details count=2 created');
  print('Double tap cancel: count=${cancelDetails2.count}');

  // Test 3: Create SerialTapCancelDetails with count 3 (triple tap cancel)
  final cancelDetails3 = SerialTapCancelDetails(count: 3);
  assert(cancelDetails3.count == 3, 'Count should be 3');
  results.add('Cancel details count=3 created');
  print('Triple tap cancel: count=${cancelDetails3.count}');

  // Test 4: Count property verification
  final testCount = cancelDetails1.count;
  assert(testCount == 1, 'Count getter should work');
  results.add('Count property verified: $testCount');
  print('Count property getter: $testCount');

  // Test 5: Cancel scenarios - movement exceeded slop
  final kTouchSlop = 18.0;
  final downPos = Offset(100.0, 100.0);
  final currentPos = Offset(130.0, 130.0);
  final movement = (currentPos - downPos).distance;
  final exceededSlop = movement > kTouchSlop;
  assert(exceededSlop, 'Movement should exceed slop');
  results.add(
    'Slop exceeded: $exceededSlop (movement ${movement.toStringAsFixed(2)})',
  );
  print('Cancel scenario - slop exceeded: $exceededSlop');

  // Test 6: Cancel scenarios - timeout expired
  final kTapTimeout = Duration(milliseconds: 300);
  final tapStart = Duration(milliseconds: 0);
  final currentTime = Duration(milliseconds: 500);
  final elapsed = currentTime - tapStart;
  final timeoutExpired = elapsed > kTapTimeout;
  assert(timeoutExpired, 'Timeout should be expired');
  results.add('Timeout expired: $timeoutExpired (${elapsed.inMilliseconds}ms)');
  print('Cancel scenario - timeout expired: $timeoutExpired');

  // Test 7: Cancel scenarios - another recognizer won
  final competingRecognizerWon = true;
  results.add('Competing recognizer won: $competingRecognizerWon');
  print('Cancel scenario - competing recognizer: $competingRecognizerWon');

  // Test 8: Count indicates which tap was cancelled
  for (var i = 1; i <= 5; i++) {
    final cancel = SerialTapCancelDetails(count: i);
    print('Tap $i cancelled: count=${cancel.count}');
  }
  results.add('Tap cancel counts 1-5 tested');

  // Test 9: Cancel during double tap sequence
  final midDoubleTapCancel = SerialTapCancelDetails(count: 2);
  assert(midDoubleTapCancel.count == 2, 'Should indicate 2nd tap cancelled');
  results.add('Mid-double-tap cancel: count=${midDoubleTapCancel.count}');
  print('Cancel during double tap: count=${midDoubleTapCancel.count}');

  // Test 10: Cancel state tracking concept
  var tapSequenceCount = 0;
  var cancelled = false;
  void onTapDown() {
    tapSequenceCount++;
  }

  void onTapCancel(int count) {
    cancelled = true;
    assert(count == tapSequenceCount, 'Cancel count should match sequence');
  }

  onTapDown();
  onTapDown();
  onTapCancel(2);
  results.add(
    'Cancel state tracking: cancelled=$cancelled, count=$tapSequenceCount',
  );
  print('State tracking: tapCount=$tapSequenceCount, cancelled=$cancelled');

  // Test 11: Callback pattern
  SerialTapCancelDetails? lastCancelDetails;
  void handleCancel(SerialTapCancelDetails details) {
    lastCancelDetails = details;
  }

  handleCancel(cancelDetails2);
  assert(lastCancelDetails != null, 'Details should be captured');
  assert(lastCancelDetails!.count == 2, 'Count should be preserved');
  results.add('Callback pattern verified');
  print('Callback captures details: count=${lastCancelDetails!.count}');

  // Test 12: High count cancellation
  final highCountCancel = SerialTapCancelDetails(count: 10);
  assert(highCountCancel.count == 10, 'High count should work');
  results.add('High count cancel: ${highCountCancel.count}');
  print('High count cancellation: count=${highCountCancel.count}');

  // Test 13: Zero count edge case concept
  // Note: count=0 may not be typical but testing boundary
  final zeroCountCancel = SerialTapCancelDetails(count: 0);
  results.add('Edge case count=0: ${zeroCountCancel.count}');
  print('Edge case zero count: ${zeroCountCancel.count}');

  // Test 14: Integration with SerialTapGestureRecognizer
  final recognizer = SerialTapGestureRecognizer();
  var cancelCallCount = 0;
  recognizer.onSerialTapCancel = (SerialTapCancelDetails details) {
    cancelCallCount++;
    print('Cancel callback: count=${details.count}');
  };
  results.add('Recognizer callback connected');
  print('Recognizer callback setup complete');

  // Test 15: Multiple cancel callbacks concept
  final cancelCounts = <int>[];
  void recordCancel(SerialTapCancelDetails d) {
    cancelCounts.add(d.count);
  }

  recordCancel(SerialTapCancelDetails(count: 1));
  recordCancel(SerialTapCancelDetails(count: 2));
  recordCancel(SerialTapCancelDetails(count: 3));
  assert(cancelCounts.length == 3, 'Should record 3 cancels');
  results.add('Multi-cancel recorded: $cancelCounts');
  print('Cancel counts recorded: $cancelCounts');

  // Test 16: Cancel reason determination concept
  String determineReason(double movement, Duration elapsed) {
    if (movement > kTouchSlop) return 'movement_exceeded';
    if (elapsed > kTapTimeout) return 'timeout';
    return 'competing_gesture';
  }

  final reason = determineReason(25.0, Duration(milliseconds: 100));
  assert(reason == 'movement_exceeded', 'Reason should be movement');
  results.add('Cancel reason: $reason');
  print('Cancel reason determination: $reason');

  // Test 17: Cancel vs complete differentiation
  final wasCompleted = false;
  final wasCancelled = true;
  assert(wasCompleted != wasCancelled, 'Cannot be both');
  results.add('Cancel/Complete mutual exclusion verified');
  print('Tap cancelled (not completed): $wasCancelled');

  // Test 18: Count semantic meaning
  // count=1: first tap cancelled, count=2: during double tap, etc.
  final semantics = {
    1: 'single tap cancelled',
    2: 'double tap sequence cancelled',
    3: 'triple tap sequence cancelled',
  };
  for (var entry in semantics.entries) {
    print('Count ${entry.key}: ${entry.value}');
  }
  results.add('Count semantics documented');

  // Test 19: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('SerialTapGestureRecognizer disposed');

  // Test 20: Summary
  results.add('SerialTapCancelDetails: single property (count)');
  print(
    'SerialTapCancelDetails summary: count property indicates tap sequence depth at cancel',
  );

  print('SerialTapCancelDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SerialTapCancelDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Property: count (tap sequence depth)'),
      Text('Cancel reasons: movement, timeout, competing'),
      Text('Usage: onSerialTapCancel callback'),
      Text('Count: 1=single, 2=double seq, 3=triple seq'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
