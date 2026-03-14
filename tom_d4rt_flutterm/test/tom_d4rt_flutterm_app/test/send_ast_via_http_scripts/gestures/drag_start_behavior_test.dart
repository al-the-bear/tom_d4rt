import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class _EnumHolder<T> {
  const _EnumHolder({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;

  String get pair => '$label:$value';
}

class _RunStats {
  const _RunStats({
    required this.checks,
    required this.failures,
  });

  final int checks;
  final int failures;
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

  logs.add('Starting DragStartBehavior checks');

  final values = DragStartBehavior.values;
  _check(
    condition: values.isNotEmpty,
    message: 'values list is not empty',
    logs: logs,
    failures: failures,
  );
  checks++;

  final holders = values
      .map(
        (value) => _EnumHolder<DragStartBehavior>(
          value: value,
          label: value.name,
        ),
      )
      .toList(growable: false);

  _check(
    condition: holders.length == values.length,
    message: 'holder count matches enum value count',
    logs: logs,
    failures: failures,
  );
  checks++;

  final first = values.first;
  final last = values.last;

  _check(
    condition: first.index == 0,
    message: 'first enum index is 0',
    logs: logs,
    failures: failures,
  );
  checks++;

  _check(
    condition: last.index == values.length - 1,
    message: 'last enum index is values.length - 1',
    logs: logs,
    failures: failures,
  );
  checks++;

  final uniqueNames = values.map((value) => value.name).toSet();
  _check(
    condition: uniqueNames.length == values.length,
    message: 'enum names are unique',
    logs: logs,
    failures: failures,
  );
  checks++;

  final allRoundTrips = values
      .map((value) => DragStartBehavior.values.byName(value.name) == value)
      .every((isMatch) => isMatch);
  _check(
    condition: allRoundTrips,
    message: 'all names round-trip with byName',
    logs: logs,
    failures: failures,
  );
  checks++;

  var invalidNameThrows = false;
  try {
    DragStartBehavior.values.byName('__DragStartBehavior_invalid__');
  } catch (_) {
    invalidNameThrows = true;
  }

  _check(
    condition: invalidNameThrows,
    message: 'invalid byName lookup throws',
    logs: logs,
    failures: failures,
  );
  checks++;

  final namesFromHolders = holders.map((holder) => holder.label).toList();
  _check(
    condition: namesFromHolders.first == first.name,
    message: 'holder label reflects first enum name',
    logs: logs,
    failures: failures,
  );
  checks++;

  final pairPreview = holders.map((holder) => holder.pair).join(' | ');
  _check(
    condition: pairPreview.contains(first.name),
    message: 'pair preview includes first enum name',
    logs: logs,
    failures: failures,
  );
  checks++;

  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _check(
    condition: sortedByIndex.first == first && sortedByIndex.last == last,
    message: 'sorting by index keeps first/last boundaries',
    logs: logs,
    failures: failures,
  );
  checks++;

  final stats = _RunStats(checks: checks, failures: failures.length);
  final summary =
      'DragStartBehavior summary: checks=${stats.checks}, failures=${stats.failures}, values=${values.length}';

  print(summary);
  for (final line in logs) {
    print(line);
  }

  return ListView(
    padding: const EdgeInsets.all(12),
    children: [
      const Text(
        'DragStartBehavior Test Summary',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(summary),
      Text('Context: ${context.runtimeType}'),
      Text('First: ${first.name} (${first.index})'),
      Text('Last: ${last.name} (${last.index})'),
      Text('Pairs: $pairPreview'),
      const SizedBox(height: 8),
      ...logs.map(Text.new),
    ],
  );
}
