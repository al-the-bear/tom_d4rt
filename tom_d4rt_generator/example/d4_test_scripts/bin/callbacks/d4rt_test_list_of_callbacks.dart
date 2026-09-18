// sce35: a script passes a LIST of closures across the bridge, and the native
// side calls every element.
//
// A `List<Callback>` parameter used to emit a throw, so this script could not
// run at all. Compiling is not enough to prove the conversion works — these
// assertions turn on the native side actually INVOKING the elements and
// returning what they produced.

import 'package:d4_example/test_callback_types.dart';

void main() {
  // POSITIONAL: a list of callbacks as a method argument.
  final sink = ListCallbackSink();
  final positional = sink.runPositional([
    (int v) => v + 1,
    (int v) => v * 10,
  ], 5);
  // (5 + 1) + (5 * 10) == 56 — proves BOTH elements ran, and in order.
  if (positional != 56) {
    throw StateError('positional list of callbacks: expected 56, got $positional');
  }

  // NAMED: a list of callbacks through a constructor argument.
  final named = ListCallbackSink(handlers: [
    (int v) => v + 2,
    (int v) => v * 100,
  ]);
  if (named.namedCount != 2) {
    throw StateError('named list arrived with ${named.namedCount} handlers, expected 2');
  }
  final namedSum = named.runNamed(3);
  // (3 + 2) + (3 * 100) == 305
  if (namedSum != 305) {
    throw StateError('named list of callbacks: expected 305, got $namedSum');
  }

  // An empty list must stay empty rather than becoming null.
  final empty = ListCallbackSink(handlers: []);
  if (empty.namedCount != 0) {
    throw StateError('empty list became ${empty.namedCount} handlers');
  }

  print('LIST_CALLBACK_TESTS_PASSED');
}
