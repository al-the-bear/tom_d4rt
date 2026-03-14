// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings
// D4rt comprehensive test script for ClipboardStatus
import 'package:flutter/widgets.dart';

void expectCondition(
  bool condition,
  String message,
  List<String> logs,
  Map<String, int> counters,
) {
  if (condition) {
    counters['passed'] = (counters['passed'] ?? 0) + 1;
    logs.add('PASS: ' + message);
    print('PASS: ' + message);
  } else {
    counters['failed'] = (counters['failed'] ?? 0) + 1;
    logs.add('FAIL: ' + message);
    print('FAIL: ' + message);
    assert(condition, message);
  }
}

dynamic build(BuildContext context) {
  final List<String> logs = <String>[];
  final Map<String, int> counters = <String, int>{'passed': 0, 'failed': 0};

  print('========== ClipboardStatus comprehensive test ==========' );

  final List<ClipboardStatus> values = ClipboardStatus.values;
  expectCondition(values.isNotEmpty, 'ClipboardStatus.values should not be empty', logs, counters);
  expectCondition(values.length >= 2, 'ClipboardStatus should provide multiple values', logs, counters);

  final ClipboardStatus first = values.first;
  final ClipboardStatus last = values.last;
  print('First value: ${first.name} / ${first.index}');
  print('Last value: ${last.name} / ${last.index}');

  expectCondition(first.index == 0, 'First index is zero', logs, counters);
  expectCondition(last.index == values.length - 1, 'Last index matches length - 1', logs, counters);
  expectCondition(first != last, 'First and last should differ when length > 1', logs, counters);

  final Set<int> uniqueIndexes = <int>{};
  final Set<String> uniqueNames = <String>{};
  final List<String> serializedValues = <String>[];

  for (final ClipboardStatus value in values) {
    print('Inspect value: name=${value.name}, index=${value.index}, str=${value.toString()}');
    uniqueIndexes.add(value.index);
    uniqueNames.add(value.name);
    serializedValues.add(value.toString());

    expectCondition(value.name.isNotEmpty, 'Name should not be empty for ${value.toString()}', logs, counters);
    expectCondition(value.toString().contains(value.name), 'toString contains enum name for ${value.name}', logs, counters);
    expectCondition(values[value.index] == value, 'Index round-trip works for ${value.name}', logs, counters);

    final ClipboardStatus byName = ClipboardStatus.values.byName(value.name);
    expectCondition(byName == value, 'byName resolves ${value.name}', logs, counters);
  }

  expectCondition(uniqueIndexes.length == values.length, 'Indexes should be unique', logs, counters);
  expectCondition(uniqueNames.length == values.length, 'Names should be unique', logs, counters);
  expectCondition(serializedValues.length == values.length, 'Serialized values count matches values', logs, counters);

  final List<String> indexNamePairs = values
      .map((v) => '${v.index}:${v.name}')
      .toList(growable: false);
  print('Index/name pairs: ${indexNamePairs.join(', ')}');

  expectCondition(
    indexNamePairs.every((pair) => pair.contains(':')),
    'All index/name pairs contain separator',
    logs,
    counters,
  );

  final List<ClipboardStatus> copied = List<ClipboardStatus>.from(values);
  expectCondition(copied.length == values.length, 'Copied list has same length', logs, counters);
  expectCondition(copied.first == first, 'Copied first equals original first', logs, counters);
  expectCondition(copied.last == last, 'Copied last equals original last', logs, counters);

  final List<ClipboardStatus> reversed = values.reversed.toList(growable: false);
  expectCondition(reversed.first == last, 'Reversed first equals original last', logs, counters);
  expectCondition(reversed.last == first, 'Reversed last equals original first', logs, counters);

  final int indexSum = values.fold<int>(0, (sum, v) => sum + v.index);
  expectCondition(indexSum >= 0, 'Index sum is non-negative', logs, counters);
  print('Index sum: $indexSum');

  final String edgeName = values.first.name;
  final ClipboardStatus edgeByName = ClipboardStatus.values.byName(edgeName);
  expectCondition(edgeByName == values.first, 'Edge case byName(first.name) works', logs, counters);

  final int passCount = counters['passed'] ?? 0;
  final int failCount = counters['failed'] ?? 0;
  print('Summary: passed=$passCount failed=$failCount total=${passCount + failCount}');

  return Container(
    padding: const EdgeInsets.all(12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('ClipboardStatus Comprehensive Tests'),
        Text('Values count: ${values.length}'),
        Text('Passed: $passCount'),
        Text('Failed: $failCount'),
        Text('First: ${first.name} (#${first.index})'),
        Text('Last: ${last.name} (#${last.index})'),
        Text('Unique names: ${uniqueNames.length}'),
        Text('Unique indexes: ${uniqueIndexes.length}'),
        Text('Index sum: $indexSum'),
        Text('Logs captured: ${logs.length}'),
        const SizedBox(height: 8),
        Text('Result: ${failCount == 0 ? 'SUCCESS' : 'FAILURE'}'),
      ],
    ),
  );
}
