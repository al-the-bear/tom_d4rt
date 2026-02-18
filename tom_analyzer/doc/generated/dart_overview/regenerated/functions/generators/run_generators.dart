/// Demonstrates Dart generators (sync* and async*)
///
/// Features covered:
/// - Synchronous generators (sync*)
/// - Asynchronous generators (async*)
/// - yield and yield*
library;

void main() async {
  print('=== Generators ===');
  print('');

  // Synchronous generator (sync*)
  print('--- Synchronous Generator (sync*) ---');

  // Basic sync generator
  print('countTo(5):');
  for (var n in countTo(5)) {
    print('  $n');
  }

  // Generator with early exit
  print('');
  print('First 3 from countTo(10):');
  var count = 0;
  for (var n in countTo(10)) {
    print('  $n');
    if (++count >= 3) break;
  }

  // Range generator
  print('');
  print('range(1, 5):');
  print('  ${range(1, 5).toList()}');

  // Infinite generator (lazy evaluation)
  print('');
  print('First 5 natural numbers:');
  var naturals = naturalNumbers();
  print('  ${naturals.take(5).toList()}');

  // Fibonacci generator
  print('');
  print('First 10 Fibonacci numbers:');
  print('  ${fibonacci().take(10).toList()}');

  // yield* - delegating to another iterable
  print('');
  print('--- yield* (Delegation) ---');
  print('nestedRanges():');
  print('  ${nestedRanges().toList()}');

  // Flatten with yield*
  print('');
  print('flatten([[1,2], [3,4], [5,6]]):');
  var nested = [
    [1, 2],
    [3, 4],
    [5, 6]
  ];
  print('  ${flatten(nested).toList()}');

  // Tree traversal with yield*
  print('');
  print('--- Tree Traversal ---');
  var tree = TreeNode(
    1,
    [
      TreeNode(2, [TreeNode(4), TreeNode(5)]),
      TreeNode(3, [TreeNode(6), TreeNode(7)]),
    ],
  );
  print('Tree values (pre-order):');
  print('  ${traverseTree(tree).toList()}');

  // Asynchronous generator (async*)
  print('');
  print('--- Asynchronous Generator (async*) ---');

  // Basic async generator
  print('countAsyncTo(3):');
  await for (var n in countAsyncTo(3)) {
    print('  $n');
  }

  // Async generator with delay
  print('');
  print('timedEvents():');
  await for (var event in timedEvents().take(3)) {
    print('  $event');
  }

  // Async yield*
  print('');
  print('combinedAsyncStreams():');
  await for (var value in combinedAsyncStreams()) {
    print('  $value');
  }

  // Practical: Paginated data fetching
  print('');
  print('--- Practical: Paginated Fetching ---');
  print('Fetching pages:');
  await for (var item in fetchAllPages()) {
    print('  $item');
  }

  // Generator with filtering
  print('');
  print('--- Generator with Filtering ---');
  print('Primes up to 30:');
  print('  ${primesUpTo(30).toList()}');

  print('');
  print('=== End of Generators Demo ===');
}

// Basic sync generator
Iterable<int> countTo(int max) sync* {
  for (int i = 1; i <= max; i++) {
    yield i;
  }
}

// Range generator
Iterable<int> range(int start, int end, [int step = 1]) sync* {
  for (int i = start; i <= end; i += step) {
    yield i;
  }
}

// Infinite generator
Iterable<int> naturalNumbers() sync* {
  int n = 1;
  while (true) {
    yield n++;
  }
}

// Fibonacci generator
Iterable<int> fibonacci() sync* {
  int a = 0, b = 1;
  while (true) {
    yield a;
    var next = a + b;
    a = b;
    b = next;
  }
}

// yield* - delegate to another iterable
Iterable<int> nestedRanges() sync* {
  yield* range(1, 3);
  yield 100;
  yield* range(4, 6);
}

// Flatten nested iterables
Iterable<T> flatten<T>(Iterable<Iterable<T>> nested) sync* {
  for (var inner in nested) {
    yield* inner;
  }
}

// Tree node for traversal example
class TreeNode<T> {
  final T value;
  final List<TreeNode<T>> children;

  TreeNode(this.value, [this.children = const []]);
}

// Pre-order tree traversal with yield*
Iterable<T> traverseTree<T>(TreeNode<T> node) sync* {
  yield node.value;
  for (var child in node.children) {
    yield* traverseTree(child);
  }
}

// Basic async generator
Stream<int> countAsyncTo(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

// Async generator with timed events
Stream<String> timedEvents() async* {
  var eventNum = 1;
  while (true) {
    await Future.delayed(Duration(milliseconds: 200));
    yield 'Event ${eventNum++} at ${DateTime.now().second}s';
  }
}

// Async yield* - combine streams
Stream<String> combinedAsyncStreams() async* {
  yield* Stream.fromIterable(['a', 'b', 'c']);
  yield 'middle';
  yield* Stream.fromIterable(['x', 'y', 'z']);
}

// Practical: Paginated API fetching
Stream<String> fetchAllPages() async* {
  int page = 1;
  int maxPages = 3;

  while (page <= maxPages) {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 100));
    var items = ['Page $page - Item 1', 'Page $page - Item 2'];
    for (var item in items) {
      yield item;
    }
    page++;
  }
}

// Generator with filtering - primes
Iterable<int> primesUpTo(int max) sync* {
  outer:
  for (int n = 2; n <= max; n++) {
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) continue outer;
    }
    yield n;
  }
}
