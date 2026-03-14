import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class _EnumProbe<T> {
  const _EnumProbe({
    required this.value,
    required this.name,
    required this.index,
  });

  final T value;
  final String name;
  final int index;

  String get signature => '$name#$index';
}

class _RunSummary {
  const _RunSummary({
    required this.checks,
    required this.failures,
    required this.valueCount,
  });

  final int checks;
  final int failures;
  final int valueCount;
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

  logs.add('Starting SpringType enum verification');

  final values = SpringType.values;
  _check(
    condition: values.isNotEmpty,
    message: 'values are not empty',
    logs: logs,
    failures: failures,
  );
  checks++;

  final probes = values
      .map(
        (value) => _EnumProbe<SpringType>(
          value: value,
          name: value.name,
          index: value.index,
        ),
      )
      .toList(growable: false);

  _check(
    condition: probes.length == values.length,
    message: 'probe count matches value count',
    logs: logs,
    failures: failures,
  );
  checks++;

  final names = values.map((value) => value.name).toList(growable: false);
  final uniqueNames = names.toSet();
  _check(
    condition: uniqueNames.length == values.length,
    message: 'enum names are unique',
    logs: logs,
    failures: failures,
  );
  checks++;

  final indices = values.map((value) => value.index).toList(growable: false);
  final isContiguous = indices.every((index) => index >= 0) &&
      indices.toSet().length == indices.length &&
      indices.reduce((a, b) => a < b ? a : b) == 0 &&
      indices.reduce((a, b) => a > b ? a : b) == values.length - 1;
  _check(
    condition: isContiguous,
    message: 'indices are contiguous from 0..n-1',
    logs: logs,
    failures: failures,
  );
  checks++;

  final roundTripValid = values
      .map((value) => SpringType.values.byName(value.name) == value)
      .every((isMatch) => isMatch);
  _check(
    condition: roundTripValid,
    message: 'byName round-trip works for all values',
    logs: logs,
    failures: failures,
  );
  checks++;

  var invalidByNameThrows = false;
  try {
    SpringType.values.byName('__invalid_spring_type__');
  } catch (_) {
    invalidByNameThrows = true;
  }
  _check(
    condition: invalidByNameThrows,
    message: 'invalid byName lookup throws as edge case',
    logs: logs,
    failures: failures,
  );
  checks++;

  final toStringIncludesType =
      values.every((value) => value.toString().startsWith('SpringType.'));
  _check(
    condition: toStringIncludesType,
    message: 'toString includes enum type prefix',
    logs: logs,
    failures: failures,
  );
  checks++;

  final first = values.first;
  final last = values.last;
  _check(
    condition: first.index == 0 && last.index == values.length - 1,
    message: 'first and last boundaries are valid',
    logs: logs,
    failures: failures,
  );
  checks++;

  final signatureText = probes.map((probe) => probe.signature).join(', ');
  _check(
    condition: signatureText.isNotEmpty,
    message: 'probe signatures produce summary text',
    logs: logs,
    failures: failures,
  );
  checks++;

  final summary = _RunSummary(
    checks: checks,
    failures: failures.length,
    valueCount: values.length,
  );
  final summaryLine =
      'SpringType summary: checks=${summary.checks}, failures=${summary.failures}, values=${summary.valueCount}';

  print(summaryLine);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text('SpringType Test Summary'),
      Text(summaryLine),
      Text('Context: ${context.runtimeType}'),
      Text('First: ${first.name} (${first.index})'),
      Text('Last: ${last.name} (${last.index})'),
      Text('Signatures: $signatureText'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
