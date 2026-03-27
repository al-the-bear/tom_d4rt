// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StreamBuilderBase from widgets
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Example concrete implementation
class CountStreamBuilder extends StreamBuilderBase<int, int> {
  const CountStreamBuilder({super.key, required Stream<int>? stream})
      : super(stream: stream);
  
  @override
  int initial() => 0;
  
  @override
  int afterData(int current, int data) => data;
  
  @override
  Widget build(BuildContext context, int currentSummary) {
    return Text('Count: $currentSummary');
  }
}

dynamic build(BuildContext context) {
  print('StreamBuilderBase test executing');
  print('=' * 50);

  // StreamBuilderBase overview
  print('StreamBuilderBase overview:');
  print('  - Abstract StatefulWidget');
  print('  - Base class for stream-based builders');
  print('  - Generic type parameters: T (event), S (summary)');
  print('  - Implements fold computation pattern');

  // Test with a stream
  print('\nTest stream creation:');
  final controller = StreamController<int>();
  print('  Created StreamController<int>');

  // Create widget
  print('\nWidget creation:');
  final widget = CountStreamBuilder(stream: controller.stream);
  print('  Created CountStreamBuilder');
  print('  stream: ${widget.stream}');

  // Abstract methods to implement
  print('\nAbstract methods (required):');
  print('  - initial(): Returns initial summary (no data yet)');
  print('  - afterData(S current, T data): Update summary with data');
  print('  - build(context, summary): Build widget from summary');

  // Optional methods to override
  print('\nOptional methods:');
  print('  - afterConnected(S current): When connected to stream');
  print('  - afterError(S current, error, stackTrace): On error event');
  print('  - afterDone(S current): When stream closes');
  print('  - afterDisconnected(S current): When disconnected');

  // Fold computation pattern
  print('\nFold computation pattern:');
  print('  initial() -> afterConnected() -> [afterData() | afterError()]* -> afterDone() -> afterDisconnected()');
  print('  - Accumulates summary state over time');
  print('  - Similar to stream.fold()');

  // Comparison with StreamBuilder
  print('\nComparison with StreamBuilder:');
  print('  StreamBuilder:');
  print('    - Uses AsyncSnapshot<T>');
  print('    - Built-in state management');
  print('    - Simple connectionState tracking');
  print('  StreamBuilderBase:');
  print('    - Custom summary type S');
  print('    - Full control over state');
  print('    - Fold-style accumulation');

  // Use cases
  print('\nUse cases:');
  print('  - Accumulating stream values');
  print('  - Custom error handling');
  print('  - Complex state derivation');
  print('  - Specialized stream UIs');

  // Cleanup
  controller.close();

  print('\n' + '=' * 50);
  print('StreamBuilderBase test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StreamBuilderBase Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract StatefulWidget'),
      Text('Type params: <T, S>'),
      Text('Pattern: Fold computation'),
    ],
  );
}
