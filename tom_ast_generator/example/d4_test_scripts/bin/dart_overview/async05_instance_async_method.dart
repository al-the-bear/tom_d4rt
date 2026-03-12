// D4rt test: ASYNC05 - Instance async method (Future)
// Verifies that instance methods marked `async` returning Future<T>
// are correctly bridged and can be awaited from a D4rt script.
import 'package:d4_example/dart_overview.dart';

void main() async {
  var errors = <String>[];

  // ── Create instance ──────────────────────────────────────────────

  var processor = DataProcessor('test');

  // ── Test instance async method ───────────────────────────────────

  var result = await processor.processAsync('hello');
  if (result != 'test: hello') {
    errors.add('processAsync("hello") expected "test: hello", got "$result"');
  }

  // Test with different prefix
  var processor2 = DataProcessor('debug');
  var result2 = await processor2.processAsync('world');
  if (result2 != 'debug: world') {
    errors.add('processAsync("world") expected "debug: world", got "$result2"');
  }

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('ASYNC05_PASSED');
  } else {
    print('ASYNC05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
