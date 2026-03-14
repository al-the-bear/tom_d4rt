// D4rt test script: Tests ScriptCategory from material
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<ScriptCategory> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeScriptCategory() {
  print('ScriptCategory: starting deep analysis');

  final values = ScriptCategory.values;
  assert(values.isNotEmpty, 'ScriptCategory should expose at least one enum value');

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('ScriptCategory: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = ScriptCategory.values[value.index];
    assert(fromIndex == value, 'Index lookup must resolve the same value for ScriptCategory');

    final fromName = ScriptCategory.values.byName(value.name);
    assert(fromName == value, 'byName must resolve the same value for ScriptCategory');

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(toStringContainsName, 'toString should contain the enum name for ScriptCategory');
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(uniqueNames.length == names.length, 'ScriptCategory enum names must be unique');
  assert(uniqueIndexes.length == indexes.length, 'ScriptCategory enum indexes must be unique');

  final isContiguousIndexing = indexes.first == 0 && indexes.last == values.length - 1;
  assert(isContiguousIndexing, 'ScriptCategory enum indexes should be contiguous and zero-based');

  var invalidNameThrows = false;
  try {
    ScriptCategory.values.byName('__invalid_scriptcategory__');
  } catch (error) {
    invalidNameThrows = true;
    print('ScriptCategory: expected edge-case failure for invalid name -> $error');
  }
  assert(invalidNameThrows, 'ScriptCategory.values.byName should throw for invalid names');

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print('ScriptCategory: first=$first middle=$middle last=$last total=${values.length}');

  return <String, dynamic>{
    'enumType': 'ScriptCategory',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage': 'ScriptCategory has implicit enum constructors; instance creation is validated via values traversal',
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
  print('ScriptCategory test executing');

  final summary = _analyzeScriptCategory();

  assert(summary['valueCount'] is int, 'ScriptCategory summary must expose integer valueCount');
  assert((summary['valueCount'] as int) > 0, 'ScriptCategory must have one or more values');
  assert(summary['orderChecksPassed'] == true, 'ScriptCategory order checks must pass');
  assert(summary['invalidNameThrows'] == true, 'ScriptCategory invalid-name edge case must throw');

  print('ScriptCategory summary -> $summary');
  print('ScriptCategory test completed');

  return _buildSummaryWidget(summary);
}
