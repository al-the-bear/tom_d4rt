// The `LinkedHashSet<dynamic>()` calls below are deliberate: a `{}` literal has
// the same runtime type, but naming the constructor is the whole point of a
// test that asserts which bridge claims which native set type.
// ignore_for_file: prefer_collection_literals

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CollectionStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:collection` is registered lazily by
// `ast_module_loader.dart` when a script imports it. Driving that path from a
// unit test would mean building a parsed AST module, so we reach for the
// same-package registrar directly instead of widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
// `Set` and `Iterable` are `dart:core` bridges, not `dart:collection` ones, so
// the top of the set hierarchy only exists once `CoreStdlib` has run too. A
// script gets both because it imports both; a registration-level test has to
// say so — and it matters here because SCC51 moved `first`/`last` up onto
// those very bridges.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

import '../bridge_reachability.dart';

/// SC2 mirror coverage for `tom_d4rt_ast`.
///
/// These are registration-level rather than script-level assertions: the
/// script-level equivalents live in `tom_d4rt/test/stdlib/collection/`, and
/// `tom_d4rt_exec` (the runner that could execute a script against *this*
/// tree) resolves `tom_d4rt_ast` from pub.dev rather than by path, so it cannot
/// see unpublished local edits. What we can pin here is that the two bridges
/// are registered, expose the surface the script tests exercise, and read
/// through to the native collection — instance getters take a nullable visitor,
/// so they can be driven without a live interpreter.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    CollectionStdlib.register(env);
  });

  group('SC2: LinkedHashSet collection bridge', () {
    test(
      'F-SC2-AST-1: is registered under the name LinkedHashSet [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('LinkedHashSet');
        expect(bridge, isNotNull);
        expect(bridge!.nativeType, LinkedHashSet);
        expect(bridge.typeParameterCount, 1);
        expect(bridge.isAssignable?.call(LinkedHashSet<dynamic>()), isTrue);
        expect(bridge.isAssignable?.call(<int>[]), isFalse);
      },
    );

    test(
      'F-SC2-AST-2: exposes the default, from and of constructors [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('LinkedHashSet')!;
        expect(
          bridge.constructors.keys,
          containsAll(<String>['', 'from', 'of']),
        );
      },
    );

    test('F-SC2-AST-3: exposes the Set method surface [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('LinkedHashSet')!;
      expect(
        bridge.methods.keys,
        containsAll(<String>[
          'add',
          'addAll',
          'clear',
          'contains',
          'containsAll',
          'forEach',
          'remove',
          'removeAll',
          'retainAll',
          'removeWhere',
          'retainWhere',
          'lookup',
          'map',
          'where',
          'fold',
          'join',
          'toList',
          'toSet',
        ]),
      );
    });

    test(
      'F-SC2-AST-4: the getters read through in insertion order [2026-07-27]',
      () {
        // Resolved by reachability rather than off the LinkedHashSet bridge
        // directly: SCC51 deleted the leaf's `first`/`last` copies, which
        // shadowed — and diverged from — `Set`'s. Which bridge in the chain
        // carries a member is not a contract; that a script can read it is.
        final set = LinkedHashSet<dynamic>.of(['gamma', 'alpha', 'beta']);
        Object? read(String m) => readReachable(env, 'LinkedHashSet', set, m);
        expect(read('length'), 3);
        expect(read('isEmpty'), isFalse);
        expect(read('isNotEmpty'), isTrue);
        expect(read('first'), 'gamma');
        expect(read('last'), 'beta');
      },
    );
  });

  group('SC2: SplayTreeSet collection bridge', () {
    test(
      'F-SC2-AST-5: is registered under the name SplayTreeSet [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('SplayTreeSet');
        expect(bridge, isNotNull);
        expect(bridge!.nativeType, SplayTreeSet);
        expect(bridge.typeParameterCount, 1);
        expect(bridge.isAssignable?.call(SplayTreeSet<dynamic>()), isTrue);
        expect(bridge.isAssignable?.call(LinkedHashSet<dynamic>()), isFalse);
      },
    );

    test(
      'F-SC2-AST-6: exposes the default, from and of constructors [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('SplayTreeSet')!;
        expect(
          bridge.constructors.keys,
          containsAll(<String>['', 'from', 'of']),
        );
      },
    );

    test(
      'F-SC2-AST-7: exposes the same method surface as LinkedHashSet [2026-07-27]',
      () {
        final linked = env.findBridgedClassByName('LinkedHashSet')!;
        final splay = env.findBridgedClassByName('SplayTreeSet')!;
        expect(splay.methods.keys.toSet(), linked.methods.keys.toSet());
        expect(splay.getters.keys.toSet(), linked.getters.keys.toSet());
      },
    );

    test(
      'F-SC2-AST-8: the getters read through in sorted order [2026-07-27]',
      () {
        // Reachability-resolved for the same reason as F-SC2-AST-4, and it
        // carries extra weight here: `SplayTreeSet` sorts, so reading 10/30
        // out of an insertion order of 30/10/20 proves the inherited `Set`
        // adapter still dispatches to THIS native object rather than a copy.
        final set = SplayTreeSet<dynamic>.of([30, 10, 20]);
        Object? read(String m) => readReachable(env, 'SplayTreeSet', set, m);
        expect(read('length'), 3);
        expect(read('first'), 10);
        expect(read('last'), 30);
      },
    );

    test('F-SC2-AST-9: the two sets stay distinct bridges [2026-07-27]', () {
      // A SplayTreeSet must not be captured by the LinkedHashSet bridge (and
      // vice versa) — otherwise dispatch would silently pick the wrong
      // ordering contract for a script that typed against one of them.
      final linked = env.findBridgedClassByName('LinkedHashSet')!;
      final splay = env.findBridgedClassByName('SplayTreeSet')!;
      expect(linked.isAssignable!(SplayTreeSet<dynamic>()), isFalse);
      expect(splay.isAssignable!(LinkedHashSet<dynamic>()), isFalse);
    });
  });

  // SCC50 mirror coverage. The script-level twin is the `SCC50` group in
  // `tom_d4rt/test/stdlib/collection/splay_tree_set_test.dart`.
  //
  // THE FINDING THIS GROUP RECORDS. SCC50 was filed as "bridge
  // `SplayTreeSet.firstAfter` / `lastBefore`". Those members do not exist:
  // measured against the Dart 3.12.2 SDK, `firstKeyAfter` / `lastKeyBefore` are
  // declared on `SplayTreeMap` alone, and every public member of
  // `SplayTreeSet` is also declared on `Set`. `SplayTreeSet` therefore has no
  // leaf-only member at all — which is exactly why F-SC2-AST-7 above can assert
  // that its bridge surface EQUALS `LinkedHashSet`'s and be right to. That
  // equality reads like a shortfall and is not one.
  //
  // What the leaf owns is behaviour, not surface: `union` / `intersection` /
  // `difference` / `toSet` are overridden to return a sorted set. The bridge
  // routes the first three through `setAlgebraMethods`, whose `coerce` is
  // `(t) => t as Set` — an implementation that copied into a plain `Set` first
  // would lose the ordering while leaving every surface assertion in this file
  // green, so the adapters are driven for their RESULT here.
  group('SCC50: the leaf behaviour behind the shared surface', () {
    late InterpreterVisitor visitor;

    setUp(() {
      // Method adapters take a non-nullable visitor (only getters accept
      // `null`), and none of the set-algebra adapters resolves a name or loads
      // a module, so an empty loader is enough.
      visitor = InterpreterVisitor(
        globalEnvironment: env,
        moduleContext: AstModuleLoader(
          modules: const {},
          globalEnvironment: env,
          runner: D4rtRunner(),
        ),
      );
    });

    /// Invokes [method] on the `SplayTreeSet` bridge with [args].
    Object? callSplay(String method, List<Object?> args) =>
        env.findBridgedClassByName('SplayTreeSet')!.methods[method]!(
          visitor,
          SplayTreeSet<dynamic>.of([5, 1, 9, 3]),
          args,
          {},
          [],
        );

    test('F-SCC50-AST-1: union() returns a sorted set [2026-09-06]', () {
      // The source set is built from [5, 1, 9, 3] and the argument is
      // {7, 0} — both out of order, so a result echoing either input's order
      // is distinguishable from a sorted one.
      expect(
        (callSplay('union', [
                  <dynamic>{7, 0},
                ])
                as Set)
            .toList(),
        orderedEquals([0, 1, 3, 5, 7, 9]),
      );
    });

    test('F-SCC50-AST-2: intersection() and difference() return sorted sets '
        '[2026-09-06]', () {
      expect(
        (callSplay('intersection', [
                  <dynamic>{9, 1, 4},
                ])
                as Set)
            .toList(),
        orderedEquals([1, 9]),
        reason:
            'the argument is written {9, 1, 4}, so an implementation '
            'iterating it and collecting hits would give [9, 1]',
      );
      expect(
        (callSplay('difference', [
                  <dynamic>{1, 9},
                ])
                as Set)
            .toList(),
        orderedEquals([3, 5]),
      );
    });

    test(
      'F-SCC50-AST-3: toSet() returns a sorted, independent copy [2026-09-06]',
      () {
        final bridge = env.findBridgedClassByName('SplayTreeSet')!;
        final original = SplayTreeSet<dynamic>.of([5, 1, 9, 3]);
        final copy =
            bridge.methods['toSet']!(visitor, original, [], {}, []) as Set;
        original.add(2);
        expect(copy.toList(), orderedEquals([1, 3, 5, 9]));
        expect(
          original.toList(),
          orderedEquals([1, 2, 3, 5, 9]),
          reason:
              'two claims: the copy is sorted, and it is a copy — an adapter '
              'returning `target` itself would satisfy sortedness alone',
        );
      },
    );

    test('F-SCC50-AST-4: the LinkedHashSet twin is insertion-ordered '
        '[2026-09-06]', () {
      // The non-vacuity guard. Both bridges share `setAlgebraMethods`, so if
      // this one also came back sorted the three tests above would be
      // measuring the SDK rather than which native object did the work.
      final result =
          env.findBridgedClassByName('LinkedHashSet')!.methods['union']!(
                visitor,
                LinkedHashSet<dynamic>.of([5, 1, 9, 3]),
                [
                  <dynamic>{7, 0},
                ],
                {},
                [],
              )
              as Set;
      expect(result.toList(), orderedEquals([5, 1, 9, 3, 7, 0]));
    });

    test('F-SCC50-AST-5: neither firstAfter nor lastBefore is bridged '
        '[2026-09-06]', () {
      // Asserted rather than left as prose, because the absence is the
      // conclusion of this todo and a future reader will otherwise re-file
      // it. Adding either adapter would invent API that native Dart does not
      // have, and would break F-SC2-AST-7's surface equality besides.
      final splay = env.findBridgedClassByName('SplayTreeSet')!;
      expect(splay.methods.keys, isNot(contains('firstAfter')));
      expect(splay.methods.keys, isNot(contains('lastBefore')));
    });

    test('F-SCC50-AST-6: the map twin DOES carry the ordered surface '
        '[2026-09-06]', () {
      // The contrast that makes F-SCC50-AST-5 a statement about the SDK
      // rather than about our coverage: the members exist on the map, they
      // are bridged there, and they have no set-side counterpart to bridge.
      expect(
        env.findBridgedClassByName('SplayTreeMap')!.methods.keys,
        containsAll(<String>[
          'firstKey',
          'lastKey',
          'firstKeyAfter',
          'lastKeyBefore',
        ]),
      );
    });
  });
}
