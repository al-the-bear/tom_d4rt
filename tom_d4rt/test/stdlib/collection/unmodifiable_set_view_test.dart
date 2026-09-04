import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// SC3 — `dart:collection` `UnmodifiableSetView` bridge.
///
/// Companion to `unmodifiable_map_view_test.dart`; see that file's header for
/// why the mutation assertions target `UnsupportedError` rather than a
/// `RuntimeD4rtException` message.
void main() {
  final d4rt = D4rt();

  String viewSource(String setContents, String operations) =>
      '''
    import 'dart:collection';
    main() {
      final source = $setContents;
      final view = UnmodifiableSetView(source);
      $operations
    }
  ''';

  group('SC3: UnmodifiableSetView collection bridge', () {
    test(
      'F-SC3-11: the constructor wraps a set and reads through it [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: viewSource(
                    '{1, 2, 3}',
                    'return [view.length, view.contains(2), view.contains(9), view.toList()];',
                  ),
                )
                as List;
        expect(result[0], 3);
        expect(result[1], true);
        expect(result[2], false);
        expect(result[3], orderedEquals([1, 2, 3]));
      },
    );

    test('F-SC3-12: exposes the read-only Set getters [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: viewSource(
                  "{'x', 'y'}",
                  'return [view.length, view.isEmpty, view.isNotEmpty, view.first, view.last];',
                ),
              )
              as List;
      expect(result, orderedEquals([2, false, true, 'x', 'y']));
    });

    test(
      'F-SC3-13: the Iterable surface runs script callbacks [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: viewSource('{1, 2, 3, 4}', '''
          final seen = [];
          view.forEach((e) => seen.add(e));
          return [
            seen,
            view.where((e) => e.isEven).toList(),
            view.map((e) => e * 10).toList(),
            view.any((e) => e > 3),
            view.every((e) => e > 0),
            view.fold(0, (a, b) => a + b),
          ];
        '''),
                )
                as List;
        expect(result[0], orderedEquals([1, 2, 3, 4]));
        expect(result[1], orderedEquals([2, 4]));
        expect(result[2], orderedEquals([10, 20, 30, 40]));
        expect(result[3], true);
        expect(result[4], true);
        expect(result[5], 10);
      },
    );

    test(
      'F-SC3-14: set algebra returns plain modifiable sets [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: viewSource('{1, 2, 3}', '''
          return [
            view.union({3, 4}).toList(),
            view.intersection({2, 3, 9}).toList(),
            view.difference({1}).toList(),
            view.lookup(2),
          ];
        '''),
                )
                as List;
        expect(result[0], orderedEquals([1, 2, 3, 4]));
        expect(result[1], orderedEquals([2, 3]));
        expect(result[2], orderedEquals([2, 3]));
        expect(result[3], 2);
      },
    );

    test(
      'F-SC3-15: the view reflects later changes to the backing set [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: viewSource('{1}', '''
          final before = view.length;
          source.add(2);
          return [before, view.length, view.contains(2)];
        '''),
                )
                as List;
        expect(result, orderedEquals([1, 2, true]));
      },
    );

    test(
      'F-SC3-16: add throws an UnsupportedError catchable by type [2026-07-27]',
      () {
        final result = d4rt.execute(
          source: viewSource('{1}', '''
          try {
            view.add(2);
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

    test(
      'F-SC3-17: the other mutators also throw UnsupportedError [2026-07-27]',
      () {
        for (final mutation in <String>[
          'view.addAll({2});',
          'view.remove(1);',
          'view.removeAll({1});',
          'view.retainAll({1});',
          'view.removeWhere((e) => true);',
          'view.retainWhere((e) => false);',
          'view.clear();',
        ]) {
          final result = d4rt.execute(
            source: viewSource('{1}', '''
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
      },
    );

    test('F-SC3-18: an unmodifiable view is type-testable [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: viewSource(
                  '{1}',
                  'return [view is UnmodifiableSetView, view is Set, source is UnmodifiableSetView];',
                ),
              )
              as List;
      expect(result, orderedEquals([true, true, false]));
    });

    test(
      'F-SC3-19: Set.unmodifiable() results are the same bridged type [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final s = Set.unmodifiable([1, 2]);
            return [s is UnmodifiableSetView, s.length, s.contains(2)];
          }
        ''',
                )
                as List;
        expect(result, orderedEquals([true, 2, true]));
      },
    );

    test('F-SC3-20: the two views stay distinct bridges [2026-07-27]', () {
      // If a set view were captured by the map-view bridge (or vice versa),
      // dispatch would offer the wrong member surface for whichever type lost.
      final result =
          d4rt.execute(
                source: '''
          import 'dart:collection';
          main() {
            final m = UnmodifiableMapView({'a': 1});
            final s = UnmodifiableSetView({1});
            return [
              m is UnmodifiableMapView, m is UnmodifiableSetView,
              s is UnmodifiableSetView, s is UnmodifiableMapView,
            ];
          }
        ''',
              )
              as List;
      expect(result, orderedEquals([true, false, true, false]));
    });
  });
}
