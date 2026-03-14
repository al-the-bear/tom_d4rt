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
    _expectCondition(
      values[index].index == index,
      'Contiguous index at $index',
    );
  }
}

dynamic build(BuildContext context) {
  print('--- TextLeadingDistribution comprehensive test start ---');

  final values = TextLeadingDistribution.values;
  final names = values.map((value) => value.name).toList(growable: false);
  final indexes = values.map((value) => value.index).toList(growable: false);
  final indexMap = _buildIndexMap(values);

  print('TextLeadingDistribution values count: ${values.length}');
  print('TextLeadingDistribution names: $names');
  print('TextLeadingDistribution indexes: $indexes');
  print('TextLeadingDistribution details:\n${_formatEnumValues(values)}');

  _expectCondition(
    values.isNotEmpty,
    'TextLeadingDistribution has at least one value',
  );
  _expectCondition(
    names.length == values.length,
    'Names length matches values length',
  );
  _expectCondition(
    indexes.length == values.length,
    'Indexes length matches values length',
  );
  _expectCondition(
    indexMap.length == values.length,
    'Index map covers all TextLeadingDistribution values',
  );
  _expectCondition(
    names.toSet().length == names.length,
    'TextLeadingDistribution names are unique',
  );
  _expectCondition(
    indexes.toSet().length == indexes.length,
    'TextLeadingDistribution indexes are unique',
  );
  _expectCondition(
    indexes.first == 0,
    'First TextLeadingDistribution index is 0',
  );
  _expectCondition(
    indexes.last == values.length - 1,
    'Last TextLeadingDistribution index is values.length - 1',
  );

  _validateRoundTripByIndex(values);

  final first = values.first;
  final last = values.last;

  print(
    'First TextLeadingDistribution: $first (${first.name}, ${first.index})',
  );
  print('Last TextLeadingDistribution: $last (${last.name}, ${last.index})');

  _expectCondition(
    TextLeadingDistribution.values.byName(first.name) == first,
    'byName resolves first TextLeadingDistribution',
  );
  _expectCondition(
    TextLeadingDistribution.values.byName(last.name) == last,
    'byName resolves last TextLeadingDistribution',
  );
  _expectCondition(
    indexMap[first.index] == first,
    'Index map resolves first TextLeadingDistribution',
  );
  _expectCondition(
    indexMap[last.index] == last,
    'Index map resolves last TextLeadingDistribution',
  );
  _expectCondition(
    first == TextLeadingDistribution.values[first.index],
    'First TextLeadingDistribution round-trips from index',
  );
  _expectCondition(
    last == TextLeadingDistribution.values[last.index],
    'Last TextLeadingDistribution round-trips from index',
  );
  _expectCondition(
    first.toString().contains(first.name),
    'first.toString contains name',
  );
  _expectCondition(
    last.toString().contains(last.name),
    'last.toString contains name',
  );
  _expectCondition(
    first == first,
    'Reflexive equality for first TextLeadingDistribution',
  );
  _expectCondition(
    last == last,
    'Reflexive equality for last TextLeadingDistribution',
  );

  bool invalidNameThrows = false;
  try {
    TextLeadingDistribution.values.byName(
      '__invalid_text_leading_distribution__',
    );
  } catch (error) {
    invalidNameThrows = true;
    print('Expected TextLeadingDistribution byName failure: $error');
  }
  _expectCondition(
    invalidNameThrows,
    'Invalid byName throws for TextLeadingDistribution',
  );

  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _expectCondition(
    sortedByIndex.join('|') == values.join('|'),
    'Sorting by index preserves TextLeadingDistribution order',
  );

  final summary =
      'TextLeadingDistribution summary -> count=${values.length}, first=${first.name}, last=${last.name}, invalidLookupThrows=$invalidNameThrows';
  print(summary);
  print('--- TextLeadingDistribution comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextLeadingDistribution Comprehensive Tests'),
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
