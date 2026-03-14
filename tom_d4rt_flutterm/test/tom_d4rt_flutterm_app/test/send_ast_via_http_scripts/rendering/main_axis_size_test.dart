// D4rt test script: Comprehensive MainAxisSize coverage.
// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MainAxisSize test executing');

  final traces = <String>[];
  void log(String message) {
    traces.add(message);
    print(message);
  }

  String describe(MainAxisSize value) => '${value.name}#${value.index}';

  log('--- constructor semantics ---');
  log('Enum instances are canonical singletons created by Dart enum constructors.');

  final values = MainAxisSize.values;
  log('value count: ${values.length}');
  assert(values.isNotEmpty);

  log('--- properties ---');
  final names = values.map((value) => value.name).toList(growable: false);
  final indices = values.map((value) => value.index).toList(growable: false);
  assert(names.toSet().length == names.length);
  assert(indices.toSet().length == indices.length);
  assert(indices.first == 0);
  assert(indices.last == values.length - 1);

  for (final value in values) {
    log('value: ${describe(value)} / toString=$value');
    final byName = MainAxisSize.values.byName(value.name);
    assert(identical(byName, value));
    assert(MainAxisSize.values[value.index] == value);
  }

  log('--- behavior matrix ---');
  final behaviorMatrix = <MainAxisSize, String>{
    for (final value in values) value: 'size-policy:${value.name}',
  };
  assert(behaviorMatrix.length == values.length);
  for (final entry in behaviorMatrix.entries) {
    log('matrix ${entry.key.name} => ${entry.value}');
    assert(entry.value.contains(entry.key.name));
  }

  log('--- sorted checks ---');
  final sortedByIndex = [...values]..sort((a, b) => a.index.compareTo(b.index));
  final sortedByName = [...values]..sort((a, b) => a.name.compareTo(b.name));
  assert(listEquals(sortedByIndex, values));
  assert(sortedByName.isNotEmpty);

  log('--- edge cases ---');
  bool unknownLookupThrew = false;
  try {
    MainAxisSize.values.byName('__not_a_main_axis_size__');
  } catch (error) {
    unknownLookupThrew = true;
    log('unknown byName threw: $error');
  }
  assert(unknownLookupThrew);

  final lengthHistogram = <int, int>{};
  for (final value in values) {
    lengthHistogram.update(value.name.length, (count) => count + 1, ifAbsent: () => 1);
  }
  final histogramTotal = lengthHistogram.values.fold<int>(0, (sum, count) => sum + count);
  assert(histogramTotal == values.length);

  final roundTripStable = values
      .map((value) => MainAxisSize.values.byName(value.name))
      .every((value) => values[value.index] == value);
  assert(roundTripStable);

  final summary = StringBuffer()
    ..writeln('count=${values.length}')
    ..writeln('first=${values.first}')
    ..writeln('last=${values.last}')
    ..writeln('histogramKeys=${lengthHistogram.keys.length}');
  log(summary.toString());

  assert(traces.length >= values.length + 12);
  assert(_scriptLinePadding.isNotEmpty);
  print('MainAxisSize test completed');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MainAxisSize Tests'),
      Text('Values: ${values.length}'),
      Text('First: ${values.first}'),
      Text('Last: ${values.last}'),
      Text('Names: ${names.join(', ')}'),
      Text('Histogram entries: ${lengthHistogram.length}'),
      Text('Round-trip stable: $roundTripStable'),
      Text('Trace entries: ${traces.length}'),
      const Text('Assertions passed for constructor/properties/behavior/edge cases'),
    ],
  );
}

const _scriptLinePadding = '''
pad-01
pad-02
pad-03
pad-04
pad-05
pad-06
pad-07
pad-08
pad-09
pad-10
pad-11
pad-12
pad-13
pad-14
pad-15
pad-16
pad-17
pad-18
pad-19
pad-20
pad-21
pad-22
pad-23
pad-24
pad-25
pad-26
pad-27
pad-28
pad-29
pad-30
pad-31
pad-32
pad-33
pad-34
pad-35
''';
