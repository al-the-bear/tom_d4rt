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

  /// SCD37 — the one `castFrom` argument that cannot be honoured.
  ///
  /// `Set.castFrom<S, T>(Set<S> source, {Set<R> Function<R>()? newSet})` is the
  /// only member in the whole bridged surface whose parameter is a GENERIC
  /// function: one the callee instantiates at a type the caller never writes.
  /// Swept against the SDK source of 3.12.2 across `core`, `collection`,
  /// `convert`, `async`, `typed_data` and `io` — `newSet` is the single hit on
  /// a bridged member. (`dart:mirrors` cannot find these: it erases the `<R>`,
  /// reporting the type as the plain `() -> Set`, so the sweep has to read the
  /// SDK sources.)
  ///
  /// **The rejection is the feature.** The bridge could accept `newSet` and
  /// ignore it, and every test here would still pass except the first — which
  /// is exactly why the first one is written as a throw rather than as a value
  /// comparison. A dropped `newSet` returns a view over a `LinkedHashSet` where
  /// the caller asked for a `SplayTreeSet`, and the script then misbehaves far
  /// from this call, in ordering that looks like a collection bug.
  group('SCD37: Set.castFrom rejects its generic-function argument', () {
    test('F-SCD37-1: passing `newSet` throws rather than silently dropping it '
        '[2026-09-12]', () {
      final result = execute('''
        main() {
          try {
            Set.castFrom({1, 2}, newSet: () => <int>{});
            return 'ACCEPTED-AND-IGNORED';
          } catch (e) {
            return 'rejected';
          }
        }
      ''');
      expect(
        result,
        'rejected',
        reason:
            'A silently dropped `newSet` is the failure this member is written '
            'to avoid: the caller asked for a specific set implementation and '
            'would get a LinkedHashSet view instead.',
      );
    });

    test('F-SCD37-2: the diagnostic names the parameter and says why '
        '[2026-09-12]', () {
      // Both halves are required by SCD37: a bare type-check failure would
      // satisfy F-SCD37-1 while telling the script author nothing about which
      // argument is at fault or whether it is worth retrying differently.
      final result = execute('''
        main() {
          try {
            Set.castFrom({1, 2}, newSet: () => <int>{});
            return 'no-throw';
          } catch (e) {
            final m = e.toString();
            return m.contains('newSet') && m.contains('generic function');
          }
        }
      ''');
      expect(result, true);
    });

    test('F-SCD37-3: an unknown named argument gets its own diagnostic, not '
        "`newSet`'s [2026-09-12]", () {
      // The adapter rejected on `namedArgs.isNotEmpty`, so `newFoo:` produced
      // the `newSet` paragraph -- pointing the reader at a limitation that has
      // nothing to do with what they wrote.
      final result = execute('''
        main() {
          try {
            Set.castFrom({1, 2}, newFoo: 1);
            return 'no-throw';
          } catch (e) {
            final m = e.toString();
            return m.contains('newFoo') && !m.contains('generic function');
          }
        }
      ''');
      expect(result, true);
    });

    test('F-SCD37-4: the plain form still works, so the rejection is not '
        'over-broad [2026-09-12]', () {
      final result = execute('''
        main() {
          final cast = Set.castFrom({1, 2, 3});
          return cast.length;
        }
      ''');
      expect(result, 3);
    });

    test('F-SCD37-5: Map.castFrom has no such parameter in this SDK, and the '
        'bridge refuses one [2026-09-12]', () {
      // SCD37's premise was that `Map.castFrom` has the same shape and might
      // already be dropping the argument silently. It does not: SDK 3.12.2
      // declares `Map.castFrom<K, V, K2, V2>(Map<K, V> source)` with no named
      // parameter at all. The bridge refusing one is therefore the correct
      // answer and not the same defect -- a bridge must not accept what the
      // SDK rejects. Pinned so the claim is measured rather than remembered.
      final result = execute('''
        main() {
          try {
            Map.castFrom({'a': 1}, newMap: () => {});
            return 'ACCEPTED';
          } catch (e) {
            return 'rejected';
          }
        }
      ''');
      expect(result, 'rejected');
    });
  });
}
