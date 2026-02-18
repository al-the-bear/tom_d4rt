/// Demonstrates Dart generic functions and methods
///
/// Features covered:
/// - Generic functions
/// - Generic methods
/// - Type inference with functions
/// - Multiple type parameters
/// - Higher-order generic functions
library;

void main() {
  print('=== Generic Functions ===');
  print('');

  // Simple generic function
  print('--- Simple Generic Function ---');
  print('identity<int>(42): ${identity<int>(42)}');
  print('identity<String>("Hello"): ${identity<String>("Hello")}');
  print('identity(3.14): ${identity(3.14)}'); // Type inferred

  // Generic swap function
  print('');
  print('--- Generic Swap ---');
  var tuple = (first: 1, second: 'one');
  print('Original: (${tuple.first}, ${tuple.second})');
  var swapped = swap(tuple.first, tuple.second);
  print('Swapped: (${swapped.first}, ${swapped.second})');

  // First and last
  print('');
  print('--- First and Last ---');
  var numbers = [10, 20, 30, 40, 50];
  var words = ['apple', 'banana', 'cherry'];

  print('first(numbers): ${first(numbers)}');
  print('last(numbers): ${last(numbers)}');
  print('first(words): ${first(words)}');
  print('last(words): ${last(words)}');

  // Generic filter
  print('');
  print('--- Generic Filter ---');
  var allNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var evenNumbers = filter(allNumbers, (n) => n % 2 == 0);
  var oddNumbers = filter(allNumbers, (n) => n % 2 != 0);

  print('All: $allNumbers');
  print('Even: $evenNumbers');
  print('Odd: $oddNumbers');

  // Generic map function
  print('');
  print('--- Generic Map Function ---');
  var lengths = mapList<String, int>(words, (s) => s.length);
  print('Words: $words');
  print('Lengths: $lengths');

  var doubled = mapList<int, int>(numbers, (n) => n * 2);
  print('Numbers: $numbers');
  print('Doubled: $doubled');

  // Reduce
  print('');
  print('--- Generic Reduce ---');
  var sum = reduce<int>(numbers, 0, (acc, n) => acc + n);
  var product = reduce<int>([1, 2, 3, 4], 1, (acc, n) => acc * n);
  var concat = reduce<String>(words, '', (acc, s) => acc.isEmpty ? s : '$acc, $s');

  print('Sum of $numbers: $sum');
  print('Product of [1, 2, 3, 4]: $product');
  print('Concatenated: $concat');

  // Find
  print('');
  print('--- Generic Find ---');
  var found = find<int>(numbers, (n) => n > 25);
  var notFound = find<int>(numbers, (n) => n > 100);

  print('Find > 25: $found');
  print('Find > 100: $notFound');

  // Zip
  print('');
  print('--- Generic Zip ---');
  var keys = ['a', 'b', 'c'];
  var values = [1, 2, 3];
  var zipped = zip(keys, values);

  print('Keys: $keys');
  print('Values: $values');
  print('Zipped: $zipped');

  // GroupBy
  print('');
  print('--- Generic GroupBy ---');
  var items = ['apple', 'banana', 'apricot', 'blueberry', 'cherry'];
  var grouped = groupBy<String, String>(items, (s) => s[0]);

  print('Items: $items');
  print('Grouped by first letter:');
  grouped.forEach((key, value) => print('  $key: $value'));

  // Memoize
  print('');
  print('--- Generic Memoize ---');
  var callCount = 0;
  int expensiveCompute(int n) {
    callCount++;
    return n * n;
  }

  var memoizedCompute = memoize<int, int>(expensiveCompute);

  print('Computing squares with memoization:');
  print('  memoizedCompute(5): ${memoizedCompute(5)} (calls: $callCount)');
  print('  memoizedCompute(3): ${memoizedCompute(3)} (calls: $callCount)');
  print('  memoizedCompute(5): ${memoizedCompute(5)} (calls: $callCount)'); // Cached
  print('  memoizedCompute(3): ${memoizedCompute(3)} (calls: $callCount)'); // Cached
  print('  memoizedCompute(7): ${memoizedCompute(7)} (calls: $callCount)');

  // Compose
  print('');
  print('--- Generic Compose ---');
  String addExclamation(String s) => '$s!';
  String toUpperCase(String s) => s.toUpperCase();
  String greet(String name) => 'Hello $name';

  var enthusiasticGreet = compose<String, String, String>(
    addExclamation,
    compose(toUpperCase, greet),
  );

  print('enthusiasticGreet("Alice"): ${enthusiasticGreet("Alice")}');

  // Curry
  print('');
  print('--- Generic Curry ---');
  int add(int a, int b) => a + b;
  var curriedAdd = curry(add);
  var add5 = curriedAdd(5);

  print('curriedAdd(5)(3): ${curriedAdd(5)(3)}');
  print('add5(10): ${add5(10)}');
  print('add5(20): ${add5(20)}');

  print('');
  print('=== End of Generic Functions Demo ===');
}

// Identity function
T identity<T>(T value) => value;

// Swap returning record
({S first, F second}) swap<F, S>(F first, S second) => (first: second, second: first);

// First and last
T first<T>(List<T> items) {
  if (items.isEmpty) throw ArgumentError('List is empty');
  return items.first;
}

T last<T>(List<T> items) {
  if (items.isEmpty) throw ArgumentError('List is empty');
  return items.last;
}

// Filter
List<T> filter<T>(List<T> items, bool Function(T) predicate) {
  return [for (var item in items) if (predicate(item)) item];
}

// Map
List<R> mapList<T, R>(List<T> items, R Function(T) transform) {
  return [for (var item in items) transform(item)];
}

// Reduce
T reduce<T>(List<T> items, T initial, T Function(T, T) combine) {
  var result = initial;
  for (var item in items) {
    result = combine(result, item);
  }
  return result;
}

// Find
T? find<T>(List<T> items, bool Function(T) predicate) {
  for (var item in items) {
    if (predicate(item)) return item;
  }
  return null;
}

// Zip
List<(F, S)> zip<F, S>(List<F> first, List<S> second) {
  var length = first.length < second.length ? first.length : second.length;
  return [for (var i = 0; i < length; i++) (first[i], second[i])];
}

// GroupBy
Map<K, List<T>> groupBy<T, K>(List<T> items, K Function(T) keySelector) {
  var result = <K, List<T>>{};
  for (var item in items) {
    var key = keySelector(item);
    (result[key] ??= []).add(item);
  }
  return result;
}

// Memoize
R Function(T) memoize<T, R>(R Function(T) fn) {
  var cache = <T, R>{};
  return (T arg) {
    if (!cache.containsKey(arg)) {
      cache[arg] = fn(arg);
    }
    return cache[arg] as R;
  };
}

// Compose
C Function(A) compose<A, B, C>(C Function(B) f, B Function(A) g) {
  return (A a) => f(g(a));
}

// Curry
R Function(B) Function(A) curry<A, B, R>(R Function(A, B) fn) {
  return (A a) => (B b) => fn(a, b);
}
