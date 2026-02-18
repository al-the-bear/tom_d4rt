/// Demonstrates Dart spread operators
///
/// Features covered:
/// - Spread operator (...)
/// - Null-aware spread (...?)
library;

// Helper functions to prevent compile-time optimization
List<int>? getList(List<int>? l) => l;
Map<String, int>? getMap(Map<String, int>? m) => m;
String? getString(String? s) => s;
bool getBool(bool b) => b;

void main() {
  print('=== Spread Operators ===');
  print('');

  // Basic spread in List
  print('--- Spread in Lists ---');
  var list1 = [1, 2, 3];
  var list2 = [4, 5, 6];
  var combined = [...list1, ...list2];
  print('list1: $list1');
  print('list2: $list2');
  print('[...list1, ...list2]: $combined');

  // Spread with additional elements
  var extended = [0, ...list1, 100];
  print('[0, ...list1, 100]: $extended');

  // Copying a list
  var original = [1, 2, 3];
  var copy = [...original];
  copy.add(4);
  print('');
  print('original: $original');
  print('copy (modified): $copy');

  // Spread in Sets
  print('');
  print('--- Spread in Sets ---');
  var set1 = {1, 2, 3};
  var set2 = {3, 4, 5};
  var combinedSet = {...set1, ...set2}; // Duplicates removed
  print('set1: $set1');
  print('set2: $set2');
  print('{...set1, ...set2}: $combinedSet');

  // Spread in Maps
  print('');
  print('--- Spread in Maps ---');
  var map1 = {'a': 1, 'b': 2};
  var map2 = {'c': 3, 'd': 4};
  var combinedMap = {...map1, ...map2};
  print('map1: $map1');
  print('map2: $map2');
  print('{...map1, ...map2}: $combinedMap');

  // Map spread with overwriting
  var defaults = {'host': 'localhost', 'port': 8080, 'debug': false};
  var overrides = {'port': 3000, 'debug': true};
  var config = {...defaults, ...overrides}; // overrides win
  print('');
  print('defaults: $defaults');
  print('overrides: $overrides');
  print('merged config: $config');

  // Null-aware spread
  print('');
  print('--- Null-Aware Spread (...?) ---');

  List<int>? maybeList = getList([4, 5, 6]);
  var result = [1, 2, 3, ...?maybeList];
  print('maybeList: $maybeList');
  print('[1, 2, 3, ...?maybeList]: $result');

  maybeList = getList(null);
  result = [1, 2, 3, ...?maybeList];
  print('maybeList (null): $maybeList');
  print('[1, 2, 3, ...?maybeList]: $result');

  // Null-aware with maps
  Map<String, int>? maybeMap = getMap({'x': 10});
  var mapResult = {'a': 1, ...?maybeMap};
  print('');
  print('maybeMap: $maybeMap');
  print('{a: 1, ...?maybeMap}: $mapResult');

  maybeMap = getMap(null);
  mapResult = {'a': 1, ...?maybeMap};
  print('maybeMap (null): $maybeMap');
  print('{a: 1, ...?maybeMap}: $mapResult');

  // Practical examples
  print('');
  print('--- Practical Examples ---');

  // Building UI children
  var header = [Text('Header')];
  var content = [Text('Content 1'), Text('Content 2')];
  var footer = [Text('Footer')];
  var page = [...header, ...content, ...footer];
  print('Page widgets: $page');

  // Conditional spreading
  bool includeDebug = true;
  var features = [
    'core',
    'networking',
    if (includeDebug) ...[
      'debug_panel',
      'logging',
    ],
    'ui',
  ];
  print('');
  print('Features (with debug): $features');

  includeDebug = getBool(false);
  features = [
    'core',
    'networking',
    if (includeDebug) ...[
      'debug_panel',
      'logging',
    ],
    'ui',
  ];
  print('Features (without debug): $features');

  // Building query parameters
  var baseParams = {'page': '1', 'limit': '10'};
  String? searchTerm = getString('dart');
  var queryParams = {
    ...baseParams,
    if (searchTerm != null) 'search': searchTerm,
  };
  print('');
  print('Query params: $queryParams');

  // Flattening nested lists
  var nested = [
    [1, 2],
    [3, 4],
    [5, 6]
  ];
  var flat = [for (var inner in nested) ...inner];
  print('');
  print('Nested: $nested');
  print('Flattened: $flat');

  // Deduplicating with set spread
  var listWithDupes = [1, 2, 2, 3, 3, 3, 4];
  var unique = {...listWithDupes}.toList();
  print('');
  print('With duplicates: $listWithDupes');
  print('Unique: $unique');

  print('');
  print('=== End of Spread Operators Demo ===');
}

class Text {
  final String content;
  Text(this.content);

  @override
  String toString() => 'Text($content)';
}
