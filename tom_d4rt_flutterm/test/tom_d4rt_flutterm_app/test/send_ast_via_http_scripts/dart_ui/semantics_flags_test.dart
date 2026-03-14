import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('SemanticsFlags test failed: $message');
  }
  logs.add('PASS: $message');
}

String _describe(ui.SemanticsFlag flag) {
  return '${flag.name}(index=${flag.index}, toString=$flag)';
}

dynamic build(BuildContext context) {
  print('=== SemanticsFlags comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final values = ui.SemanticsFlag.values;
  final names = values.map((value) => value.name).toList();
  final indices = values.map((value) => value.index).toList();

  _expectCondition(
    values.isNotEmpty,
    'SemanticsFlag values are available',
    logs,
  );
  assertionCount++;

  _expectCondition(
    names.toSet().length == names.length,
    'SemanticsFlag names are unique',
    logs,
  );
  assertionCount++;

  _expectCondition(
    indices.toSet().length == indices.length,
    'SemanticsFlag indices are unique',
    logs,
  );
  assertionCount++;

  for (final value in values) {
    print('flag: ${_describe(value)}');

    final roundTrip = ui.SemanticsFlag.values.byName(value.name);
    _expectCondition(
      identical(roundTrip, value),
      'byName round-trip for ${value.name}',
      logs,
    );
    assertionCount++;

    _expectCondition(
      value.toString().contains(value.name),
      'toString includes enum name for ${value.name}',
      logs,
    );
    assertionCount++;
  }

  final hasButton = values.contains(ui.SemanticsFlag.isButton);
  final hasTextField = values.contains(ui.SemanticsFlag.isTextField);

  _expectCondition(hasButton, 'contains SemanticsFlag.isButton', logs);
  assertionCount++;

  _expectCondition(hasTextField, 'contains SemanticsFlag.isTextField', logs);
  assertionCount++;

  final first = values.first;
  final last = values.last;

  _expectCondition(first.index == 0, 'first SemanticsFlag index is zero', logs);
  assertionCount++;

  _expectCondition(
    last.index == values.length - 1,
    'last SemanticsFlag index is values.length - 1',
    logs,
  );
  assertionCount++;

  var invalidNameThrows = false;
  try {
    ui.SemanticsFlag.values.byName('__invalid_semantics_flag_name__');
  } catch (error) {
    invalidNameThrows = true;
    print('expected byName error: $error');
  }

  _expectCondition(
    invalidNameThrows,
    'invalid byName throws for SemanticsFlag',
    logs,
  );
  assertionCount++;

  final indexSum = indices.fold<int>(0, (sum, index) => sum + index);
  final expectedSum = values.length * (values.length - 1) ~/ 2;
  _expectCondition(
    indexSum == expectedSum,
    'indices are contiguous and cover 0..n-1',
    logs,
  );
  assertionCount++;

  // File name uses SemanticsFlags (plural). Flutter API exposes SemanticsFlag.
  final semanticsFlagsNameAlignment = 'SemanticsFlags -> SemanticsFlag';
  print('naming alignment: $semanticsFlagsNameAlignment');

  final summary = <String>[
    'constructors/enum values path covered via SemanticsFlag.values',
    'properties covered: name, index, toString',
    'behavior covered: byName and contains lookups',
    'edge case covered: invalid byName throws',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== SemanticsFlags comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('SemanticsFlags Tests'),
      Text('Resolved API: $semanticsFlagsNameAlignment'),
      Text('Values: ${values.length}'),
      Text('First: ${first.name} (${first.index})'),
      Text('Last: ${last.name} (${last.index})'),
      Text('Invalid byName throws: $invalidNameThrows'),
      Text('Assertions: $assertionCount'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
