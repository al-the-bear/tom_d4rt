/// Demonstrates Dart Iterable operations
///
/// Features covered:
/// - Common Iterable methods
/// - map, where, expand
/// - reduce, fold
/// - any, every, take, skip
/// - Lazy evaluation
library;

void main() {
  print('=== Iterable Operations ===');
  print('');

  // Basic iteration
  print('--- Basic Iteration ---');
  var numbers = [1, 2, 3, 4, 5];
  print('for-in:');
  for (var n in numbers) {
    print('  $n');
  }

  print('forEach:');
  for (var n in numbers) {
    print('  $n');
  }

  // map
  print('');
  print('--- map ---');
  var doubled = numbers.map((n) => n * 2);
  print('numbers: $numbers');
  print('doubled: ${doubled.toList()}');

  var strings = numbers.map((n) => 'Number: $n');
  print('strings: ${strings.toList()}');

  // where (filter)
  print('');
  print('--- where (filter) ---');
  var evens = numbers.where((n) => n % 2 == 0);
  var odds = numbers.where((n) => n % 2 != 0);
  print('numbers: $numbers');
  print('evens: ${evens.toList()}');
  print('odds: ${odds.toList()}');

  // expand (flatMap)
  print('');
  print('--- expand (flatMap) ---');
  var nested = [
    [1, 2],
    [3, 4],
    [5]
  ];
  var flattened = nested.expand((list) => list);
  print('nested: $nested');
  print('flattened: ${flattened.toList()}');

  var repeated = [1, 2, 3].expand((n) => [n, n]);
  print('repeated: ${repeated.toList()}');

  // reduce
  print('');
  print('--- reduce ---');
  var sum = numbers.reduce((a, b) => a + b);
  var product = numbers.reduce((a, b) => a * b);
  var max = numbers.reduce((a, b) => a > b ? a : b);

  print('numbers: $numbers');
  print('sum: $sum');
  print('product: $product');
  print('max: $max');

  // fold
  print('');
  print('--- fold ---');
  var sumFrom10 = numbers.fold(10, (a, b) => a + b);
  print('fold(10, +): $sumFrom10');

  var concatenated = numbers.fold('', (a, b) => '$a$b');
  print('fold("", concat): $concatenated');

  // any, every
  print('');
  print('--- any, every ---');
  var list = [2, 4, 6, 8, 10];
  print('list: $list');
  print('any(> 5): ${list.any((n) => n > 5)}');
  print('any(> 100): ${list.any((n) => n > 100)}');
  print('every(even): ${list.every((n) => n % 2 == 0)}');
  print('every(< 10): ${list.every((n) => n < 10)}');

  // take, skip
  print('');
  print('--- take, skip ---');
  var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('items: $items');
  print('take(3): ${items.take(3).toList()}');
  print('skip(7): ${items.skip(7).toList()}');
  print('take(5).skip(2): ${items.take(5).skip(2).toList()}');

  // takeWhile, skipWhile
  print('');
  print('--- takeWhile, skipWhile ---');
  print('takeWhile(< 5): ${items.takeWhile((n) => n < 5).toList()}');
  print('skipWhile(< 5): ${items.skipWhile((n) => n < 5).toList()}');

  // first, last, single
  print('');
  print('--- first, last, single ---');
  print('first: ${items.first}');
  print('last: ${items.last}');
  print('firstWhere(> 5): ${items.firstWhere((n) => n > 5)}');
  print('lastWhere(< 5): ${items.lastWhere((n) => n < 5)}');
  print('singleWhere(== 5): ${items.singleWhere((n) => n == 5)}');

  // orElse
  print('');
  print('--- orElse ---');
  var result = items.firstWhere((n) => n > 100, orElse: () => -1);
  print('firstWhere(> 100, orElse: -1): $result');

  // contains
  print('');
  print('--- contains ---');
  print('contains(5): ${items.contains(5)}');
  print('contains(100): ${items.contains(100)}');

  // join
  print('');
  print('--- join ---');
  print('join(): ${items.join()}');
  print('join(", "): ${items.join(', ')}');
  print('join(" -> "): ${items.join(' -> ')}');

  // toList, toSet
  print('');
  print('--- toList, toSet ---');
  var withDupes = [1, 2, 2, 3, 3, 3, 4];
  print('withDupes: $withDupes');
  print('toSet: ${withDupes.toSet()}');
  print('toList: ${withDupes.toList()}');

  // Lazy evaluation
  print('');
  print('--- Lazy Evaluation ---');
  var lazyNumbers = [1, 2, 3, 4, 5];
  print('Creating lazy chain...');
  var lazyResult = lazyNumbers.where((n) {
    print('  where: $n');
    return n % 2 == 0;
  }).map((n) {
    print('  map: $n');
    return n * 10;
  });

  print('Taking first element:');
  var firstElement = lazyResult.first;
  print('First: $firstElement');

  // Chaining
  print('');
  print('--- Chaining Operations ---');
  var data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var processed =
      data.where((n) => n % 2 == 0).map((n) => n * n).take(3).toList();
  print('data: $data');
  print('even squares (first 3): $processed');

  print('');
  print('=== End of Iterable Operations Demo ===');
}
