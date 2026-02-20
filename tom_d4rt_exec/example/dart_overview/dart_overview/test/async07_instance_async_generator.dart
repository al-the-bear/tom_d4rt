// D4rt test: ASYNC07 - Instance async* method (Stream)
// Verifies that instance methods using async* returning Stream<T>
// are correctly bridged and can be consumed with await for in a D4rt script.
import 'package:dart_overview/dart_overview.dart';

void main() async {
  var errors = <String>[];

  // ── Create instance ──────────────────────────────────────────────

  var processor = DataProcessor('tag');

  // ── Test instance async* method ──────────────────────────────────

  var collected = <String>[];
  await for (var item in processor.streamItems(['a', 'b', 'c'])) {
    collected.add(item);
  }

  if (collected.length != 3) {
    errors.add('streamItems expected 3 items, got ${collected.length}');
  }
  if (collected.isNotEmpty && collected[0] != 'tag: a') {
    errors.add('streamItems[0] expected "tag: a", got "${collected[0]}"');
  }
  if (collected.length >= 3 && collected[2] != 'tag: c') {
    errors.add('streamItems[2] expected "tag: c", got "${collected[2]}"');
  }

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('ASYNC07_PASSED');
  } else {
    print('ASYNC07_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
