/// Demonstrates Dart Set type
///
/// Features covered:
/// - Set creation (literal, constructor, from)
/// - Adding and removing elements
/// - Set operations (union, intersection, difference)
/// - Checking membership
/// - Iterating sets
library;

void main() {
  print('=== Set ===');
  print('');

  // Set creation
  print('--- Set Creation ---');
  var literal = {1, 2, 3, 4, 5};
  var empty = <String>{};
  var constructor = <int>{};
  var from = <int>{}..addAll([1, 2, 3, 3, 2, 1]); // Duplicates removed
  var identity = Set<int>.identity();
  var unmodifiable = Set<int>.unmodifiable({1, 2, 3});

  print('literal: $literal');
  print('empty: $empty');
  print('constructor: $constructor');
  print('from [1,2,3,3,2,1]: $from');
  print('identity: $identity');
  print('unmodifiable: $unmodifiable');

  // No duplicates
  print('');
  print('--- No Duplicates ---');
  var numbers = <int>{};
  numbers.add(1);
  numbers.add(2);
  numbers.add(1); // Ignored
  numbers.add(3);
  numbers.add(2); // Ignored
  print('After adding 1, 2, 1, 3, 2: $numbers');

  // Adding elements
  print('');
  print('--- Adding Elements ---');
  var fruits = <String>{'apple'};
  print('Initial: $fruits');
  fruits.add('banana');
  print('After add(banana): $fruits');
  fruits.addAll(['cherry', 'date', 'apple']); // apple ignored
  print('After addAll: $fruits');

  // Removing elements
  print('');
  print('--- Removing Elements ---');
  var items = {1, 2, 3, 4, 5, 6};
  print('Initial: $items');
  items.remove(3);
  print('After remove(3): $items');
  items.removeWhere((n) => n > 4);
  print('After removeWhere(>4): $items');
  items.removeAll([1, 2]);
  print('After removeAll([1, 2]): $items');
  items.retainAll([4]);
  print('After retainAll([4]): $items');

  // Membership
  print('');
  print('--- Membership ---');
  var set = {'a', 'b', 'c', 'd'};
  print('set: $set');
  print('contains(b): ${set.contains('b')}');
  print('contains(z): ${set.contains('z')}');
  print('containsAll([a, b]): ${set.containsAll(['a', 'b'])}');
  print('containsAll([a, z]): ${set.containsAll(['a', 'z'])}');

  // Set operations
  print('');
  print('--- Set Operations ---');
  var setA = {1, 2, 3, 4, 5};
  var setB = {4, 5, 6, 7, 8};

  print('setA: $setA');
  print('setB: $setB');

  // Union
  var union = setA.union(setB);
  print('union: $union');

  // Intersection
  var intersection = setA.intersection(setB);
  print('intersection: $intersection');

  // Difference
  var differenceAB = setA.difference(setB);
  var differenceBA = setB.difference(setA);
  print('A - B: $differenceAB');
  print('B - A: $differenceBA');

  // Symmetric difference (XOR)
  var symmetric = setA.union(setB).difference(setA.intersection(setB));
  print('symmetric difference: $symmetric');

  // Lookup
  print('');
  print('--- Lookup ---');
  var words = {'hello', 'world', 'dart'};
  print('lookup(hello): ${words.lookup('hello')}');
  print('lookup(missing): ${words.lookup('missing')}');

  // Converting
  print('');
  print('--- Converting ---');
  var toList = {3, 1, 2}.toList();
  print('toList: $toList');
  print('toList sorted: ${toList..sort()}');

  // Set comprehension
  print('');
  print('--- Set Comprehension ---');
  var squares = {for (var i = 1; i <= 5; i++) i * i};
  print('squares: $squares');

  var list = [1, 2, 2, 3, 3, 3, 4];
  var unique = {for (var n in list) n};
  print('unique from $list: $unique');

  // HashSet vs LinkedHashSet vs SplayTreeSet
  print('');
  print('--- Set Implementations ---');
  // Default literal {} creates LinkedHashSet (maintains insertion order)
  var linkedSet = {'c', 'a', 'b'};
  print('LinkedHashSet: $linkedSet (maintains insertion order)');

  // Can use SplayTreeSet for sorted order
  // var sortedSet = SplayTreeSet<String>.from(['c', 'a', 'b']);

  // Using Set with custom objects
  print('');
  print('--- Custom Objects ---');
  var point1 = Point(1, 2);
  var point2 = Point(1, 2);
  var point3 = Point(3, 4);

  var pointSet = {point1, point2, point3};
  print('Point set size: ${pointSet.length}');
  print('point1 == point2: ${point1 == point2}');
  print('identical(point1, point2): ${identical(point1, point2)}');

  print('');
  print('=== End of Set Demo ===');
}

// Custom class with equals and hashCode
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Point && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x, $y)';
}
