// D4rt test script: Tests MaterialBannerClosedReason from material
import 'package:flutter/material.dart';

List<String> _collectValueNames(List<MaterialBannerClosedReason> values) {
  final names = <String>[];
  for (final value in values) {
    names.add(value.name);
  }
  return names;
}

Map<String, dynamic> _analyzeMaterialBannerClosedReason() {
  print('MaterialBannerClosedReason: starting deep analysis');

  final values = MaterialBannerClosedReason.values;
  assert(values.isNotEmpty, 'MaterialBannerClosedReason should expose at least one enum value');

  final names = _collectValueNames(values);
  final indexes = <int>[];
  final orderChecks = <bool>[];

  for (final value in values) {
    print('MaterialBannerClosedReason: value=${value.name} index=${value.index} raw=$value');
    indexes.add(value.index);

    final fromIndex = MaterialBannerClosedReason.values[value.index];
    assert(fromIndex == value, 'Index lookup must resolve the same value for MaterialBannerClosedReason');

    final fromName = MaterialBannerClosedReason.values.byName(value.name);
    assert(fromName == value, 'byName must resolve the same value for MaterialBannerClosedReason');

    final toStringContainsName = value.toString().contains(value.name);
    orderChecks.add(toStringContainsName);
    assert(toStringContainsName, 'toString should contain the enum name for MaterialBannerClosedReason');
  }

  final uniqueNames = names.toSet();
  final uniqueIndexes = indexes.toSet();
  assert(uniqueNames.length == names.length, 'MaterialBannerClosedReason enum names must be unique');
  assert(uniqueIndexes.length == indexes.length, 'MaterialBannerClosedReason enum indexes must be unique');

  final isContiguousIndexing = indexes.first == 0 && indexes.last == values.length - 1;
  assert(isContiguousIndexing, 'MaterialBannerClosedReason enum indexes should be contiguous and zero-based');

  var invalidNameThrows = false;
  try {
    MaterialBannerClosedReason.values.byName('__invalid_materialbannerclosedreason__');
  } catch (error) {
    invalidNameThrows = true;
    print('MaterialBannerClosedReason: expected edge-case failure for invalid name -> $error');
  }
  assert(invalidNameThrows, 'MaterialBannerClosedReason.values.byName should throw for invalid names');

  final first = values.first;
  final last = values.last;
  final middle = values.length > 2 ? values[values.length ~/ 2] : first;

  print('MaterialBannerClosedReason: first=$first middle=$middle last=$last total=${values.length}');

  return <String, dynamic>{
    'enumType': 'MaterialBannerClosedReason',
    'valueCount': values.length,
    'first': first.name,
    'middle': middle.name,
    'last': last.name,
    'namesJoined': names.join(','),
    'orderChecksPassed': orderChecks.every((entry) => entry),
    'invalidNameThrows': invalidNameThrows,
    'indexRange': '${indexes.first}..${indexes.last}',
    'constructorCoverage': 'MaterialBannerClosedReason has implicit enum constructors; instance creation is validated via values traversal',
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
  print('MaterialBannerClosedReason test executing');

  final summary = _analyzeMaterialBannerClosedReason();

  assert(summary['valueCount'] is int, 'MaterialBannerClosedReason summary must expose integer valueCount');
  assert((summary['valueCount'] as int) > 0, 'MaterialBannerClosedReason must have one or more values');
  assert(summary['orderChecksPassed'] == true, 'MaterialBannerClosedReason order checks must pass');
  assert(summary['invalidNameThrows'] == true, 'MaterialBannerClosedReason invalid-name edge case must throw');

  print('MaterialBannerClosedReason summary -> $summary');
  print('MaterialBannerClosedReason test completed');

  return _buildSummaryWidget(summary);
}
