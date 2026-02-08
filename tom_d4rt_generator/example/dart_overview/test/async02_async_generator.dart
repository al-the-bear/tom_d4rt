// D4rt test: ASYNC02 - Async* generator (Stream)
// Verifies async* generators (Stream) work via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() async {
  var errors = <String>[];

  // countAsyncTo is an async* generator returning Stream<int>
  var collected = <int>[];
  await for (var n in countAsyncTo(3)) {
    collected.add(n);
  }

  if (collected.length != 3) {
    errors.add('countAsyncTo(3) expected 3 items, got ${collected.length}');
  }
  if (collected.isNotEmpty && collected[0] != 1) {
    errors.add('countAsyncTo first item expected 1, got ${collected[0]}');
  }
  if (collected.length >= 3 && collected[2] != 3) {
    errors.add('countAsyncTo last item expected 3, got ${collected[2]}');
  }

  if (errors.isEmpty) {
    print('ASYNC02_PASSED');
  } else {
    print('ASYNC02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
