// SCD31: a bridge must not invent an error contract the SDK does not have.
//
// The instance that prompted the sweep: `SplayTreeMap.firstKey()` on an empty
// map hand-threw `RuntimeD4rtException("Map is empty")` where the SDK returns
// `null` — both members are declared `K?`. It was found by accident, while
// someone read that file for another reason, and nothing would otherwise have
// found it: the member is registered, it resolves, the member diff counts the
// class complete, and `I-COLL-78` ACTIVELY ASSERTED THE WRONG BEHAVIOUR.
//
// WHY THE TOOLING IS BLIND TO THIS. `stdlib_member_diff.dart` asks "is this
// member reachable?" and stops. Reachability is orthogonal to behaviour, and
// this whole class lives in the gap. `extraBridged` does not help either: the
// member genuinely exists on the SDK type, so it is not extra.
//
// This file is the cheap standing version of the nullability check the sweep
// proposed as its stage 2. Every case drives a member whose SDK return type is
// NULLABLE, in the state that should yield null, and asserts it does not throw.
// It would have caught the splay case mechanically.
//
// IT IS NOT THE FULL STAGE 2, which would enumerate nullable returns from
// `dart:mirrors` rather than listing them. That was measured and declined —
// see the todo's outcome — because the grep sweep and this probe agreed on
// zero remaining instances, and a generated oracle is worth building when
// there is drift to catch, not before. If a future instance IS found by
// accident again, that is the signal to build it.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  dynamic run(String body) =>
      D4rt().execute(source: "import 'dart:collection'; main() { $body }");

  // Member -> the expression that must yield null rather than throw.
  const nullable = <String, String>{
    'SplayTreeMap.firstKey': 'var m = SplayTreeMap(); return m.firstKey();',
    'SplayTreeMap.lastKey': 'var m = SplayTreeMap(); return m.lastKey();',
    'SplayTreeMap.firstKeyAfter':
        'var m = SplayTreeMap(); return m.firstKeyAfter(1);',
    'SplayTreeMap.lastKeyBefore':
        'var m = SplayTreeMap(); return m.lastKeyBefore(1);',
    'Map.[]': "var m = {}; return m['nope'];",
    'HashMap.[]': "var m = HashMap(); return m['nope'];",
    'LinkedHashMap.[]': "var m = LinkedHashMap(); return m['nope'];",
    'SplayTreeMap.[]': "var m = SplayTreeMap(); return m['nope'];",
    'Map.remove': "var m = {}; return m.remove('nope');",
    'HashSet.lookup': "var s = HashSet(); return s.lookup('nope');",
    'LinkedHashSet.lookup': "var s = LinkedHashSet(); return s.lookup('nope');",
    'SplayTreeSet.lookup': "var s = SplayTreeSet(); return s.lookup('nope');",
    'Iterable.firstOrNull': 'var l = []; return l.firstOrNull;',
    'Iterable.lastOrNull': 'var l = []; return l.lastOrNull;',
    'Iterable.singleOrNull': 'var l = []; return l.singleOrNull;',
    'Iterable.elementAtOrNull': 'var l = []; return l.elementAtOrNull(3);',
  };

  group('SCD31: a nullable return yields null, it does not throw', () {
    nullable.forEach((member, body) {
      test('F-SCD31-1-$member: returns null on the empty case [2026-09-12] '
          '(PASS)', () {
        expect(
          run(body),
          isNull,
          reason:
              'The SDK declares this member nullable and returns null here. A '
              'bridge that throws instead changes the VALUE contract, so every '
              'script reading the result breaks — and no reachability check '
              'can see it, because the member is present and resolves.',
        );
      });
    });
  });

  group('SCD31: the sweep pinned its one survivor', () {
    test('F-SCD31-2: unlink on an unlinked entry still refuses [2026-09-12] '
        '(PASS)', () {
      // The guard the sweep examined and KEPT. Dart has no contract here to
      // contradict — `LinkedListEntry.unlink()` on an unlinked entry throws an
      // internal `_TypeError: Null check operator used on a null value` — so a
      // legible error is the better answer and deleting it would gain nothing.
      // Pinned so a later sweep matching on shape alone does not remove it.
      expect(
        () => run('''
          var l = LinkedList();
          var e = LinkedListEntry();
          e.unlink();
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}
