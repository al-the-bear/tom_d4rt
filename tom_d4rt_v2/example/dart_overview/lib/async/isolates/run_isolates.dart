/// Demonstrates Dart Isolates
///
/// Features covered:
/// - Basic Isolate.run
/// - Compute-intensive operations
/// - Passing data to isolates
/// - Receiving results from isolates

import 'dart:isolate';

Future<void> main() async {
  print('=== Isolates ===');
  print('');

  // Basic Isolate.run
  print('--- Basic Isolate.run ---');
  print('Starting computation in isolate...');
  var result = await Isolate.run(() {
    // This runs in a separate isolate
    var sum = 0;
    for (var i = 1; i <= 1000000; i++) {
      sum += i;
    }
    return sum;
  });
  print('Sum of 1 to 1,000,000: $result');

  // Passing data to isolate
  print('');
  print('--- Passing Data to Isolate ---');
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var squared = await Isolate.run(() {
    return numbers.map((n) => n * n).toList();
  });
  print('Squared: $squared');

  // Complex computation
  print('');
  print('--- Complex Computation ---');
  print('Computing primes...');
  var primes = await Isolate.run(() => findPrimes(1000));
  print('Primes up to 1000: ${primes.length} found');
  print('First 10: ${primes.take(10).toList()}');
  print('Last 10: ${primes.skip(primes.length - 10).toList()}');

  // Multiple isolates
  print('');
  print('--- Multiple Isolates ---');
  print('Running parallel computations...');
  var start = DateTime.now();

  var results = await Future.wait([
    Isolate.run(() => fibonacci(35)),
    Isolate.run(() => fibonacci(35)),
    Isolate.run(() => fibonacci(35)),
  ]);

  var elapsed = DateTime.now().difference(start).inMilliseconds;
  print('Fibonacci(35) x3: $results');
  print('Time: ${elapsed}ms');

  // Passing complex data
  print('');
  print('--- Passing Complex Data ---');
  var data = DataPackage('Test', [1, 2, 3, 4, 5]);
  var processed = await Isolate.run(() {
    // Process the data
    return DataPackage(
      data.name.toUpperCase(),
      data.values.map((v) => v * 10).toList(),
    );
  });
  print('Original: ${data.name}, ${data.values}');
  print('Processed: ${processed.name}, ${processed.values}');

  // Error handling in isolates
  print('');
  print('--- Error Handling ---');
  try {
    await Isolate.run(() {
      throw Exception('Error in isolate');
    });
  } catch (e) {
    print('Caught from isolate: $e');
  }

  // Note about limitations
  print('');
  print('--- Isolate Limitations ---');
  print('Isolates:');
  print('  - Cannot share mutable state');
  print('  - Data is copied (or transferred)');
  print('  - Good for CPU-intensive work');
  print('  - Not needed for I/O-bound async work');

  print('');
  print('=== End of Isolates Demo ===');
}

// Find prime numbers
List<int> findPrimes(int max) {
  var primes = <int>[];
  for (var n = 2; n <= max; n++) {
    var isPrime = true;
    for (var i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) primes.add(n);
  }
  return primes;
}

// Fibonacci (intentionally slow recursive version)
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

// Data class for passing to isolate
class DataPackage {
  final String name;
  final List<int> values;

  DataPackage(this.name, this.values);
}
