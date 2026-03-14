import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class _DragCase {
  const _DragCase({
    required this.label,
    required this.details,
  });

  final String label;
  final DragStartDetails details;

  String get digest =>
      '$label@global=${details.globalPosition},local=${details.localPosition},kind=${details.kind}';
}

void _check({
  required bool condition,
  required String message,
  required List<String> logs,
  required List<String> failures,
}) {
  if (condition) {
    logs.add('PASS: $message');
    return;
  }

  logs.add('FAIL: $message');
  failures.add(message);
  assert(condition, message);
}

dynamic build(BuildContext context) {
  final logs = <String>[];
  final failures = <String>[];
  var checks = 0;

  logs.add('Starting DragStartDetails checks');

  final baseline = DragStartDetails(
    globalPosition: const Offset(100, 150),
    sourceTimeStamp: const Duration(milliseconds: 16),
  );
  final localTouch = DragStartDetails(
    globalPosition: const Offset(12, 24),
    localPosition: const Offset(2, 4),
    kind: PointerDeviceKind.touch,
    sourceTimeStamp: const Duration(milliseconds: 32),
  );
  final stylusCase = DragStartDetails(
    globalPosition: const Offset(-1, 99),
    localPosition: const Offset(-3, 11),
    kind: PointerDeviceKind.stylus,
    sourceTimeStamp: const Duration(milliseconds: 64),
  );

  final cases = <_DragCase>[
    _DragCase(label: 'baseline', details: baseline),
    _DragCase(label: 'localTouch', details: localTouch),
    _DragCase(label: 'stylusCase', details: stylusCase),
  ];

  _check(
    condition: cases.length == 3,
    message: 'three concrete drag start cases created',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.localPosition == baseline.globalPosition,
    message: 'localPosition defaults to globalPosition when omitted',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: localTouch.localPosition == const Offset(2, 4),
    message: 'explicit localPosition is preserved',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: localTouch.kind == PointerDeviceKind.touch,
    message: 'kind is stored for touch case',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: stylusCase.kind == PointerDeviceKind.stylus,
    message: 'kind is stored for stylus case',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.sourceTimeStamp == const Duration(milliseconds: 16),
    message: 'sourceTimeStamp is preserved on baseline case',
    logs: logs,
    failures: failures,
  );
  checks++;

  final digest = cases.map((item) => item.digest).join(' | ');
  _check(
    condition: digest.contains('baseline@global='),
    message: 'digest contains baseline details',
    logs: logs,
    failures: failures,
  );
  checks++;

  final increasingTimes = cases
      .map((item) => item.details.sourceTimeStamp?.inMilliseconds ?? -1)
      .toList(growable: false);
  _check(
    condition: increasingTimes[0] < increasingTimes[1] &&
        increasingTimes[1] < increasingTimes[2],
    message: 'timestamps are increasing across prepared scenarios',
    logs: logs,
    failures: failures,
  );
  checks++;

  final edgeZero = DragStartDetails(
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    sourceTimeStamp: Duration.zero,
  );
  _check(
    condition: edgeZero.globalPosition == Offset.zero,
    message: 'edge case with zero offsets is supported',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: edgeZero.sourceTimeStamp == Duration.zero,
    message: 'edge case with zero timestamp is supported',
    logs: logs,
    failures: failures,
  );
  checks++;

  final summary =
      'DragStartDetails summary: checks=$checks, failures=${failures.length}, cases=${cases.length + 1}';
  print(summary);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text(
        'DragStartDetails Test Summary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(summary),
      Text('Context: ${context.runtimeType}'),
      Text('Baseline global: ${baseline.globalPosition}'),
      Text('Local touch local: ${localTouch.localPosition}'),
      Text('Stylus kind: ${stylusCase.kind}'),
      Text('Digest: $digest'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
