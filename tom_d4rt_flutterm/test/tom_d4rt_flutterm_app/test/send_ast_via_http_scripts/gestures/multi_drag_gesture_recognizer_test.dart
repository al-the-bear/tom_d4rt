import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('MultiDragGestureRecognizer test failed: $message');
  }
  logs.add('PASS: $message');
}

dynamic build(BuildContext context) {
  print('=== MultiDragGestureRecognizer comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final recognizers = <MultiDragGestureRecognizer>[
    ImmediateMultiDragGestureRecognizer(),
    HorizontalMultiDragGestureRecognizer(),
    VerticalMultiDragGestureRecognizer(),
    DelayedMultiDragGestureRecognizer(delay: const Duration(milliseconds: 120)),
  ];

  _expectCondition(
    recognizers.length == 4,
    'created four MultiDragGestureRecognizer instances via concrete constructors',
    logs,
  );
  assertionCount++;

  final runtimeNames = <String>[];
  for (final recognizer in recognizers) {
    runtimeNames.add(recognizer.runtimeType.toString());
    print('recognizer: ${recognizer.runtimeType}');

    _expectCondition(
      recognizer is MultiDragGestureRecognizer,
      '${recognizer.runtimeType} is MultiDragGestureRecognizer',
      logs,
    );
    assertionCount++;

    recognizer.onStart = (Offset position) {
      print('${recognizer.runtimeType}.onStart invoked at $position');
      return null;
    };

    _expectCondition(
      recognizer.onStart != null,
      '${recognizer.runtimeType}.onStart is assignable',
      logs,
    );
    assertionCount++;

    recognizer.gestureSettings = const DeviceGestureSettings(touchSlop: 18);
    _expectCondition(
      recognizer.gestureSettings != null,
      '${recognizer.runtimeType}.gestureSettings set/read works',
      logs,
    );
    assertionCount++;

    recognizer.supportedDevices = <PointerDeviceKind>{
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
    };
    _expectCondition(
      recognizer.supportedDevices?.contains(PointerDeviceKind.touch) ?? false,
      '${recognizer.runtimeType}.supportedDevices stores touch kind',
      logs,
    );
    assertionCount++;
  }

  final uniqueNames = runtimeNames.toSet();
  _expectCondition(
    uniqueNames.length == runtimeNames.length,
    'all concrete recognizer runtime names are unique',
    logs,
  );
  assertionCount++;

  final delayed = recognizers.whereType<DelayedMultiDragGestureRecognizer>().first;
  _expectCondition(
    delayed.delay == const Duration(milliseconds: 120),
    'DelayedMultiDragGestureRecognizer constructor delay is retained',
    logs,
  );
  assertionCount++;

  final immediate = recognizers.whereType<ImmediateMultiDragGestureRecognizer>().first;
  _expectCondition(
    immediate.gestureSettings?.touchSlop == 18,
    'ImmediateMultiDragGestureRecognizer gestureSettings touchSlop retained',
    logs,
  );
  assertionCount++;

  // Edge case: nullable supportedDevices reset to null.
  immediate.supportedDevices = null;
  _expectCondition(
    immediate.supportedDevices == null,
    'supportedDevices can be reset to null',
    logs,
  );
  assertionCount++;

  for (final recognizer in recognizers) {
    recognizer.dispose();
    print('disposed: ${recognizer.runtimeType}');
  }

  final summary = <String>[
    'constructors covered via four concrete implementations',
    'properties covered: onStart, gestureSettings, supportedDevices',
    'behavior covered: assignment and retrieval semantics',
    'edge case: reset supportedDevices to null',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== MultiDragGestureRecognizer comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('MultiDragGestureRecognizer Tests'),
      Text('Assertions: $assertionCount'),
      Text('Runtime types: ${runtimeNames.join(', ')}'),
      Text('Unique runtime types: ${uniqueNames.length}'),
      Text('Delayed delay: ${delayed.delay.inMilliseconds}ms'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
