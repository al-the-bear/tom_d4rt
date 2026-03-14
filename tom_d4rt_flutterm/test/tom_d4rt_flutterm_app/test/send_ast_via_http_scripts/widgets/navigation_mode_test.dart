// D4rt comprehensive test script: NavigationMode from widgets
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message) {
  if (!condition) {
    print('❌ $message');
    throw StateError('NavigationMode test failed: $message');
  }
  print('✅ $message');
}

String _line(String key, Object value) => '$key: $value';

List<String> _collectDiagnostics(List<NavigationMode> values) {
  final names = values.map((v) => v.name).toList(growable: false);
  final indices = values.map((v) => v.index).toList(growable: false);
  return <String>[
    _line('enum', 'NavigationMode'),
    _line('count', values.length),
    _line('names', names.join(', ')),
    _line('indices', indices.join(', ')),
    _line('first', values.first),
    _line('last', values.last),
  ];
}

dynamic build(BuildContext context) {
  print('========== NavigationMode comprehensive test start ==========' );

  final List<NavigationMode> values = NavigationMode.values.toList(growable: false);
  _expect(values.isNotEmpty, 'NavigationMode exposes at least one enum value');
  _expect(
    values.length == NavigationMode.values.length,
    'NavigationMode.values list length is consistent',
  );

  final NavigationMode first = values.first;
  final NavigationMode last = values.last;

  print(_line('runtimeType', NavigationMode));
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
      NavigationMode.values[value.index] == value,
      'index lookup round-trip works for $value',
    );
    _expect(value.toString().contains('.'), 'toString has qualified enum format for $value');
  }

  for (final name in names) {
    final parsed = NavigationMode.values.byName(name);
    _expect(parsed.name == name, 'byName resolves exact name "$name"');
  }

  bool byNameThrows = false;
  try {
    NavigationMode.values.byName('__invalid_enum_name__');
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

  final List<NavigationMode> reversed = values.reversed.toList(growable: false);
  _expect(reversed.first == last, 'reversed list starts with original last');
  _expect(reversed.last == first, 'reversed list ends with original first');

  final List<NavigationMode> sorted = [...values]
    ..sort((a, b) => a.index.compareTo(b.index));
  _expect(sorted.length == values.length, 'sorted list preserves all entries');
  for (var i = 0; i < sorted.length; i++) {
    _expect(sorted[i] == values[i], 'sorted order matches declaration order at index $i');
  }

  final Map<String, NavigationMode> asMap = {
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

  final String summary = 'NavigationMode checks passed: ${values.length} values validated';
  print(summary);
  print('========== NavigationMode comprehensive test end ==========' );

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NavigationMode Comprehensive Tests'),
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
