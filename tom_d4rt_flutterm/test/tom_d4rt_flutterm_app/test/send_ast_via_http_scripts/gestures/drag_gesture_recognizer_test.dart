import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('DragGestureRecognizer test failed: $message');
  }
  logs.add('PASS: $message');
}

dynamic build(BuildContext context) {
  print('=== DragGestureRecognizer comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final horizontal = HorizontalDragGestureRecognizer();
  final vertical = VerticalDragGestureRecognizer();
  final pan = PanGestureRecognizer();

  final recognizers = <DragGestureRecognizer>[horizontal, vertical, pan];

  _expectCondition(recognizers.length == 3, 'three drag recognizers created', logs);
  assertionCount++;

  for (final recognizer in recognizers) {
    _expectCondition(
      recognizer is DragGestureRecognizer,
      '${recognizer.runtimeType} is DragGestureRecognizer',
      logs,
    );
    assertionCount++;

    recognizer.dragStartBehavior = DragStartBehavior.down;
    _expectCondition(
      recognizer.dragStartBehavior == DragStartBehavior.down,
      '${recognizer.runtimeType}.dragStartBehavior stores assigned value',
      logs,
    );
    assertionCount++;

    recognizer.supportedDevices = {PointerDeviceKind.touch, PointerDeviceKind.mouse};
    _expectCondition(
      recognizer.supportedDevices?.contains(PointerDeviceKind.mouse) ?? false,
      '${recognizer.runtimeType}.supportedDevices stores pointer kinds',
      logs,
    );
    assertionCount++;

    recognizer.gestureSettings = const DeviceGestureSettings(touchSlop: 14);
    _expectCondition(
      recognizer.gestureSettings?.touchSlop == 14,
      '${recognizer.runtimeType}.gestureSettings touchSlop is applied',
      logs,
    );
    assertionCount++;

    recognizer.onDown = (details) => print('${recognizer.runtimeType}.onDown -> ${details.globalPosition}');
    recognizer.onStart = (details) => print('${recognizer.runtimeType}.onStart -> ${details.globalPosition}');
    recognizer.onUpdate = (details) => print('${recognizer.runtimeType}.onUpdate -> ${details.delta}');
    recognizer.onEnd = (details) => print('${recognizer.runtimeType}.onEnd -> ${details.velocity.pixelsPerSecond}');
    recognizer.onCancel = () => print('${recognizer.runtimeType}.onCancel');

    _expectCondition(recognizer.onDown != null, '${recognizer.runtimeType}.onDown assignable', logs);
    assertionCount++;
    _expectCondition(recognizer.onStart != null, '${recognizer.runtimeType}.onStart assignable', logs);
    assertionCount++;
    _expectCondition(recognizer.onUpdate != null, '${recognizer.runtimeType}.onUpdate assignable', logs);
    assertionCount++;
    _expectCondition(recognizer.onEnd != null, '${recognizer.runtimeType}.onEnd assignable', logs);
    assertionCount++;
    _expectCondition(recognizer.onCancel != null, '${recognizer.runtimeType}.onCancel assignable', logs);
    assertionCount++;
  }

  // Edge case: toggle settings and ensure last assignment wins.
  horizontal.onlyAcceptDragOnThreshold = true;
  horizontal.onlyAcceptDragOnThreshold = false;
  _expectCondition(
    horizontal.onlyAcceptDragOnThreshold == false,
    'onlyAcceptDragOnThreshold reflects last assignment',
    logs,
  );
  assertionCount++;

  final runtimeTypes = recognizers.map((value) => value.runtimeType.toString()).toList();
  print('runtimeTypes: $runtimeTypes');

  for (final recognizer in recognizers) {
    recognizer.dispose();
    print('disposed: ${recognizer.runtimeType}');
  }

  final summary = <String>[
    'constructors covered via Horizontal/Vertical/Pan recognizers',
    'properties covered: dragStartBehavior, supportedDevices, gestureSettings',
    'behavior covered: callbacks assignment and runtime configuration',
    'edge case covered: repeated threshold assignment',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== DragGestureRecognizer comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('DragGestureRecognizer Tests'),
      Text('Assertions: $assertionCount'),
      Text('Recognizer count: ${recognizers.length}'),
      Text('Runtime types: ${runtimeTypes.join(', ')}'),
      Text('Horizontal threshold flag: ${horizontal.onlyAcceptDragOnThreshold}'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
