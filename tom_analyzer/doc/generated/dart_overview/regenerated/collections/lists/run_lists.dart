/// Demonstrates Dart List type
///
/// Features covered:
/// - List creation (literal, constructor, filled, generate)
/// - Basic operations (add, remove, insert, clear)
/// - Accessing elements
/// - List methods (sort, reverse, shuffle)
/// - Fixed-length vs growable lists
/// - List comprehensions
library;

void main() {
  print('=== List ===');
  print('');

  // List creation
  print('--- List Creation ---');
  var literal = [1, 2, 3, 4, 5];
  var empty = <String>[];
  var constructor = List<int>.empty(growable: true);
  var filled = List<int>.filled(5, 0);
  var generated = List<int>.generate(5, (i) => i * 2);
  var from = List<int>.from([10, 20, 30]);
  var unmodifiable = List<int>.unmodifiable([1, 2, 3]);

  print('literal: $literal');
  print('empty: $empty');
  print('constructor: $constructor');
  print('filled: $filled');
  print('generated: $generated');
  print('from: $from');
  print('unmodifiable: $unmodifiable');

  // Accessing elements
  print('');
  print('--- Accessing Elements ---');
  var numbers = [10, 20, 30, 40, 50];
  print('numbers: $numbers');
  print('numbers[0]: ${numbers[0]}');
  print('numbers[2]: ${numbers[2]}');
  print('numbers.first: ${numbers.first}');
  print('numbers.last: ${numbers.last}');
  print('numbers.length: ${numbers.length}');
  print('numbers.isEmpty: ${numbers.isEmpty}');
  print('numbers.isNotEmpty: ${numbers.isNotEmpty}');

  // Adding elements
  print('');
  print('--- Adding Elements ---');
  var fruits = <String>['apple'];
  print('Initial: $fruits');
  fruits.add('banana');
  print('After add: $fruits');
  fruits.addAll(['cherry', 'date']);
  print('After addAll: $fruits');
  fruits.insert(1, 'avocado');
  print('After insert(1, avocado): $fruits');
  fruits.insertAll(0, ['mango', 'kiwi']);
  print('After insertAll(0, ...): $fruits');

  // Removing elements
  print('');
  print('--- Removing Elements ---');
  var items = [1, 2, 3, 4, 5, 3, 6];
  print('Initial: $items');
  items.remove(3); // Removes first occurrence
  print('After remove(3): $items');
  items.removeAt(0);
  print('After removeAt(0): $items');
  items.removeLast();
  print('After removeLast: $items');
  items.removeWhere((n) => n > 4);
  print('After removeWhere(>4): $items');

  // Updating elements
  print('');
  print('--- Updating Elements ---');
  var values = [1, 2, 3, 4, 5];
  print('Initial: $values');
  values[2] = 30;
  print('After values[2] = 30: $values');
  values.replaceRange(1, 3, [20, 300]);
  print('After replaceRange(1, 3, ...): $values');
  values.fillRange(0, 2, 0);
  print('After fillRange(0, 2, 0): $values');

  // Sublist and range
  print('');
  print('--- Sublist and Range ---');
  var list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  print('list: $list');
  print('sublist(3): ${list.sublist(3)}');
  print('sublist(2, 5): ${list.sublist(2, 5)}');
  print('getRange(3, 7): ${list.getRange(3, 7).toList()}');

  // Searching
  print('');
  print('--- Searching ---');
  var searchList = ['a', 'b', 'c', 'd', 'b', 'e'];
  print('list: $searchList');
  print('indexOf(b): ${searchList.indexOf('b')}');
  print('lastIndexOf(b): ${searchList.lastIndexOf('b')}');
  print('contains(c): ${searchList.contains('c')}');
  print('contains(z): ${searchList.contains('z')}');
  print('indexWhere length > 0: ${searchList.indexWhere((s) => s == 'd')}');

  // Sorting and reversing
  print('');
  print('--- Sorting and Reversing ---');
  var unsorted = [5, 2, 8, 1, 9, 3];
  print('unsorted: $unsorted');
  unsorted.sort();
  print('After sort(): $unsorted');
  unsorted.sort((a, b) => b.compareTo(a)); // Descending
  print('Sort descending: $unsorted');
  print('reversed: ${unsorted.reversed.toList()}');

  // List comprehensions (collection for)
  print('');
  print('--- List Comprehensions ---');
  var squares = [for (var i = 1; i <= 5; i++) i * i];
  print('squares: $squares');

  var evens = [for (var i = 1; i <= 10; i++) if (i % 2 == 0) i];
  print('evens 1-10: $evens');

  var matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];
  var flattened = [for (var row in matrix) for (var cell in row) cell];
  print('flattened matrix: $flattened');

  // Spread operator
  print('');
  print('--- Spread Operator ---');
  var list1 = [1, 2, 3];
  var list2 = [4, 5, 6];
  var combined = [...list1, ...list2];
  print('combined: $combined');

  List<int>? nullable;
  var safe = [...?nullable, 7, 8];
  print('with null-aware spread: $safe');

  print('');
  print('=== End of List Demo ===');
}
