// D4rt test script: Tests RefreshIndicatorStatus from material
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<RefreshIndicatorStatus> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeRefreshIndicatorStatus() {
  print('RefreshIndicatorStatus: starting deep analysis');

  final values = RefreshIndicatorStatus.values;
  assert(values.isNotEmpty, 'RefreshIndicatorStatus should expose at least one enum value');

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('RefreshIndicatorStatus: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = RefreshIndicatorStatus.values[value.index];
    assert(fromIndex == value, 'Index lookup must resolve the same value for RefreshIndicatorStatus');

    final fromName = RefreshIndicatorStatus.values.byName(value.name);
    assert(fromName == value, 'byName must resolve the same value for RefreshIndicatorStatus');

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(toStringContainsName, 'toString should contain the enum name for RefreshIndicatorStatus');
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(uniqueNames.length == names.length, 'RefreshIndicatorStatus enum names must be unique');
  assert(uniqueIndexes.length == indexes.length, 'RefreshIndicatorStatus enum indexes must be unique');

  final isContiguousIndexing = indexes.first == 0 && indexes.last == values.length - 1;
  assert(isContiguousIndexing, 'RefreshIndicatorStatus enum indexes should be contiguous and zero-based');

  var invalidNameThrows = false;
  try {
    RefreshIndicatorStatus.values.byName('__invalid_refreshindicatorstatus__');
  } catch (error) {
    invalidNameThrows = true;
    print('RefreshIndicatorStatus: expected edge-case failure for invalid name -> $error');
  }
  assert(invalidNameThrows, 'RefreshIndicatorStatus.values.byName should throw for invalid names');

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print('RefreshIndicatorStatus: first=$first middle=$middle last=$last total=${values.length}');

  return <String, dynamic>{
    'enumType': 'RefreshIndicatorStatus',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage': 'RefreshIndicatorStatus has implicit enum constructors; instance creation is validated via values traversal',
    'propertyCoverage': 'name, index, values, byName, toString',
    'behaviorCoverage': 'lookup, ordering, identity, uniqueness',
    'edgeCoverage': 'invalid byName path throws as expected',
  };
}

Widget _buildSummaryWidget(Map<String, dynamic> summary) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Summary for ${summary['enumType']}'),
      Text('Values: ${summary['valueCount']}'),
      Text('First: ${summary['first']}'),
      Text('Middle: ${summary['middle']}'),
      Text('Last: ${summary['last']}'),
      Text('Index range: ${summary['indexRange']}'),
      Text('Order checks passed: ${summary['orderChecksPassed']}'),
      Text('Invalid name throws: ${summary['invalidNameThrows']}'),
      Text('Constructor coverage: ${summary['constructorCoverage']}'),
      Text('Property coverage: ${summary['propertyCoverage']}'),
      Text('Behavior coverage: ${summary['behaviorCoverage']}'),
      Text('Edge coverage: ${summary['edgeCoverage']}'),
      Text('Names: ${summary['namesJoined']}'),
    ],
  );
}

dynamic build(BuildContext context) {
  print('RefreshIndicatorStatus test executing');

  final summary = _analyzeRefreshIndicatorStatus();

  assert(summary['valueCount'] is int, 'RefreshIndicatorStatus summary must expose integer valueCount');
  assert((summary['valueCount'] as int) > 0, 'RefreshIndicatorStatus must have one or more values');
  assert(summary['orderChecksPassed'] == true, 'RefreshIndicatorStatus order checks must pass');
  assert(summary['invalidNameThrows'] == true, 'RefreshIndicatorStatus invalid-name edge case must throw');

  print('RefreshIndicatorStatus summary -> $summary');
  print('RefreshIndicatorStatus test completed');

  return _buildSummaryWidget(summary);
}
