import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// SC3 — `dart:collection` `UnmodifiableMapView` bridge.
///
/// `Map.unmodifiable(...)` already returned an `UnmodifiableMapView` at runtime
/// before this bridge existed, and the core `Map` bridge claimed it by name — so
/// *reading* through such a view worked, and a mutation attempt surfaced the
/// native `UnsupportedError` that `on UnsupportedError` could catch. What did
/// not work was naming the type: `UnmodifiableMapView(...)` was an undefined
/// variable and `x is UnmodifiableMapView` failed the type check.
///
/// The mutation tests therefore assert on `UnsupportedError` rather than on a
/// `RuntimeD4rtException` message: the bridge must keep *delegating* mutators to
/// the native view instead of intercepting them, or scripts that catch the SDK
/// error type today would silently stop catching it.
///
/// **`F-SC3-21` still characterizes `is Map` as a gap here, and must not be
/// flipped yet.** The supertype `is` fix landed in `tom_d4rt` and in the
/// `tom_d4rt_ast` working tree, but this package resolves `tom_d4rt_ast` from
/// pub.dev, so the fix does not reach it until that package is republished and
/// the constraint bumped. Flipping the assertion before then turns a working
/// suite red for a reason that has nothing to do with this bridge. The flip is
/// tracked as a step on the follow-up that owns the republish.
void main() {
  final d4rt = D4rt();

  String viewSource(String mapContents, String operations) => '''
    import 'dart:collection';
    main() {
      final source = $mapContents;
      final view = UnmodifiableMapView(source);
      $operations
    }
  ''';

  group('SC3: UnmodifiableMapView collection bridge', () {
    test('F-SC3-1: the constructor wraps a map and reads through it [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1, 'b': 2}",
            "return [view['a'], view['b'], view['zz'], view.length];"),
      ) as List;
      expect(result, orderedEquals([1, 2, null, 2]));
    });

    test('F-SC3-2: exposes the read-only Map getters [2026-07-27]', () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1, 'b': 2}",
            'return [view.length, view.isEmpty, view.isNotEmpty, view.keys.toList(), view.values.toList()];'),
      ) as List;
      expect(result[0], 2);
      expect(result[1], false);
      expect(result[2], true);
      expect(result[3], orderedEquals(['a', 'b']));
      expect(result[4], orderedEquals([1, 2]));
    });

    test('F-SC3-3: containsKey / containsValue read through [2026-07-27]', () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1}",
            "return [view.containsKey('a'), view.containsKey('b'), view.containsValue(1), view.containsValue(9)];"),
      ) as List;
      expect(result, orderedEquals([true, false, true, false]));
    });

    test('F-SC3-4: forEach and map run the script callback [2026-07-27]', () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1, 'b': 2}", '''
          final seen = [];
          view.forEach((k, v) => seen.add('\$k=\$v'));
          final doubled = view.map((k, v) => MapEntry(k, v * 2));
          return [seen, doubled['a'], doubled['b']];
        '''),
      ) as List;
      expect(result[0], orderedEquals(['a=1', 'b=2']));
      expect(result[1], 2);
      expect(result[2], 4);
    });

    test('F-SC3-5: entries exposes MapEntry key/value pairs [2026-07-27]', () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1, 'b': 2}",
            "return view.entries.map((e) => '\${e.key}:\${e.value}').toList();"),
      ) as List;
      expect(result, orderedEquals(['a:1', 'b:2']));
    });

    test('F-SC3-6: the view reflects later changes to the backing map [2026-07-27]',
        () {
      // This is the defining property of a *view* over a copy: the wrapper does
      // not snapshot, so a test that only checked the initial contents would
      // pass just as well against `Map.of(...)` and would pin nothing.
      final result = d4rt.execute(
        source: viewSource("{'a': 1}", '''
          final before = view.length;
          source['b'] = 2;
          return [before, view.length, view['b']];
        '''),
      ) as List;
      expect(result, orderedEquals([1, 2, 2]));
    });

    test('F-SC3-7: []= throws an UnsupportedError catchable by type [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1}", '''
          try {
            view['b'] = 2;
          } on UnsupportedError catch (e) {
            return 'unsupported';
          } catch (e) {
            return 'wrong-type';
          }
          return 'no-throw';
        '''),
      );
      expect(result, 'unsupported');
    });

    test('F-SC3-8: remove and clear also throw UnsupportedError [2026-07-27]',
        () {
      for (final mutation in <String>[
        "view.remove('a');",
        'view.clear();',
        "view.addAll({'b': 2});",
        "view.putIfAbsent('b', () => 2);",
      ]) {
        final result = d4rt.execute(
          source: viewSource("{'a': 1}", '''
            try {
              $mutation
            } on UnsupportedError catch (e) {
              return 'unsupported';
            } catch (e) {
              return 'wrong-type';
            }
            return 'no-throw';
          '''),
        );
        expect(result, 'unsupported', reason: 'for mutation `$mutation`');
      }
    });

    test('F-SC3-9: an unmodifiable view is type-testable [2026-07-27]', () {
      final result = d4rt.execute(
        source: viewSource("{'a': 1}",
            'return [view is UnmodifiableMapView, source is UnmodifiableMapView];'),
      ) as List;
      expect(result, orderedEquals([true, false]));
    });

    test('F-SC3-21: `is Map` on a bridged map subtype is a known gap [2026-07-27]',
        () {
      // Characterization, not endorsement. `x is Map` is false for *every*
      // bridged `dart:collection` map — `HashMap`, `SplayTreeMap` and
      // `Map.unmodifiable(...)` all behave this way, and did so before this
      // bridge existed, so it is not something SC3 introduced or can fix
      // locally. (The `Set` side works only because `SetCore.nativeNames`
      // enumerates the concrete runtime type names.) Tracked as a follow-up;
      // when supertype checks start working this test goes red and should be
      // folded back into F-SC3-9.
      final result = d4rt.execute(
        source: viewSource("{'a': 1}", 'return view is Map;'),
      );
      expect(result, isFalse);
    });

    test('F-SC3-10: Map.unmodifiable() results are the same bridged type [2026-07-27]',
        () {
      // `Map.unmodifiable` already returned an `UnmodifiableMapView` before this
      // bridge existed; the point of the assertion is that adding the bridge did
      // not change what that factory produces or how it reads.
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final m = Map.unmodifiable({'a': 1});
            return [m is UnmodifiableMapView, m['a'], m.length];
          }
        ''',
      ) as List;
      expect(result, orderedEquals([true, 1, 1]));
    });
  });
}
