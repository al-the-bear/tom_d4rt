// D4rt test script: Tests HourFormat from material
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<HourFormat> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeHourFormat() {
  print('HourFormat: starting deep analysis');

  final values = HourFormat.values;
  assert(values.isNotEmpty, 'HourFormat should expose at least one enum value');

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('HourFormat: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = HourFormat.values[value.index];
    assert(fromIndex == value, 'Index lookup must resolve the same value for HourFormat');

    final fromName = HourFormat.values.byName(value.name);
    assert(fromName == value, 'byName must resolve the same value for HourFormat');

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(toStringContainsName, 'toString should contain the enum name for HourFormat');
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(uniqueNames.length == names.length, 'HourFormat enum names must be unique');
  assert(uniqueIndexes.length == indexes.length, 'HourFormat enum indexes must be unique');

  final isContiguousIndexing = indexes.first == 0 && indexes.last == values.length - 1;
  assert(isContiguousIndexing, 'HourFormat enum indexes should be contiguous and zero-based');

  var invalidNameThrows = false;
  try {
    HourFormat.values.byName('__invalid_hourformat__');
  } catch (error) {
    invalidNameThrows = true;
    print('HourFormat: expected edge-case failure for invalid name -> $error');
  }
  assert(invalidNameThrows, 'HourFormat.values.byName should throw for invalid names');

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print('HourFormat: first=$first middle=$middle last=$last total=${values.length}');

  return <String, dynamic>{
    'enumType': 'HourFormat',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage': 'HourFormat has implicit enum constructors; instance creation is validated via values traversal',
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
  print('HourFormat test executing');

  final summary = _analyzeHourFormat();

  assert(summary['valueCount'] is int, 'HourFormat summary must expose integer valueCount');
  assert((summary['valueCount'] as int) > 0, 'HourFormat must have one or more values');
  assert(summary['orderChecksPassed'] == true, 'HourFormat order checks must pass');
  assert(summary['invalidNameThrows'] == true, 'HourFormat invalid-name edge case must throw');

  print('HourFormat summary -> $summary');
  print('HourFormat test completed');

  return _buildSummaryWidget(summary);
}
