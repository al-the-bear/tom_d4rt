// SCB7: `is` against a bridged collection's supertype.
//
// Two independent defects made supertype `is` checks unreliable for bridged
// `dart:collection` values:
//
//   1. `visitIsExpression` special-cases the *shape* types (`int`, `double`,
//      `num`, `String`, `bool`, `List`, `Map`) with a hardcoded switch that
//      tested the operand with a native `is`. A bridged value arrives as a
//      `BridgedInstance` wrapper, so `expressionValue is! List` and
//      `expressionValue is! Map` were true for every bridged collection and
//      the answer was always `false`. `Set` and `Iterable` are absent from
//      that switch, fell through to the `default` branch, and therefore went
//      down the bridged-subtype path — which is why the Set side appeared to
//      work while the Map and List sides did not.
//
//   2. Nothing declared the collection hierarchy to `BridgedClass`'s supertype
//      registry, so even on the bridged path `HashSet is Iterable` could only
//      succeed for the one class whose native runtime type happened to be
//      enumerated in `SetCore.nativeNames`.
//
// The fix normalises the operand for the shape cases (keeping the generic
// argument checks those cases carry) and declares the hierarchy with
// `BridgedClass.registerSupertypes` in `CollectionHierarchyCollection`.
// `registerSupertypes` — deliberately not `isAssignable` — is used because
// `isAssignable` is what `Environment.toBridgedInstance` consults to pick which
// bridge OWNS a native object; a supertype claiming assignability would steal
// dispatch from the concrete bridge.
//
// **Type tests are implemented ONCE, in `_valueHasType`.** They were not always,
// and that is why this file has the shape it has. When it was written the same
// question was answered by four separate bodies — the `is` operator, the catch
// clause, the declared-type check and the pattern matcher — each with its own
// switch over hardcoded type names, so a fix to one did not reach the others.
// F-SCB7-11 exists as a case distinct from everything above it for exactly that
// reason: it asks the catch clause the same question the `is` cases ask, because
// at the time only measuring both could tell you whether both worked.
//
// SCC18 extracted `_valueHasType` from `visitIsExpression` and pointed the
// declared-type check and the pattern matcher at it. SCC20 folded in the catch
// clause, deliberately left for last: `on T` starts from a value that may be an
// interpreter exception wrapper rather than the thrown value, and the two trees
// had drifted apart on precisely that code — SCB7's own fix had to be placed
// differently in each. All four call sites now share one predicate, in both
// trees.
//
// So F-SCB7-11 no longer guards against a divergent *copy*; it guards against
// the catch clause being disconnected from the predicate again. Keep it. It is
// the only case here that reaches the type test through `on T` rather than `is`,
// and that path carries one deliberate asymmetry: an unresolvable `on T` must
// MISS rather than throw, so a lookup failure cannot replace the exception being
// dispatched. `scc20_catch_clause_type_test.dart` characterizes the fold and the
// four user-visible bugs the divergence had been hiding.
//
// The pattern-matching body this header used to describe as "does not evaluate
// its type at all" — a bare typed pattern matching unconditionally, so the first
// `switch` arm always won — was the fourth copy, and SCC18 fixed it by deleting
// it. `scc18_typed_pattern_type_test.dart` characterizes that.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  /// Evaluates `<expr> is <target>` in interpreted code.
  bool isCheck(String expr, String target) {
    final result = d4rt.execute(
      source: '''
        import 'dart:collection';
        main() {
          final x = $expr;
          return x is $target;
        }
      ''',
    );
    expect(result, isA<bool>(),
        reason: '`$expr is $target` did not evaluate to a bool');
    return result as bool;
  }

  void expectIs(String expr, String target, {required bool expected}) {
    expect(isCheck(expr, target), expected,
        reason: '`$expr is $target` should be $expected');
  }

  group('SCB7: bridged collection supertype `is` checks', () {
    test('F-SCB7-1: every bridged map subtype answers `is Map` [2026-07-28]',
        () {
      for (final expr in [
        'HashMap<String, int>()',
        'LinkedHashMap<String, int>()',
        'SplayTreeMap<String, int>()',
        "UnmodifiableMapView({'a': 1})",
        "Map.unmodifiable({'a': 1})",
      ]) {
        expectIs(expr, 'Map', expected: true);
      }
    });

    test('F-SCB7-2: every bridged set subtype answers `is Set` [2026-07-28]',
        () {
      for (final expr in [
        'HashSet<int>()',
        'LinkedHashSet<int>()',
        'SplayTreeSet<int>()',
        'UnmodifiableSetView({1})',
      ]) {
        expectIs(expr, 'Set', expected: true);
      }
    });

    test('F-SCB7-3: UnmodifiableListView answers `is List` [2026-07-28]', () {
      expectIs('UnmodifiableListView([1, 2, 3])', 'List', expected: true);
      expectIs('List.unmodifiable([1, 2, 3])', 'List', expected: true);
    });

    test('F-SCB7-4: bridged iterables answer `is Iterable` [2026-07-28]', () {
      for (final expr in [
        'HashSet<int>()',
        'LinkedHashSet<int>()',
        'SplayTreeSet<int>()',
        'UnmodifiableSetView({1})',
        'UnmodifiableListView([1, 2, 3])',
        'Queue<int>()',
        'ListQueue<int>()',
        'DoubleLinkedQueue<int>()',
      ]) {
        expectIs(expr, 'Iterable', expected: true);
      }
    });

    test('F-SCB7-5: maps are not Iterable [2026-07-28]', () {
      // Guard-rail: `Map` does not implement `Iterable` in Dart, so widening
      // the map hierarchy must not accidentally make it one.
      for (final expr in [
        'HashMap<String, int>()',
        'SplayTreeMap<String, int>()',
        "UnmodifiableMapView({'a': 1})",
      ]) {
        expectIs(expr, 'Iterable', expected: false);
      }
    });

    test('F-SCB7-6: `is` still discriminates between collection kinds '
        '[2026-07-28]', () {
      expectIs('HashMap<String, int>()', 'Set', expected: false);
      expectIs('HashMap<String, int>()', 'List', expected: false);
      expectIs('HashSet<int>()', 'Map', expected: false);
      expectIs('HashSet<int>()', 'List', expected: false);
      expectIs('UnmodifiableListView([1])', 'Map', expected: false);
      expectIs('UnmodifiableListView([1])', 'Set', expected: false);
      expectIs("UnmodifiableMapView({'a': 1})", 'String', expected: false);
      expectIs('HashSet<int>()', 'num', expected: false);
    });

    test('F-SCB7-7: the generic argument check survives on bridged operands '
        '[2026-07-28]', () {
      // The `List`/`Map` switch cases carry `_checkGenericListType` /
      // `_checkGenericMapType`, which the generic bridged path does not have.
      // Normalising the operand must keep those reachable rather than route
      // shape checks away from them.
      expectIs('UnmodifiableListView([1, 2, 3])', 'List<int>', expected: true);
      expectIs('UnmodifiableListView([1, 2, 3])', 'List<String>',
          expected: false);
      expectIs("UnmodifiableMapView({'a': 1})", 'Map<String, int>',
          expected: true);
      expectIs("UnmodifiableMapView({'a': 1})", 'Map<int, String>',
          expected: false);
    });

    test('F-SCB7-8: native literals are unaffected [2026-07-28]', () {
      expectIs('[1, 2, 3]', 'List', expected: true);
      expectIs('[1, 2, 3]', 'Iterable', expected: true);
      expectIs("{'a': 1}", 'Map', expected: true);
      expectIs('{1, 2}', 'Set', expected: true);
      expectIs('{1, 2}', 'Iterable', expected: true);
      expectIs('[1, 2, 3]', 'Map', expected: false);
      expectIs("{'a': 1}", 'List', expected: false);
      expectIs('42', 'num', expected: true);
      expectIs("'s'", 'String', expected: true);
    });

    test('F-SCB7-9: `is!` is the exact negation [2026-07-28]', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final m = HashMap<String, int>();
            final s = UnmodifiableSetView({1});
            return [m is! Map, m is! Set, s is! Iterable, s is! Map];
          }
        ''',
      ) as List;
      expect(result, orderedEquals([false, true, false, true]));
    });

    test('F-SCB7-10: a successful supertype `is` narrows for member access '
        '[2026-07-28]', () {
      // The answer has to be usable, not merely correct: flow analysis promotes
      // the operand inside the branch, so the members of the supertype must be
      // reachable there.
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            Object? x = UnmodifiableSetView({1, 2, 3});
            if (x is Iterable) {
              return [x.length, x.contains(2), x.where((e) => e > 1).length];
            }
            return null;
          }
        ''',
      ) as List;
      expect(result, orderedEquals([3, true, 2]));
    });

    test('F-SCB7-11: `on` clauses match a bridged collection supertype '
        '[2026-07-28]', () {
      // Catch-clause type matching is a *separate* implementation from
      // `visitIsExpression` — it has its own type switch and its own bridged
      // branch — so the two have to be checked independently. Before this fix
      // `on Iterable` missed a thrown bridged set that `x is Iterable` matched.
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          String tryCatch(Object thrown) {
            try {
              throw thrown;
            } on Iterable catch (e) {
              return 'iterable';
            } on Map catch (e) {
              return 'map';
            } catch (e) {
              return 'other';
            }
          }
          main() => [
            tryCatch(UnmodifiableSetView({1})),
            tryCatch(UnmodifiableListView([1])),
            tryCatch(HashMap<String, int>()),
            tryCatch(42),
          ];
        ''',
      ) as List;
      expect(result, orderedEquals(['iterable', 'iterable', 'map', 'other']));
    });
  });
}
