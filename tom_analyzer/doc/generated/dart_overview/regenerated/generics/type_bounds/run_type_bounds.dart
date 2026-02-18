/// Demonstrates Dart type bounds and constraints
///
/// Features covered:
/// - extends clause (upper bounds)
/// - Multiple bounds (intersection types via mixins/interfaces)
/// - Bounded type parameters
/// - Type constraints in methods
library;

void main() {
  print('=== Type Bounds ===');
  print('');

  // Upper bound with extends
  print('--- Upper Bound (extends) ---');
  var intStats = Statistics<int>([10, 20, 30, 40, 50]);
  var doubleStats = Statistics<double>([1.5, 2.5, 3.5, 4.5]);

  print('Int stats: min=${intStats.min}, max=${intStats.max}');
  print('Double stats: min=${doubleStats.min}, max=${doubleStats.max}');

  // Comparable bound
  print('');
  print('--- Comparable Bound ---');
  var numbers = [5, 2, 8, 1, 9];
  var words = ['banana', 'apple', 'cherry'];

  print('Min of $numbers: ${findMin(numbers)}');
  print('Max of $numbers: ${findMax(numbers)}');
  print('Min of $words: ${findMin(words)}');
  print('Max of $words: ${findMax(words)}');

  // Sorted list
  var sortedNumbers = SortedList<int>()..addAll(numbers);
  var sortedWords = SortedList<String>()..addAll(words);

  print('');
  print('Sorted numbers: ${sortedNumbers.items}');
  print('Sorted words: ${sortedWords.items}');

  // Custom class with bounds
  print('');
  print('--- Custom Class with Bounds ---');
  var people = [
    Person('Charlie', 30),
    Person('Alice', 25),
    Person('Bob', 35),
  ];

  var sortedPeople = SortedList<Person>()..addAll(people);
  print('Sorted people: ${sortedPeople.items}');
  print('Youngest: ${findMin(sortedPeople.items)}');
  print('Oldest: ${findMax(sortedPeople.items)}');

  // Priority queue
  print('');
  print('--- Priority Queue ---');
  var pq = PriorityQueue<int>();
  pq.add(5);
  pq.add(1);
  pq.add(3);
  pq.add(2);
  pq.add(4);

  print('Dequeuing in priority order:');
  while (!pq.isEmpty) {
    print('  ${pq.removeMin()}');
  }

  // Range with bounds
  print('');
  print('--- Range with Bounds ---');
  var intRange = Range<int>(10, 20);
  print('Range 10-20 contains 15: ${intRange.contains(15)}');
  print('Range 10-20 contains 25: ${intRange.contains(25)}');
  print('Range 10-20 contains 10: ${intRange.contains(10)}');

  var stringRange = Range<String>('d', 'h');
  print('Range d-h contains "f": ${stringRange.contains("f")}');
  print('Range d-h contains "a": ${stringRange.contains("a")}');

  // Binary search tree
  print('');
  print('--- Binary Search Tree ---');
  var bst = BinarySearchTree<int>();
  bst.insert(50);
  bst.insert(30);
  bst.insert(70);
  bst.insert(20);
  bst.insert(40);
  bst.insert(60);
  bst.insert(80);

  print('BST contains 40: ${bst.contains(40)}');
  print('BST contains 45: ${bst.contains(45)}');
  print('In-order traversal: ${bst.inOrder()}');

  // Clamp function
  print('');
  print('--- Clamp Function ---');
  print('clamp(15, 10, 20): ${clamp(15, 10, 20)}');
  print('clamp(5, 10, 20): ${clamp(5, 10, 20)}');
  print('clamp(25, 10, 20): ${clamp(25, 10, 20)}');

  // Interface bounds
  print('');
  print('--- Interface Bounds ---');
  var intCache = Cache<int, int>();
  intCache.put(1, 100);
  intCache.put(2, 200);

  print('Cache get(1): ${intCache.get(1)}');
  print('Cache get(3): ${intCache.get(3)}');

  print('');
  print('=== End of Type Bounds Demo ===');
}

// Statistics with num bound
class Statistics<T extends num> {
  final List<T> values;

  Statistics(this.values);

  T get min {
    var result = values.first;
    for (var v in values) {
      if (v < result) result = v;
    }
    return result;
  }

  T get max {
    var result = values.first;
    for (var v in values) {
      if (v > result) result = v;
    }
    return result;
  }

  double get average {
    var sum = 0.0;
    for (var v in values) {
      sum += v;
    }
    return sum / values.length;
  }
}

// Functions with Comparable bound
T findMin<T extends Comparable<T>>(List<T> items) {
  var min = items.first;
  for (var item in items) {
    if (item.compareTo(min) < 0) min = item;
  }
  return min;
}

T findMax<T extends Comparable<T>>(List<T> items) {
  var max = items.first;
  for (var item in items) {
    if (item.compareTo(max) > 0) max = item;
  }
  return max;
}

// Sorted list - using Comparable<dynamic> to allow int/num
class SortedList<T extends Comparable<dynamic>> {
  final List<T> _items = [];

  void add(T item) {
    _items.add(item);
    _items.sort();
  }

  void addAll(Iterable<T> items) {
    _items.addAll(items);
    _items.sort();
  }

  List<T> get items => List.unmodifiable(_items);
}

// Custom Comparable class
class Person implements Comparable<Person> {
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  int compareTo(Person other) {
    var result = age.compareTo(other.age);
    if (result != 0) return result;
    return name.compareTo(other.name);
  }

  @override
  String toString() => '$name($age)';
}

// Priority queue - using Comparable<dynamic> to allow int/num
class PriorityQueue<T extends Comparable<dynamic>> {
  final List<T> _heap = [];

  void add(T item) {
    _heap.add(item);
    _bubbleUp(_heap.length - 1);
  }

  T removeMin() {
    if (_heap.isEmpty) throw StateError('Queue is empty');
    var min = _heap.first;
    var last = _heap.removeLast();
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }
    return min;
  }

  bool get isEmpty => _heap.isEmpty;

  void _bubbleUp(int index) {
    while (index > 0) {
      var parent = (index - 1) ~/ 2;
      if (_heap[index].compareTo(_heap[parent]) >= 0) break;
      var temp = _heap[index];
      _heap[index] = _heap[parent];
      _heap[parent] = temp;
      index = parent;
    }
  }

  void _bubbleDown(int index) {
    while (true) {
      var left = 2 * index + 1;
      var right = 2 * index + 2;
      var smallest = index;

      if (left < _heap.length && _heap[left].compareTo(_heap[smallest]) < 0) {
        smallest = left;
      }
      if (right < _heap.length && _heap[right].compareTo(_heap[smallest]) < 0) {
        smallest = right;
      }

      if (smallest == index) break;

      var temp = _heap[index];
      _heap[index] = _heap[smallest];
      _heap[smallest] = temp;
      index = smallest;
    }
  }
}

// Range with Comparable bound - using Comparable<dynamic> to allow int/num
class Range<T extends Comparable<dynamic>> {
  final T start;
  final T end;

  Range(this.start, this.end);

  bool contains(T value) {
    return value.compareTo(start) >= 0 && value.compareTo(end) <= 0;
  }
}

// Binary search tree - using Comparable<dynamic> to allow int/num
class BinarySearchTree<T extends Comparable<dynamic>> {
  _Node<T>? _root;

  void insert(T value) {
    _root = _insertNode(_root, value);
  }

  _Node<T> _insertNode(_Node<T>? node, T value) {
    if (node == null) return _Node(value);

    if (value.compareTo(node.value) < 0) {
      node.left = _insertNode(node.left, value);
    } else if (value.compareTo(node.value) > 0) {
      node.right = _insertNode(node.right, value);
    }

    return node;
  }

  bool contains(T value) {
    var current = _root;
    while (current != null) {
      var cmp = value.compareTo(current.value);
      if (cmp == 0) return true;
      current = cmp < 0 ? current.left : current.right;
    }
    return false;
  }

  List<T> inOrder() {
    var result = <T>[];
    _inOrderTraversal(_root, result);
    return result;
  }

  void _inOrderTraversal(_Node<T>? node, List<T> result) {
    if (node == null) return;
    _inOrderTraversal(node.left, result);
    result.add(node.value);
    _inOrderTraversal(node.right, result);
  }
}

class _Node<T> {
  T value;
  _Node<T>? left;
  _Node<T>? right;
  _Node(this.value);
}

// Clamp function
T clamp<T extends Comparable<T>>(T value, T min, T max) {
  if (value.compareTo(min) < 0) return min;
  if (value.compareTo(max) > 0) return max;
  return value;
}

// Cache with object bound (any type)
class Cache<K, V> {
  final Map<K, V> _data = {};

  void put(K key, V value) {
    _data[key] = value;
  }

  V? get(K key) => _data[key];

  bool contains(K key) => _data.containsKey(key);
}
