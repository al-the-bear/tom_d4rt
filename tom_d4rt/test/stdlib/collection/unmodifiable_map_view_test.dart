import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

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
/// `F-SC3-9` asserts the `Map` SUPERTYPE as well as the exact type, on the view
/// and on the plain map it wraps. Supertype `is` is a different mechanism from
/// exact-type `is` — it resolves through a registered edge in the bridge
/// hierarchy rather than by matching a name — so a case that only checked
/// `view is UnmodifiableMapView` passes with every supertype edge missing, which
/// is the state `dart:collection` was in when this bridge was added.
void main() {
  final d4rt = D4rt();

  String viewSource(String mapContents, String operations) =>
      '''
    import 'dart:collection';
    main() {
      final source = $mapContents;
      final view = UnmodifiableMapView(source);
      $operations
    }
  ''';

  group('SC3: UnmodifiableMapView collection bridge', () {
    test(
      'F-SC3-1: the constructor wraps a map and reads through it [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: viewSource(
                    "{'a': 1, 'b': 2}",
                    "return [view['a'], view['b'], view['zz'], view.length];",
                  ),
                )
                as List;
        expect(result, orderedEquals([1, 2, null, 2]));
      },
    );

    test('F-SC3-2: exposes the read-only Map getters [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: viewSource(
                  "{'a': 1, 'b': 2}",
                  'return [view.length, view.isEmpty, view.isNotEmpty, view.keys.toList(), view.values.toList()];',
                ),
              )
              as List;
      expect(result[0], 2);
      expect(result[1], false);
      expect(result[2], true);
      expect(result[3], orderedEquals(['a', 'b']));
      expect(result[4], orderedEquals([1, 2]));
    });

    test('F-SC3-3: containsKey / containsValue read through [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: viewSource(
                  "{'a': 1}",
                  "return [view.containsKey('a'), view.containsKey('b'), view.containsValue(1), view.containsValue(9)];",
                ),
              )
              as List;
      expect(result, orderedEquals([true, false, true, false]));
    });

    test('F-SC3-4: forEach and map run the script callback [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: viewSource("{'a': 1, 'b': 2}", '''
          final seen = [];
          view.forEach((k, v) => seen.add('\$k=\$v'));
          final doubled = view.map((k, v) => MapEntry(k, v * 2));
          return [seen, doubled['a'], doubled['b']];
        '''),
              )
              as List;
      expect(result[0], orderedEquals(['a=1', 'b=2']));
      expect(result[1], 2);
      expect(result[2], 4);
    });

    test('F-SC3-5: entries exposes MapEntry key/value pairs [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: viewSource(
                  "{'a': 1, 'b': 2}",
                  "return view.entries.map((e) => '\${e.key}:\${e.value}').toList();",
                ),
              )
              as List;
      expect(result, orderedEquals(['a:1', 'b:2']));
    });

    test(
      'F-SC3-6: the view reflects later changes to the backing map [2026-07-27]',
      () {
        // This is the defining property of a *view* over a copy: the wrapper does
        // not snapshot, so a test that only checked the initial contents would
        // pass just as well against `Map.of(...)` and would pin nothing.
        final result =
            d4rt.execute(
                  source: viewSource("{'a': 1}", '''
          final before = view.length;
          source['b'] = 2;
          return [before, view.length, view['b']];
        '''),
                )
                as List;
        expect(result, orderedEquals([1, 2, 2]));
      },
    );

    test(
      'F-SC3-7: []= throws an UnsupportedError catchable by type [2026-07-27]',
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
      },
    );

    test('F-SC3-8: every other mutating member also throws UnsupportedError '
        '[2026-07-27]', () {
      // SCE95 took this from four members to seven. The four it had were the
      // ones a reader thinks of first, and `Map`'s mutating surface is nine:
      // `[]=` has its own case above, `addEntries` has its own below, and
      // these seven are the rest. Measured before the change, a script
      // reached 5 of the 9 — the ast twin's registration-level file had the
      // same shallowness on the same view, which is what made it worth
      // closing here too.
      //
      // THE ARGUMENTS ARE THE ONLY THINKING. Each adapter narrows its
      // parameters before it reaches the native view, so an argument it
      // rejects makes the case pass for the wrong reason: it would report
      // the argument problem and never delegate. `update` takes a key and a
      // one-argument callable, `removeWhere` and `updateAll` take a
      // two-argument one. `tom_d4rt_ast`'s `_mutatingMapCalls` table records
      // the same shapes for the adapter-level calls.
      for (final mutation in <String>[
        "view.remove('a');",
        'view.clear();',
        "view.addAll({'b': 2});",
        "view.putIfAbsent('b', () => 2);",
        'view.removeWhere((k, v) => true);',
        "view.update('a', (v) => 2);",
        'view.updateAll((k, v) => 2);',
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

    test('F-SC3-21: addEntries throws UnsupportedError, through Map\'s adapter '
        '[2026-09-21]', () {
      // ITS OWN CASE BECAUSE ITS RESOLUTION PATH IS ITS OWN. No bridge on
      // the map view declares `addEntries`: SCC51 deleted the local copy,
      // which could not unwrap a `BridgedInstance<MapEntry>`, so `Map`'s
      // adapter answers. A script calling it therefore exercises a hop the
      // other eight mutators do not, and it is the member most likely to
      // break for a reason that has nothing to do with the view being
      // unmodifiable — which is exactly why folding it into the loop above
      // would hide what it tests.
      //
      // `{'c': 3}.entries` rather than a `MapEntry` literal: that is what a
      // script writes, and it is the form whose elements arrive as native
      // entries at the adapter boundary.
      final result = d4rt.execute(
        source: viewSource("{'a': 1}", '''
          try {
            view.addEntries({'c': 3}.entries);
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

    test('F-SC3-9: an unmodifiable view is type-testable [2026-07-27]', () {
      // The exact type and the `Map` supertype are both testable. The
      // supertype half used to be a characterized gap (`is Map` was false for
      // every bridged `dart:collection` map, `HashMap` and `SplayTreeMap`
      // included) and is asserted here now that it holds — a view is a `Map`,
      // and so is the plain map it wraps, while only the view is an
      // `UnmodifiableMapView`.
      final result =
          d4rt.execute(
                source: viewSource(
                  "{'a': 1}",
                  'return [view is UnmodifiableMapView, source is UnmodifiableMapView, '
                      'view is Map, source is Map];',
                ),
              )
              as List;
      expect(result, orderedEquals([true, false, true, true]));
    });

    test(
      'F-SC3-10: Map.unmodifiable() results are the same bridged type [2026-07-27]',
      () {
        // `Map.unmodifiable` already returned an `UnmodifiableMapView` before this
        // bridge existed; the point of the assertion is that adding the bridge did
        // not change what that factory produces or how it reads.
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final m = Map.unmodifiable({'a': 1});
            return [m is UnmodifiableMapView, m['a'], m.length];
          }
        ''',
                )
                as List;
        expect(result, orderedEquals([true, 1, 1]));
      },
    );
  });
}
