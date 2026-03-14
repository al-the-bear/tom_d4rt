// D4rt test script: Comprehensive tests for KeyEventDeviceType from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _formatEnumValues(List<KeyEventDeviceType> values) {
  final buffer = StringBuffer();
  for (final value in values) {
    buffer.writeln(' - ${value.index}: ${value.name} => $value');
  }
  return buffer.toString();
}

void _validateRoundTripByIndex(List<KeyEventDeviceType> values) {
  for (var index = 0; index < values.length; index++) {
    final fromList = values[index];
    final fromIndex = KeyEventDeviceType.values[index];
    _expectCondition(fromList == fromIndex, 'Round-trip by index works at $index');
  }
}

Map<int, KeyEventDeviceType> _buildIndexMap(List<KeyEventDeviceType> values) {
  final map = <int, KeyEventDeviceType>{};
  for (final value in values) {
    map[value.index] = value;
  }
  return map;
}

dynamic build(BuildContext context) {
  print('--- KeyEventDeviceType test start ---');

  final values = KeyEventDeviceType.values;
  final names = values.map((value) => value.name).toList(growable: false);
  final indexes = values.map((value) => value.index).toList(growable: false);
  final indexMap = _buildIndexMap(values);

  print('KeyEventDeviceType.values length: ${values.length}');
  print('KeyEventDeviceType names: $names');
  print('KeyEventDeviceType indexes: $indexes');
  print('KeyEventDeviceType detailed values:
${_formatEnumValues(values)}');

  _expectCondition(values.isNotEmpty, 'KeyEventDeviceType has at least one value');
  _expectCondition(names.length == values.length, 'Name list aligns with values length');
  _expectCondition(indexes.length == values.length, 'Index list aligns with values length');
  _expectCondition(indexMap.length == values.length, 'Index map has all enum values');
  _expectCondition(names.toSet().length == names.length, 'All enum names are unique');
  _expectCondition(indexes.toSet().length == indexes.length, 'All enum indexes are unique');
  _expectCondition(indexes.first == 0, 'First enum index is 0');
  _expectCondition(indexes.last == values.length - 1, 'Last index matches values.length - 1');

  for (var i = 0; i < indexes.length; i++) {
    _expectCondition(indexes[i] == i, 'Index sequence is contiguous at position $i');
  }

  final first = values.first;
  final last = values.last;

  print('First KeyEventDeviceType value: $first (${first.name}, ${first.index})');
  print('Last KeyEventDeviceType value: $last (${last.name}, ${last.index})');

  _expectCondition(KeyEventDeviceType.values.byName(first.name) == first, 'byName resolves first value');
  _expectCondition(KeyEventDeviceType.values.byName(last.name) == last, 'byName resolves last value');
  _expectCondition(indexMap[first.index] == first, 'Index map resolves first value');
  _expectCondition(indexMap[last.index] == last, 'Index map resolves last value');
  _expectCondition(first == KeyEventDeviceType.values[first.index], 'First value round-trips from index');
  _expectCondition(last == KeyEventDeviceType.values[last.index], 'Last value round-trips from index');
  _expectCondition(first.toString().contains(first.name), 'toString contains first name');
  _expectCondition(last.toString().contains(last.name), 'toString contains last name');
  _expectCondition(first == first, 'Reflexive equality for first value');
  _expectCondition(first.hashCode == first.hashCode, 'Stable hashCode for first value');

  _validateRoundTripByIndex(values);

  bool invalidNameThrows = false;
  try {
    KeyEventDeviceType.values.byName('__not_a_valid_keyeventdevicetype_name__');
  } catch (error) {
    invalidNameThrows = true;
    print('Expected byName failure captured for KeyEventDeviceType: $error');
  }
  _expectCondition(invalidNameThrows, 'Invalid byName lookup throws for KeyEventDeviceType');

  final sorted = [...values]..sort((a, b) => a.index.compareTo(b.index));
  _expectCondition(sorted.join('|') == values.join('|'), 'Sorting by index preserves declaration order');

  final summary =
      'KeyEventDeviceType summary -> count=${values.length}, first=${first.name}, last=${last.name}';
  print(summary);
  print('--- KeyEventDeviceType test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('KeyEventDeviceType Comprehensive Tests'),
        Text('Count: ${values.length}'),
        Text('First: ${first.name} (${first.index})'),
        Text('Last: ${last.name} (${last.index})'),
        Text('Unique names: ${names.toSet().length}'),
        Text('Unique indexes: ${indexes.toSet().length}'),
        Text('Invalid lookup throws: $invalidNameThrows'),
        Text(summary),
        for (final value in values.take(8))
          Text('${value.index}: ${value.name} -> $value'),
      ],
    ),
  );
}
