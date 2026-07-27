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
    CollectionStdlib.register(env);
  });

  group('SC2: LinkedHashSet collection bridge', () {
    test('F-SC2-AST-1: is registered under the name LinkedHashSet [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('LinkedHashSet');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, LinkedHashSet);
      expect(bridge.typeParameterCount, 1);
      expect(bridge.isAssignable?.call(LinkedHashSet<dynamic>()), isTrue);
      expect(bridge.isAssignable?.call(<int>[]), isFalse);
    });

    test('F-SC2-AST-2: exposes the default, from and of constructors [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('LinkedHashSet')!;
      expect(bridge.constructors.keys, containsAll(<String>['', 'from', 'of']));
    });

    test('F-SC2-AST-3: exposes the Set method surface [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('LinkedHashSet')!;
      expect(
        bridge.methods.keys,
        containsAll(<String>[
          'add', 'addAll', 'clear', 'contains', 'containsAll', 'forEach',
          'remove', 'removeAll', 'retainAll', 'removeWhere', 'retainWhere',
          'lookup', 'map', 'where', 'fold', 'join', 'toList', 'toSet',
        ]),
      );
    });

    test('F-SC2-AST-4: the getters read through in insertion order [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('LinkedHashSet')!;
      final set = LinkedHashSet<dynamic>.of(['gamma', 'alpha', 'beta']);
      expect(bridge.getters['length']!(null, set), 3);
      expect(bridge.getters['isEmpty']!(null, set), isFalse);
      expect(bridge.getters['isNotEmpty']!(null, set), isTrue);
      expect(bridge.getters['first']!(null, set), 'gamma');
      expect(bridge.getters['last']!(null, set), 'beta');
    });
  });

  group('SC2: SplayTreeSet collection bridge', () {
    test('F-SC2-AST-5: is registered under the name SplayTreeSet [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('SplayTreeSet');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, SplayTreeSet);
      expect(bridge.typeParameterCount, 1);
      expect(bridge.isAssignable?.call(SplayTreeSet<dynamic>()), isTrue);
      expect(bridge.isAssignable?.call(LinkedHashSet<dynamic>()), isFalse);
    });

    test('F-SC2-AST-6: exposes the default, from and of constructors [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('SplayTreeSet')!;
      expect(bridge.constructors.keys, containsAll(<String>['', 'from', 'of']));
    });

    test('F-SC2-AST-7: exposes the same method surface as LinkedHashSet [2026-07-27]',
        () {
      final linked = env.findBridgedClassByName('LinkedHashSet')!;
      final splay = env.findBridgedClassByName('SplayTreeSet')!;
      expect(splay.methods.keys.toSet(), linked.methods.keys.toSet());
      expect(splay.getters.keys.toSet(), linked.getters.keys.toSet());
    });

    test('F-SC2-AST-8: the getters read through in sorted order [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('SplayTreeSet')!;
      final set = SplayTreeSet<dynamic>.of([30, 10, 20]);
      expect(bridge.getters['length']!(null, set), 3);
      expect(bridge.getters['first']!(null, set), 10);
      expect(bridge.getters['last']!(null, set), 30);
    });

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
}
