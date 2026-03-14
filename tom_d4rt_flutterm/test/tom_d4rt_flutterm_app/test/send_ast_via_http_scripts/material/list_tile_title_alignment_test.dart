// D4rt test script: Tests ListTileTitleAlignment from material
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<ListTileTitleAlignment> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeListTileTitleAlignment() {
  print('ListTileTitleAlignment: starting deep analysis');

  final values = ListTileTitleAlignment.values;
  assert(values.isNotEmpty, 'ListTileTitleAlignment should expose at least one enum value');

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('ListTileTitleAlignment: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = ListTileTitleAlignment.values[value.index];
    assert(fromIndex == value, 'Index lookup must resolve the same value for ListTileTitleAlignment');

    final fromName = ListTileTitleAlignment.values.byName(value.name);
    assert(fromName == value, 'byName must resolve the same value for ListTileTitleAlignment');

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(toStringContainsName, 'toString should contain the enum name for ListTileTitleAlignment');
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(uniqueNames.length == names.length, 'ListTileTitleAlignment enum names must be unique');
  assert(uniqueIndexes.length == indexes.length, 'ListTileTitleAlignment enum indexes must be unique');

  final isContiguousIndexing = indexes.first == 0 && indexes.last == values.length - 1;
  assert(isContiguousIndexing, 'ListTileTitleAlignment enum indexes should be contiguous and zero-based');

  var invalidNameThrows = false;
  try {
    ListTileTitleAlignment.values.byName('__invalid_listtiletitlealignment__');
  } catch (error) {
    invalidNameThrows = true;
    print('ListTileTitleAlignment: expected edge-case failure for invalid name -> $error');
  }
  assert(invalidNameThrows, 'ListTileTitleAlignment.values.byName should throw for invalid names');

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print('ListTileTitleAlignment: first=$first middle=$middle last=$last total=${values.length}');

  return <String, dynamic>{
    'enumType': 'ListTileTitleAlignment',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage': 'ListTileTitleAlignment has implicit enum constructors; instance creation is validated via values traversal',
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
  print('ListTileTitleAlignment test executing');

  final summary = _analyzeListTileTitleAlignment();

  assert(summary['valueCount'] is int, 'ListTileTitleAlignment summary must expose integer valueCount');
  assert((summary['valueCount'] as int) > 0, 'ListTileTitleAlignment must have one or more values');
  assert(summary['orderChecksPassed'] == true, 'ListTileTitleAlignment order checks must pass');
  assert(summary['invalidNameThrows'] == true, 'ListTileTitleAlignment invalid-name edge case must throw');

  print('ListTileTitleAlignment summary -> $summary');
  print('ListTileTitleAlignment test completed');

  return _buildSummaryWidget(summary);
}
