/// Demonstrates Dart Map type
///
/// Features covered:
/// - Map creation (literal, constructor, fromEntries, fromIterables)
/// - Adding and removing entries
/// - Accessing values
/// - Map methods (update, putIfAbsent, containsKey)
/// - Iterating maps
library;

void main() {
  print('=== Map ===');
  print('');

  // Map creation
  print('--- Map Creation ---');
  var literal = {'a': 1, 'b': 2, 'c': 3};
  var empty = <String, int>{};
  var constructor = <String, int>{};
  var from = Map<String, int>.from({'x': 10, 'y': 20});
  var fromIterables = Map.fromIterables(['one', 'two'], [1, 2]);
  var fromEntries = Map.fromEntries([MapEntry('p', 100), MapEntry('q', 200)]);
  var unmodifiable = Map<String, int>.unmodifiable({'key': 42});

  print('literal: $literal');
  print('empty: $empty');
  print('constructor: $constructor');
  print('from: $from');
  print('fromIterables: $fromIterables');
  print('fromEntries: $fromEntries');
  print('unmodifiable: $unmodifiable');

  // Accessing values
  print('');
  print('--- Accessing Values ---');
  var scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  print('scores: $scores');
  print("scores['Alice']: ${scores['Alice']}");
  print("scores['Unknown']: ${scores['Unknown']}"); // null
  print('scores.keys: ${scores.keys}');
  print('scores.values: ${scores.values}');
  print('scores.entries: ${scores.entries}');
  print('scores.length: ${scores.length}');
  print('scores.isEmpty: ${scores.isEmpty}');

  // Adding entries
  print('');
  print('--- Adding Entries ---');
  var map = <String, int>{};
  print('Initial: $map');
  map['one'] = 1;
  print("After map['one'] = 1: $map");
  map.addAll({'two': 2, 'three': 3});
  print('After addAll: $map');
  map.addEntries([MapEntry('four', 4)]);
  print('After addEntries: $map');

  // putIfAbsent
  print('');
  print('--- putIfAbsent ---');
  var cache = {'a': 1};
  print('Initial: $cache');
  cache.putIfAbsent('a', () => 100); // Ignored, 'a' exists
  print('putIfAbsent(a, 100): $cache');
  cache.putIfAbsent('b', () => 2); // Added
  print('putIfAbsent(b, 2): $cache');

  // update
  print('');
  print('--- update ---');
  var counts = {'apple': 5, 'banana': 3};
  print('Initial: $counts');
  counts.update('apple', (v) => v + 1);
  print('update(apple, v+1): $counts');
  counts.update('cherry', (v) => v + 1, ifAbsent: () => 1);
  print('update(cherry, ifAbsent): $counts');

  // updateAll
  print('');
  print('--- updateAll ---');
  var prices = {'apple': 1.0, 'banana': 0.5, 'cherry': 2.0};
  print('Initial: $prices');
  prices.updateAll((key, value) => value * 1.1);
  print('After 10% increase: $prices');

  // Removing entries
  print('');
  print('--- Removing Entries ---');
  var data = {'a': 1, 'b': 2, 'c': 3, 'd': 4};
  print('Initial: $data');
  data.remove('b');
  print('After remove(b): $data');
  data.removeWhere((key, value) => value > 2);
  print('After removeWhere(>2): $data');

  // Checking keys/values
  print('');
  print('--- Checking Keys/Values ---');
  var info = {'name': 'Alice', 'age': '30', 'city': 'NYC'};
  print('info: $info');
  print('containsKey(name): ${info.containsKey('name')}');
  print('containsKey(email): ${info.containsKey('email')}');
  print('containsValue(Alice): ${info.containsValue('Alice')}');
  print('containsValue(Bob): ${info.containsValue('Bob')}');

  // Iterating
  print('');
  print('--- Iterating ---');
  var items = {'x': 10, 'y': 20, 'z': 30};
  print('forEach:');
  items.forEach((key, value) {
    print('  $key: $value');
  });

  print('for-in entries:');
  for (var entry in items.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // Map comprehension
  print('');
  print('--- Map Comprehension ---');
  var numbers = [1, 2, 3, 4, 5];
  var squareMap = {for (var n in numbers) n: n * n};
  print('squareMap: $squareMap');

  var words = ['one', 'two', 'three'];
  var lengthMap = {for (var w in words) w: w.length};
  print('lengthMap: $lengthMap');

  // Nested maps
  print('');
  print('--- Nested Maps ---');
  var users = {
    'user1': {'name': 'Alice', 'age': 30},
    'user2': {'name': 'Bob', 'age': 25},
  };
  print('users: $users');
  print("user1 name: ${users['user1']?['name']}");

  // Map transformations
  print('');
  print('--- Map Transformations ---');
  var original = {'a': 1, 'b': 2, 'c': 3};
  var mapped = original.map((key, value) => MapEntry(key.toUpperCase(), value * 10));
  print('original: $original');
  print('mapped: $mapped');

  print('');
  print('=== End of Map Demo ===');
}
