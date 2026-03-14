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
  print('--- TextDecorationStyle comprehensive test start ---');

  final values = TextDecorationStyle.values;
  final names = values.map((value) => value.name).toList(growable: false);
  final indexes = values.map((value) => value.index).toList(growable: false);
  final indexMap = _buildIndexMap(values);

  print('TextDecorationStyle values count: ${values.length}');
  print('TextDecorationStyle names: $names');
  print('TextDecorationStyle indexes: $indexes');
  print('TextDecorationStyle details:\n${_formatEnumValues(values)}');

  _expectCondition(values.isNotEmpty, 'TextDecorationStyle has at least one value');
  _expectCondition(names.length == values.length, 'Names length matches values length');
  _expectCondition(indexes.length == values.length, 'Indexes length matches values length');
  _expectCondition(indexMap.length == values.length, 'Index map covers all TextDecorationStyle values');
  _expectCondition(names.toSet().length == names.length, 'TextDecorationStyle names are unique');
  _expectCondition(indexes.toSet().length == indexes.length, 'TextDecorationStyle indexes are unique');
  _expectCondition(indexes.first == 0, 'First TextDecorationStyle index is 0');
  _expectCondition(indexes.last == values.length - 1, 'Last TextDecorationStyle index is values.length - 1');

  _validateRoundTripByIndex(values);

  final first = values.first;
  final last = values.last;

  print('First TextDecorationStyle: $first (${first.name}, ${first.index})');
  print('Last TextDecorationStyle: $last (${last.name}, ${last.index})');

  _expectCondition(TextDecorationStyle.values.byName(first.name) == first, 'byName resolves first TextDecorationStyle');
  _expectCondition(TextDecorationStyle.values.byName(last.name) == last, 'byName resolves last TextDecorationStyle');
  _expectCondition(indexMap[first.index] == first, 'Index map resolves first TextDecorationStyle');
  _expectCondition(indexMap[last.index] == last, 'Index map resolves last TextDecorationStyle');
  _expectCondition(first == TextDecorationStyle.values[first.index], 'First TextDecorationStyle round-trips from index');
  _expectCondition(last == TextDecorationStyle.values[last.index], 'Last TextDecorationStyle round-trips from index');
  _expectCondition(first.toString().contains(first.name), 'first.toString contains name');
  _expectCondition(last.toString().contains(last.name), 'last.toString contains name');
  _expectCondition(first == first, 'Reflexive equality for first TextDecorationStyle');
  _expectCondition(last == last, 'Reflexive equality for last TextDecorationStyle');

  bool invalidNameThrows = false;
  try {
    TextDecorationStyle.values.byName('__invalid_text_decoration_style__');
  } catch (error) {
    invalidNameThrows = true;
    print('Expected TextDecorationStyle byName failure: $error');
  }
  _expectCondition(invalidNameThrows, 'Invalid byName throws for TextDecorationStyle');

  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _expectCondition(sortedByIndex.join('|') == values.join('|'), 'Sorting by index preserves TextDecorationStyle order');

  final summary =
      'TextDecorationStyle summary -> count=${values.length}, first=${first.name}, last=${last.name}, invalidLookupThrows=$invalidNameThrows';
  print(summary);
  print('--- TextDecorationStyle comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextDecorationStyle Comprehensive Tests'),
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
