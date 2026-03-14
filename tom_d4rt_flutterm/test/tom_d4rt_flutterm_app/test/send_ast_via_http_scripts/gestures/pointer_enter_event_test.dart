import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class _PointerCase {
  const _PointerCase({
    required this.label,
    required this.event,
  });

  final String label;
  final PointerEnterEvent event;

  String get digest =>
      '$label@position=${event.position},local=${event.localPosition},device=${event.device},kind=${event.kind}';
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

  logs.add('Starting PointerEnterEvent checks');

  final baseline = PointerEnterEvent(
    position: const Offset(10, 20),
    device: 7,
    kind: PointerDeviceKind.mouse,
  );
  final hover = PointerHoverEvent(
    position: const Offset(33, 44),
    device: 9,
    kind: PointerDeviceKind.mouse,
  );
  final fromMouse = PointerEnterEvent.fromMouseEvent(hover);
  final touchLike = PointerEnterEvent(
    position: const Offset(-5, 99),
    device: 11,
    kind: PointerDeviceKind.touch,
  );

  final cases = <_PointerCase>[
    _PointerCase(label: 'baseline', event: baseline),
    _PointerCase(label: 'fromMouse', event: fromMouse),
    _PointerCase(label: 'touchLike', event: touchLike),
  ];

  _check(
    condition: cases.length == 3,
    message: 'three concrete pointer enter event cases created',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.position == const Offset(10, 20),
    message: 'baseline position is preserved',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.localPosition == baseline.position,
    message: 'baseline localPosition defaults to position',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: baseline.device == 7,
    message: 'baseline device id is preserved',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: fromMouse.position == hover.position,
    message: 'fromMouseEvent copies position',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: fromMouse.localPosition == fromMouse.position,
    message: 'fromMouseEvent localPosition is available',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: fromMouse.device == hover.device,
    message: 'fromMouseEvent copies device id',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: touchLike.kind == PointerDeviceKind.touch,
    message: 'touch-like case keeps touch pointer kind',
    logs: logs,
    failures: failures,
  );
  checks++;

  final digest = cases.map((item) => item.digest).join(' | ');
  _check(
    condition: digest.contains('fromMouse@position='),
    message: 'digest contains fromMouse case details',
    logs: logs,
    failures: failures,
  );
  checks++;

  final allPointerEvents =
      cases.every((item) => item.event.runtimeType == PointerEnterEvent);
  _check(
    condition: allPointerEvents,
    message: 'all constructed cases are PointerEnterEvent instances',
    logs: logs,
    failures: failures,
  );
  checks++;

  final summary =
      'PointerEnterEvent summary: checks=$checks, failures=${failures.length}, cases=${cases.length}';
  print(summary);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text(
        'PointerEnterEvent Test Summary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(summary),
      Text('Context: ${context.runtimeType}'),
      Text('Baseline: ${baseline.position}/${baseline.localPosition}'),
      Text('FromMouse: ${fromMouse.position}/${fromMouse.localPosition}'),
      Text('TouchLike kind: ${touchLike.kind}'),
      Text('Digest: $digest'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
