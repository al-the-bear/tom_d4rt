import 'dart:ui';
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _formatEnumValues<T extends Enum>(List<T> values) {
  final buffer = StringBuffer();
  for (final value in values) {
    buffer.writeln(' - ${value.index}: ${value.name} => $value');
  }
  return buffer.toString();
}

Map<int, T> _buildIndexMap<T extends Enum>(List<T> values) {
  final map = <int, T>{};
  for (final value in values) {
    map[value.index] = value;
  }
  return map;
}

void _validateRoundTripByIndex<T extends Enum>(List<T> values) {
  for (var index = 0; index < values.length; index++) {
    _expectCondition(values[index].index == index, 'Contiguous index at $index');
  }
}

dynamic build(BuildContext context) {
  print('--- TextAffinity comprehensive test start ---');

  final values = TextAffinity.values;
  final names = values.map((value) => value.name).toList(growable: false);
  final indexes = values.map((value) => value.index).toList(growable: false);
  final indexMap = _buildIndexMap(values);

  print('TextAffinity values count: ${values.length}');
  print('TextAffinity names: $names');
  print('TextAffinity indexes: $indexes');
  print('TextAffinity details:\n${_formatEnumValues(values)}');

  _expectCondition(values.isNotEmpty, 'TextAffinity has at least one value');
  _expectCondition(names.length == values.length, 'Names length matches values length');
  _expectCondition(indexes.length == values.length, 'Indexes length matches values length');
  _expectCondition(indexMap.length == values.length, 'Index map covers all TextAffinity values');
  _expectCondition(names.toSet().length == names.length, 'TextAffinity names are unique');
  _expectCondition(indexes.toSet().length == indexes.length, 'TextAffinity indexes are unique');
  _expectCondition(indexes.first == 0, 'First TextAffinity index is 0');
  _expectCondition(indexes.last == values.length - 1, 'Last TextAffinity index is values.length - 1');

  _validateRoundTripByIndex(values);

  final first = values.first;
  final last = values.last;

  print('First TextAffinity: $first (${first.name}, ${first.index})');
  print('Last TextAffinity: $last (${last.name}, ${last.index})');

  _expectCondition(TextAffinity.values.byName(first.name) == first, 'byName resolves first TextAffinity');
  _expectCondition(TextAffinity.values.byName(last.name) == last, 'byName resolves last TextAffinity');
  _expectCondition(indexMap[first.index] == first, 'Index map resolves first TextAffinity');
  _expectCondition(indexMap[last.index] == last, 'Index map resolves last TextAffinity');
  _expectCondition(first == TextAffinity.values[first.index], 'First TextAffinity round-trips from index');
  _expectCondition(last == TextAffinity.values[last.index], 'Last TextAffinity round-trips from index');
  _expectCondition(first.toString().contains(first.name), 'first.toString contains name');
  _expectCondition(last.toString().contains(last.name), 'last.toString contains name');
  _expectCondition(first == first, 'Reflexive equality for first TextAffinity');
  _expectCondition(last == last, 'Reflexive equality for last TextAffinity');

  bool invalidNameThrows = false;
  try {
    TextAffinity.values.byName('__invalid_text_affinity__');
  } catch (error) {
    invalidNameThrows = true;
    print('Expected TextAffinity byName failure: $error');
  }
  _expectCondition(invalidNameThrows, 'Invalid byName throws for TextAffinity');

  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _expectCondition(sortedByIndex.join('|') == values.join('|'), 'Sorting by index preserves TextAffinity order');

  final summary =
      'TextAffinity summary -> count=${values.length}, first=${first.name}, last=${last.name}, invalidLookupThrows=$invalidNameThrows';
  print(summary);
  print('--- TextAffinity comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextAffinity Comprehensive Tests'),
        Text('Count: ${values.length}'),
        Text('First: ${first.name} (${first.index})'),
        Text('Last: ${last.name} (${last.index})'),
        Text('Unique names: ${names.toSet().length}'),
        Text('Unique indexes: ${indexes.toSet().length}'),
        Text('Invalid lookup throws: $invalidNameThrows'),
        Text(summary),
        for (final value in values)
          Text('${value.index}: ${value.name} -> $value'),
      ],
    ),
  );
}
