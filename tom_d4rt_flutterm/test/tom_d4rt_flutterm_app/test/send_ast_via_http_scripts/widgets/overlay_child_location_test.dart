// D4rt comprehensive test script: OverlayChildLocation from widgets
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message) {
  if (!condition) {
    print('❌ $message');
    throw StateError('OverlayChildLocation test failed: $message');
  }
  print('✅ $message');
}

String _line(String key, Object value) => '$key: $value';

List<String> _collectDiagnostics(List<OverlayChildLocation> values) {
  final names = values.map((v) => v.name).toList(growable: false);
  final indices = values.map((v) => v.index).toList(growable: false);
  return <String>[
    _line('enum', 'OverlayChildLocation'),
    _line('count', values.length),
    _line('names', names.join(', ')),
    _line('indices', indices.join(', ')),
    _line('first', values.first),
    _line('last', values.last),
  ];
}

dynamic build(BuildContext context) {
  print('========== OverlayChildLocation comprehensive test start ==========' );

  final List<OverlayChildLocation> values = OverlayChildLocation.values.toList(growable: false);
  _expect(values.isNotEmpty, 'OverlayChildLocation exposes at least one enum value');
  _expect(
    values.length == OverlayChildLocation.values.length,
    'OverlayChildLocation.values list length is consistent',
  );

  final OverlayChildLocation first = values.first;
  final OverlayChildLocation last = values.last;

  print(_line('runtimeType', OverlayChildLocation));
  print(_line('firstName', first.name));
  print(_line('firstIndex', first.index));
  print(_line('lastName', last.name));
  print(_line('lastIndex', last.index));
  print(
    'Constructor coverage: enum instances are created by framework internals and validated through values traversal.',
  );

  final List<String> names = values.map((v) => v.name).toList(growable: false);
  final List<int> indices = values.map((v) => v.index).toList(growable: false);
  final Set<String> uniqueNames = names.toSet();
  final Set<int> uniqueIndices = indices.toSet();

  _expect(uniqueNames.length == names.length, 'all enum names are unique');
  _expect(uniqueIndices.length == indices.length, 'all enum indices are unique');
  _expect(indices.first == 0, 'first enum index starts at zero');

  for (final value in values) {
    print('Inspecting value => name=${value.name}, index=${value.index}, raw=$value');
    _expect(
      OverlayChildLocation.values[value.index] == value,
      'index lookup round-trip works for $value',
    );
    _expect(value.toString().contains('.'), 'toString has qualified enum format for $value');
  }

  for (final name in names) {
    final parsed = OverlayChildLocation.values.byName(name);
    _expect(parsed.name == name, 'byName resolves exact name "$name"');
  }

  bool byNameThrows = false;
  try {
    OverlayChildLocation.values.byName('__invalid_enum_name__');
  } catch (error) {
    byNameThrows = true;
    print('Expected byName edge-case error: $error');
  }
  _expect(byNameThrows, 'byName throws on an unknown name');

  bool rangeThrows = false;
  try {
    values[values.length];
  } catch (error) {
    rangeThrows = true;
    print('Expected range edge-case error: $error');
  }
  _expect(rangeThrows, 'list indexing throws for out-of-range access');

  final List<OverlayChildLocation> reversed = values.reversed.toList(growable: false);
  _expect(reversed.first == last, 'reversed list starts with original last');
  _expect(reversed.last == first, 'reversed list ends with original first');

  final List<OverlayChildLocation> sorted = [...values]
    ..sort((a, b) => a.index.compareTo(b.index));
  _expect(sorted.length == values.length, 'sorted list preserves all entries');
  for (var i = 0; i < sorted.length; i++) {
    _expect(sorted[i] == values[i], 'sorted order matches declaration order at index $i');
  }

  final Map<String, OverlayChildLocation> asMap = {
    for (final value in values) value.name: value,
  };
  _expect(asMap.length == values.length, 'name map includes all enum values');
  _expect(asMap[first.name] == first, 'name map resolves first enum value');
  _expect(asMap[last.name] == last, 'name map resolves last enum value');

  final diagnostics = _collectDiagnostics(values);
  print('Diagnostics output:');
  for (final row in diagnostics) {
    print('  $row');
  }

  final String summary = 'OverlayChildLocation checks passed: ${values.length} values validated';
  print(summary);
  print('========== OverlayChildLocation comprehensive test end ==========' );

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('OverlayChildLocation Comprehensive Tests'),
          Text('Count: ${values.length}'),
          Text('First: $first (index: ${first.index})'),
          Text('Last: $last (index: ${last.index})'),
          Text('Unique names: ${uniqueNames.length}'),
          Text('Unique indices: ${uniqueIndices.length}'),
          Text('Summary: $summary'),
        ],
      ),
    ),
  );
}
