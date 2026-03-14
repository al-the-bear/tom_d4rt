// D4rt test script: Tests StretchMode from material
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<StretchMode> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeStretchMode() {
  print('StretchMode: starting deep analysis');

  final values = StretchMode.values;
  assert(values.isNotEmpty, 'StretchMode should expose at least one enum value');

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('StretchMode: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = StretchMode.values[value.index];
    assert(fromIndex == value, 'Index lookup must resolve the same value for StretchMode');

    final fromName = StretchMode.values.byName(value.name);
    assert(fromName == value, 'byName must resolve the same value for StretchMode');

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(toStringContainsName, 'toString should contain the enum name for StretchMode');
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(uniqueNames.length == names.length, 'StretchMode enum names must be unique');
  assert(uniqueIndexes.length == indexes.length, 'StretchMode enum indexes must be unique');

  final isContiguousIndexing = indexes.first == 0 && indexes.last == values.length - 1;
  assert(isContiguousIndexing, 'StretchMode enum indexes should be contiguous and zero-based');

  var invalidNameThrows = false;
  try {
    StretchMode.values.byName('__invalid_stretchmode__');
  } catch (error) {
    invalidNameThrows = true;
    print('StretchMode: expected edge-case failure for invalid name -> $error');
  }
  assert(invalidNameThrows, 'StretchMode.values.byName should throw for invalid names');

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print('StretchMode: first=$first middle=$middle last=$last total=${values.length}');

  return <String, dynamic>{
    'enumType': 'StretchMode',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage': 'StretchMode has implicit enum constructors; instance creation is validated via values traversal',
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
  print('StretchMode test executing');

  final summary = _analyzeStretchMode();

  assert(summary['valueCount'] is int, 'StretchMode summary must expose integer valueCount');
  assert((summary['valueCount'] as int) > 0, 'StretchMode must have one or more values');
  assert(summary['orderChecksPassed'] == true, 'StretchMode order checks must pass');
  assert(summary['invalidNameThrows'] == true, 'StretchMode invalid-name edge case must throw');

  print('StretchMode summary -> $summary');
  print('StretchMode test completed');

  return _buildSummaryWidget(summary);
}
