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

  log('=== TraversalEdgeBehavior comprehensive test start ===');
  log('BuildContext type: ${context.runtimeType}');

  final List<TraversalEdgeBehavior> values = TraversalEdgeBehavior.values;
  expectCondition(
    values.isNotEmpty,
    'TraversalEdgeBehavior.values is not empty',
  );
  expectCondition(
    values.toSet().length == values.length,
    'TraversalEdgeBehavior.values contains unique entries',
  );

  final TraversalEdgeBehavior first = values.first;
  final TraversalEdgeBehavior last = values.last;

  log('Constructor-like checks (enum canonical instances)');
  expectCondition(
    first.runtimeType == TraversalEdgeBehavior,
    'First value runtimeType is TraversalEdgeBehavior',
  );
  expectCondition(first.index == 0, 'First value has index 0');
  expectCondition(
    last.index == values.length - 1,
    'Last value index matches values.length - 1',
  );

  log('Property checks for every enum value');
  int runningNameLength = 0;
  for (final TraversalEdgeBehavior value in values) {
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
  final Map<String, TraversalEdgeBehavior> byName =
      <String, TraversalEdgeBehavior>{
        for (final TraversalEdgeBehavior value in values) value.name: value,
      };
  expectCondition(
    byName.length == values.length,
    'Name map contains all enum values exactly once',
  );
  for (final TraversalEdgeBehavior value in values) {
    expectCondition(
      byName[value.name] == value,
      'Name lookup resolves ${value.name} correctly',
    );
  }

  final List<TraversalEdgeBehavior> sortedByIndex =
      <TraversalEdgeBehavior>[...values]..sort(
        (TraversalEdgeBehavior a, TraversalEdgeBehavior b) => a.index - b.index,
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
  const String missingName = '__missing_traversal_edge_behavior__';
  expectCondition(
    !byName.containsKey(missingName),
    'Invalid name is absent from lookup map',
  );
  final int outOfRangeIndex = values.length + 99;
  final TraversalEdgeBehavior? safeLookup =
      outOfRangeIndex >= 0 && outOfRangeIndex < values.length
      ? values[outOfRangeIndex]
      : null;
  expectCondition(safeLookup == null, 'Out-of-range lookup returns null path');

  int checksum = 0;
  for (final TraversalEdgeBehavior value in values) {
    checksum += (value.index + 1) * (value.name.length + 7);
  }
  expectCondition(checksum > 0, 'Deterministic checksum is positive');
  log('Computed checksum: $checksum');

  final List<String> summary = <String>[
    'TraversalEdgeBehavior summary',
    'count=${values.length}',
    'first=${first.name}',
    'last=${last.name}',
    'checksum=$checksum',
    'assertions=all_passed',
  ];
  for (final String line in summary) {
    log('SUMMARY: $line');
  }

  log('=== TraversalEdgeBehavior comprehensive test completed ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: summary.map((String line) => Text(line)).toList(),
  );
}
