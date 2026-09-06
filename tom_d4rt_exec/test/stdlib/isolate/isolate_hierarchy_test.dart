// SCC57: `dart:isolate` had no supertype edges either. It is a three-edge
// library, but two of the three are the kind a script hits on its first use:
//
//     ReceivePort() is Stream         // false — ReceivePort implements Stream
//     RemoteError(...) is Error       // false — RemoteError extends Error
//
// The `ReceivePort` one is the sharper of the two. A port is consumed with
// `await for` or `.listen`, so every piece of advice about isolates tells the
// reader they are holding a stream; a `is Stream` guard written around that
// advice answered false.
//
// `SendPort -> Capability` was already true before SCC57, via
// `CapabilityIsolate.isAssignable`, and is declared for the same reason the
// `dart:core` block declares `RegExpMatch -> Match`: the hierarchy should be
// readable from one place rather than inferred from a predicate in another file.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('SCC57: the dart:isolate edges', () {
    test('F-SCC57-41: `ReceivePort` is a `Stream` [2026-09-06]', () {
      expect(
        execute('''
import 'dart:isolate';
main() {
  final p = ReceivePort();
  final answer = p is Stream;
  p.close();
  return answer;
}
'''),
        isTrue,
        reason: 'class ReceivePort implements Stream<dynamic>',
      );
    });

    test('F-SCC57-42: `RemoteError` is an `Error` [2026-09-06]', () {
      expect(
        execute(
          "import 'dart:isolate'; "
          "main() => RemoteError('e', 's') is Error;",
        ),
        isTrue,
        reason: 'class RemoteError extends Error',
      );
    });

    test('F-SCC57-43: `SendPort` is a `Capability` [2026-09-06]', () {
      // True before SCC57 as well, answered by `Capability`'s `isAssignable`.
      expect(
        execute('''
import 'dart:isolate';
main() {
  final p = ReceivePort();
  final answer = p.sendPort is Capability;
  p.close();
  return answer;
}
'''),
        isTrue,
      );
    });

    test('F-SCC57-44: dispatch is unchanged [2026-09-06]', () {
      // `Stream` and `Error` both declare `isAssignable`, so this block can move
      // `_filterToMostSpecific` on `ReceivePort`. `sendPort` exists on the port
      // and not on `Stream`; if the `Stream` bridge started winning, this fails
      // with "has no getter named".
      expect(
        execute('''
import 'dart:isolate';
main() {
  final p = ReceivePort();
  final answer = p.sendPort != null;
  p.close();
  return answer;
}
'''),
        isTrue,
      );
      expect(
        execute(
          "import 'dart:isolate'; "
          "main() => RemoteError('e', 's') is Exception;",
        ),
        isFalse,
        reason: 'RemoteError extends Error, which is not an Exception',
      );
    });
  });
}
