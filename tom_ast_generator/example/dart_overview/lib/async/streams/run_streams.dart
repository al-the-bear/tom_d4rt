/// Demonstrates Dart Streams
///
/// Features covered:
/// - Creating Streams
/// - Listening to Streams
/// - Stream transformations
/// - StreamController
/// - Broadcast streams
/// - async* generators
/// - Stream methods

import 'dart:async';

Future<void> main() async {
  print('=== Streams ===');
  print('');

  // Basic stream listening
  print('--- Basic Stream Listening ---');
  var numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('Listening to stream:');
  await for (var number in numberStream) {
    print('  Received: $number');
  }

  // Stream.periodic
  print('');
  print('--- Stream.periodic ---');
  var periodicStream =
      Stream.periodic(Duration(milliseconds: 50), (i) => i).take(5);
  print('Periodic values:');
  await for (var value in periodicStream) {
    print('  Tick: $value');
  }

  // async* generator
  print('');
  print('--- async* Generator ---');
  print('Counting:');
  await for (var n in countTo(5)) {
    print('  Count: $n');
  }

  // Stream transformations
  print('');
  print('--- Stream Transformations ---');
  var source = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  print('map (x2):');
  await for (var n in source.map((n) => n * 2).take(5)) {
    print('  $n');
  }

  source = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print('');
  print('where (even):');
  await for (var n in source.where((n) => n.isEven)) {
    print('  $n');
  }

  // Stream methods
  print('');
  print('--- Stream Methods ---');
  source = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('first: ${await source.first}');

  source = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('last: ${await source.last}');

  source = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('length: ${await source.length}');

  source = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('contains(3): ${await source.contains(3)}');

  source = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('toList: ${await source.toList()}');

  source = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('reduce (sum): ${await source.reduce((a, b) => a + b)}');

  // StreamController
  print('');
  print('--- StreamController ---');
  var controller = StreamController<String>();

  // Listen to events
  controller.stream.listen(
    (data) => print('  Data: $data'),
    onError: (error) => print('  Error: $error'),
    onDone: () => print('  Done!'),
  );

  // Add events
  controller.add('Hello');
  controller.add('World');
  controller.addError('Oops!');
  controller.add('After error');
  await controller.close();

  await Future.delayed(Duration(milliseconds: 50));

  // Broadcast stream
  print('');
  print('--- Broadcast Stream ---');
  var broadcastController = StreamController<int>.broadcast();

  var sub1 = broadcastController.stream.listen((n) => print('  Listener 1: $n'));

  var sub2 = broadcastController.stream.listen((n) => print('  Listener 2: $n'));

  broadcastController.add(1);
  broadcastController.add(2);

  await sub1.cancel();
  print('  Listener 1 cancelled');

  broadcastController.add(3);

  await sub2.cancel();
  await broadcastController.close();

  // Stream.value and Stream.error
  print('');
  print('--- Stream.value and Stream.error ---');
  var valueStream = Stream.value(42);
  print('Stream.value: ${await valueStream.first}');

  var errorStream = Stream<int>.error('Test error');
  try {
    await errorStream.first;
  } catch (e) {
    print('Stream.error caught: $e');
  }

  // expand
  print('');
  print('--- expand ---');
  var expandStream = Stream.fromIterable([1, 2, 3]);
  var expanded = expandStream.expand((n) => [n, n * 10]);
  print('expanded: ${await expanded.toList()}');

  // distinct
  print('');
  print('--- distinct ---');
  var duplicates = Stream.fromIterable([1, 1, 2, 2, 3, 3, 2, 1]);
  var distinctValues = duplicates.distinct();
  print('distinct: ${await distinctValues.toList()}');

  // asyncMap
  print('');
  print('--- asyncMap ---');
  var ids = Stream.fromIterable([1, 2, 3]);
  var users =
      ids.asyncMap((id) => Future.delayed(Duration(milliseconds: 10), () => 'User$id'));
  print('asyncMap results: ${await users.toList()}');

  // take and skip
  print('');
  print('--- take and skip ---');
  var numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print('take(3): ${await numbers.take(3).toList()}');

  numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print('skip(7): ${await numbers.skip(7).toList()}');

  // handleError
  print('');
  print('--- handleError ---');
  var errorProneStream = Stream.fromIterable([1, 2, 3]).map((n) {
    if (n == 2) throw 'Error at $n';
    return n;
  });

  var handled = errorProneStream.handleError((e) {
    print('  Handled: $e');
  });

  await for (var n in handled) {
    print('  Value: $n');
  }

  print('');
  print('=== End of Streams Demo ===');
}

// async* generator
Stream<int> countTo(int max) async* {
  for (var i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 20));
    yield i;
  }
}
