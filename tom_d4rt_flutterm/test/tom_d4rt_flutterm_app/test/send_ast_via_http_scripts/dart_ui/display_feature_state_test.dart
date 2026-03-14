import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  final List<String> logs = <String>[];

  void log(String message) {
    logs.add(message);
    print(message);
  }

  void expectCondition(bool condition, String description) {
    assert(condition, description);
    log('ASSERT PASS: $description');
  }

  log('=== DisplayFeatureState comprehensive test start ===');
  log('BuildContext type: ${context.runtimeType}');

  final List<ui.DisplayFeatureState> values = ui.DisplayFeatureState.values;
  expectCondition(values.isNotEmpty, 'DisplayFeatureState.values is not empty');
  expectCondition(
    values.toSet().length == values.length,
    'DisplayFeatureState.values contains unique entries',
  );

  final ui.DisplayFeatureState first = values.first;
  final ui.DisplayFeatureState last = values.last;

  log('Constructor-like checks (enum canonical instances)');
  expectCondition(
    first.runtimeType == ui.DisplayFeatureState,
    'First value runtimeType is DisplayFeatureState',
  );
  expectCondition(first.index == 0, 'First value has index 0');
  expectCondition(
    last.index == values.length - 1,
    'Last value index matches values.length - 1',
  );

  log('Property checks for every enum value');
  int runningNameLength = 0;
  for (final ui.DisplayFeatureState value in values) {
    log('Value -> name=${value.name}, index=${value.index}, repr=$value');
    expectCondition(value.name.isNotEmpty, '${value} has a non-empty name');
    expectCondition(value.index >= 0, '${value} index is non-negative');
    runningNameLength += value.name.length;
  }
  expectCondition(
    runningNameLength >= values.length,
    'Accumulated name length is plausible',
  );

  log('Behavior checks: mapping, ordering, and lookup');
  final Map<String, ui.DisplayFeatureState> byName =
      <String, ui.DisplayFeatureState>{
        for (final ui.DisplayFeatureState value in values) value.name: value,
      };
  expectCondition(
    byName.length == values.length,
    'Name map contains all enum values exactly once',
  );
  for (final ui.DisplayFeatureState value in values) {
    expectCondition(
      byName[value.name] == value,
      'Name lookup resolves ${value.name} correctly',
    );
  }

  final List<ui.DisplayFeatureState> sortedByIndex =
      <ui.DisplayFeatureState>[...values]..sort(
        (ui.DisplayFeatureState a, ui.DisplayFeatureState b) =>
            a.index - b.index,
      );
  bool orderMatches = true;
  for (int index = 0; index < values.length; index++) {
    if (values[index] != sortedByIndex[index]) {
      orderMatches = false;
      break;
    }
  }
  expectCondition(orderMatches, 'values order already matches index order');

  log('Edge-case checks');
  const String missingName = '__missing_display_feature_state__';
  expectCondition(
    !byName.containsKey(missingName),
    'Invalid name is absent from lookup map',
  );
  final int outOfRangeIndex = values.length + 99;
  final ui.DisplayFeatureState? safeLookup =
      outOfRangeIndex >= 0 && outOfRangeIndex < values.length
      ? values[outOfRangeIndex]
      : null;
  expectCondition(safeLookup == null, 'Out-of-range lookup returns null path');

  int checksum = 0;
  for (final ui.DisplayFeatureState value in values) {
    checksum += (value.index + 1) * (value.name.length + 7);
  }
  expectCondition(checksum > 0, 'Deterministic checksum is positive');
  log('Computed checksum: $checksum');

  final List<String> summary = <String>[
    'DisplayFeatureState summary',
    'count=${values.length}',
    'first=${first.name}',
    'last=${last.name}',
    'checksum=$checksum',
    'assertions=all_passed',
  ];
  for (final String line in summary) {
    log('SUMMARY: $line');
  }

  log('=== DisplayFeatureState comprehensive test completed ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: summary.map((String line) => Text(line)).toList(),
  );
}
