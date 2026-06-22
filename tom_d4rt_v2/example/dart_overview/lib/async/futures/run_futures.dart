/// Demonstrates Dart Futures
///
/// Features covered:
/// - Creating Futures
/// - async/await
/// - Future methods (then, catchError, whenComplete)
/// - Future.wait, Future.any
/// - Future.delayed
/// - Error handling with Futures

import 'dart:async' show TimeoutException;

Future<void> main() async {
  print('=== Futures ===');
  print('');

  // Basic async/await
  print('--- Basic async/await ---');
  print('Fetching user...');
  var user = await fetchUser(1);
  print('Got user: $user');

  // Future.delayed
  print('');
  print('--- Future.delayed ---');
  print('Starting delay...');
  await Future.delayed(Duration(milliseconds: 100));
  print('Delay completed');

  // Creating Futures
  print('');
  print('--- Creating Futures ---');
  var immediate = Future.value(42);
  print('Future.value(42): ${await immediate}');

  var computed = Future(() {
    print('  Computing...');
    return 'Computed value';
  });
  print('Future(() => ...): ${await computed}');

  // Sequential operations
  print('');
  print('--- Sequential Operations ---');
  print('Fetching posts for user...');
  var fetchedUser = await fetchUser(1);
  var posts = await fetchPosts(fetchedUser);
  print('User: $fetchedUser');
  print('Posts: $posts');

  // Parallel operations with Future.wait
  print('');
  print('--- Future.wait (parallel) ---');
  print('Fetching multiple resources...');
  var start = DateTime.now();
  var results = await Future.wait([
    simulateDelay('Resource A', Duration(milliseconds: 100)),
    simulateDelay('Resource B', Duration(milliseconds: 150)),
    simulateDelay('Resource C', Duration(milliseconds: 80)),
  ]);
  var elapsed = DateTime.now().difference(start).inMilliseconds;
  print('Results: $results');
  print('Total time: ~${elapsed}ms (parallel)');

  // Future.any (first to complete)
  print('');
  print('--- Future.any (first to complete) ---');
  var fastest = await Future.any([
    simulateDelay('Slow', Duration(milliseconds: 200)),
    simulateDelay('Fast', Duration(milliseconds: 50)),
    simulateDelay('Medium', Duration(milliseconds: 100)),
  ]);
  print('First to complete: $fastest');

  // then/catchError/whenComplete
  print('');
  print('--- then/catchError/whenComplete ---');
  await fetchData('valid')
      .then((data) => print('Data: $data'))
      .catchError((e) => print('Error: $e'))
      .whenComplete(() => print('Operation complete'));

  // Error handling with await
  print('');
  print('--- Error Handling with try/catch ---');
  try {
    await fetchData('error');
  } catch (e) {
    print('Caught error: $e');
  }

  // Chaining transformations
  print('');
  print('--- Chaining with then ---');
  var result = await Future.value(5)
      .then((n) => n * 2)
      .then((n) => n + 3)
      .then((n) => 'Result: $n');
  print(result);

  // Timeout
  print('');
  print('--- Timeout ---');
  try {
    await simulateDelay('Slow operation', Duration(milliseconds: 500))
        .timeout(Duration(milliseconds: 100));
  } on TimeoutException {
    print('Operation timed out');
  }

  // Future.forEach
  print('');
  print('--- Future.forEach ---');
  var items = [1, 2, 3, 4, 5];
  await Future.forEach(items, (item) async {
    await Future.delayed(Duration(milliseconds: 10));
    print('  Processed: $item');
  });

  // Future.doWhile
  print('');
  print('--- Future.doWhile ---');
  var counter = 0;
  await Future.doWhile(() async {
    await Future.delayed(Duration(milliseconds: 10));
    counter++;
    print('  Counter: $counter');
    return counter < 3;
  });

  // Microtask vs Event queue
  print('');
  print('--- Microtask vs Event Queue ---');
  Future(() => print('  Event queue'));
  Future.microtask(() => print('  Microtask'));
  print('  Synchronous');
  await Future.delayed(Duration(milliseconds: 10));

  print('');
  print('=== End of Futures Demo ===');
}

// Simulated async operations
Future<String> fetchUser(int id) async {
  await Future.delayed(Duration(milliseconds: 50));
  return 'User$id';
}

Future<List<String>> fetchPosts(String user) async {
  await Future.delayed(Duration(milliseconds: 50));
  return ['Post1 by $user', 'Post2 by $user'];
}

Future<String> simulateDelay(String name, Duration duration) async {
  await Future.delayed(duration);
  return name;
}

Future<String> fetchData(String type) async {
  await Future.delayed(Duration(milliseconds: 50));
  if (type == 'error') {
    throw Exception('Failed to fetch data');
  }
  return 'Data for $type';
}
