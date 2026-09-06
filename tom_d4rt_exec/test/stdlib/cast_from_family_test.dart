import 'package:test/test.dart';
import '../interpreter_test.dart' show execute;

/// SCC11 part 2 — the `castFrom` family.
///
/// `castFrom` is the static counterpart of the instance `cast()`: it re-types an
/// existing collection or converter without copying it. `List.castFrom`,
/// `Stream.castFrom`, `StreamTransformer.castFrom` and (since SCC10)
/// `Queue.castFrom` were already bridged; `Iterable`, `Map`, `Set` and
/// `Converter` were not. Registering the whole family rather than the members
/// that happen to be asked for is the point — a partially-present family is
/// worse than an absent one, because the four that work teach the script author
/// to expect the fifth.
///
/// Type arguments are erased at the bridge boundary, so every adapter
/// instantiates the native call at `dynamic`. The observable contract is
/// therefore "same elements, live view of the source", which is what these
/// tests assert.
void main() {
  group('SCC11: the castFrom family', () {
    test('F-SCC11-19: Iterable.castFrom re-types an iterable [2026-09-04]', () {
      final result = execute('''
        main() {
          final source = [1, 2, 3].where((e) => e > 1);
          final cast = Iterable.castFrom(source);
          return cast.toList();
        }
      ''');
      expect(result, equals([2, 3]));
    });

    test('F-SCC11-20: the Iterable.castFrom result is a view, not a copy '
        '[2026-09-04]', () {
      // `castFrom` documents a view. A bridge that materialised a list would
      // pass the previous test and fail here, which is why both exist.
      final result = execute('''
        main() {
          final source = <Object?>[1, 2];
          final cast = Iterable.castFrom(source);
          source.add(3);
          return cast.length;
        }
      ''');
      expect(result, 3);
    });

    test('F-SCC11-21: Map.castFrom re-types a map [2026-09-04]', () {
      final result = execute('''
        main() {
          final cast = Map.castFrom({'a': 1, 'b': 2});
          return [cast.length, cast['b']];
        }
      ''');
      expect(result, equals([2, 2]));
    });

    test('F-SCC11-22: Set.castFrom re-types a set [2026-09-04]', () {
      final result = execute('''
        main() {
          final cast = Set.castFrom({1, 2, 3});
          return [cast.length, cast.contains(2)];
        }
      ''');
      expect(result, equals([3, true]));
    });

    test('F-SCC11-23: Converter.castFrom re-types a converter and still '
        'converts [2026-09-04]', () {
      final result = execute('''
        import 'dart:convert';
        main() {
          final cast = Converter.castFrom(utf8.encoder);
          return cast.convert('hi');
        }
      ''');
      expect(result, equals([104, 105]));
    });

    test('F-SCC11-24: castFrom rejects a source of the wrong kind with a '
        'diagnostic that names the expected type [2026-09-04]', () {
      // The failure mode worth guarding is a silent `null` or an opaque cast
      // error deep in the runtime. The message has to say what was expected.
      //
      // The assertion deliberately matches the adapter's own phrasing rather
      // than just the class name: `contains('Map')` would have been satisfied by
      // "Bridged class 'Map' has no static method named 'castFrom'" — i.e. it
      // would have passed while the member was still missing, which is the
      // opposite of what a red test is for.
      final result = execute('''
        main() {
          try {
            Map.castFrom([1, 2, 3]);
            return 'no-throw';
          } catch (e) {
            return e.toString().contains('must be a Map');
          }
        }
      ''');
      expect(result, true);
    });
  });
}
