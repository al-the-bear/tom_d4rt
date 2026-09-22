// SCE120 — `class E extends LinkedListEntry<E>`, the idiom the SDK documents,
// works end to end.
//
// THE TWO WALLS THE TODO MEASURED ARE GONE, and they were closed by SCD75's own
// follow-through rather than here. Measured at 1.166.0 before anything was
// changed: the implicit `super()` succeeds (the bridged constructor takes no
// arguments now and its error names the real idiom), `add` accepts an
// `InterpretedInstance`, and the list round-trips it — `l.first.v` is the
// script's field, `identical(l.first, e)` is true, `for (final e in l)` binds
// the script's object.
//
// THE MECHANISM IS WORTH KNOWING because the todo warned against getting it
// wrong: unwrapping the instance to its `bridgedSuperObject` before the `is`
// test would make `add` accept it and then hand a DIFFERENT object back, which
// is worse than a refusal. It is not what was done. `_OwnedLinkedListEntry`
// carries the script's object as `owner` and implements `D4InterpretedProxy`,
// `_nativeEntry` ties the two halves when an entry enters a list, and
// `_exposed` maps back on read. The native list holds native entries; the
// script never sees them.
//
// EXCEPT IN ONE PLACE, WHICH IS WHAT THIS COMMIT FIXES. The proxy unwrap is a
// FALLBACK: the interpreter tries the bridge's own members first and only
// reaches `d4rtInstance` when they fail. `myField` fails and unwraps;
// `toString` SUCCEEDED, on the wrapper, so a script that declared
// `String toString() => 'E:' + v.toString()` read back `LinkedListEntry(E:1)`
// — its own rendering wrapped in the name of a class it never wrote. Fixed
// where the substitution is manufactured, in `_OwnedLinkedListEntry.toString`,
// rather than by reordering the general unwrap: the proxy exists to speak for
// the instance, so it answers with the instance's own `toString`.
//
// TWO GAPS ARE PINNED RATHER THAN FIXED, both wider than this file:
//
//   * `l.first.runtimeType` is `_OwnedLinkedListEntry`, not `E` (F-SCE120-5).
//     What a proxy should report as its runtime type is a question about every
//     `D4InterpretedProxy` — Flutter's `State`, `CustomPainter` — not about
//     `LinkedList`, and answering it here would answer it for all of them.
//   * an interpreted class that declares NO `toString` cannot have one called
//     at all: `class C {} … C().toString()` raises `D4rtNoSuchMethodError`
//     while `'$c'` renders `<instance of C>`. That is the universal-member
//     path for every class and is tracked separately.
//
// WHY NO AUDIT SEES ANY OF THIS, which the todo asks to carry beyond the bug:
// both member audits classify members of an instance the BRIDGE constructed, so
// the subclass route is never probed and every `LinkedList` member reads as
// reachable — true, and silent about whether a script's own subclass can
// participate. This file is the coverage those audits structurally cannot give.
//
// ABLATED 2026-09-22 by restoring `'LinkedListEntry(${owner ?? 'unowned'})'`:
// F-SCE120-4 fails alone. -1, -2, -3 and -5 pass under both, which is the
// point — they are the idiom the todo is named for, and they were already
// working before this commit touched anything.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// The entry class every Dart tutorial writes, plus a `toString` so the
/// round-trip can be seen rather than inferred.
const _entry = '''
  import 'dart:collection';
  class E extends LinkedListEntry<E> {
    final int v;
    E(this.v);
    String toString() => 'E:' + v.toString();
  }
''';

Object? run(String body) =>
    D4rt().execute(source: '$_entry\nmain() { $body }', name: 'main');

void main() {
  group('SCE120: a script subclass of LinkedListEntry', () {
    test('F-SCE120-1: the documented idiom constructs and adds '
        '[2026-09-22] (PASS)', () {
      // Wall one was the implicit `super()`: the bridge modelled the entry as
      // a value wrapper, so its constructor demanded an argument the SDK's
      // does not take. Wall two was `add`, which tested for the native type.
      expect(
        run('final l = LinkedList<E>(); l.add(E(1)); return l.length;'),
        1,
      );
      expect(
        run(
          'final l = LinkedList<E>(); l.addAll([E(1), E(2)]); '
          'return l.length;',
        ),
        2,
      );
      expect(
        run('final l = LinkedList<E>(); l.addFirst(E(9)); return l.first.v;'),
        9,
      );
    });

    test('F-SCE120-2: the list hands back the script\'s own object '
        '[2026-09-22] (PASS)', () {
      // The property the todo insists on: accepting the object and returning
      // a different one is worse than refusing it, because the refusal is a
      // message and the substitution is a wrong answer.
      expect(
        run(
          'final l = LinkedList<E>(); var e = E(1); l.add(e); '
          'return identical(l.first, e);',
        ),
        isTrue,
      );
      expect(
        run(
          'final l = LinkedList<E>(); var e = E(1); l.add(e); '
          'return l.first == e;',
        ),
        isTrue,
      );
      // A field the SCRIPT declared, which the native entry does not have.
      expect(
        run('final l = LinkedList<E>(); l.add(E(7)); return l.first.v;'),
        7,
      );
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(1)); l.add(E(2)); '
          'return l.last.v;',
        ),
        2,
      );
    });

    test('F-SCE120-3: iteration and entry links reach the script class '
        '[2026-09-22] (PASS)', () {
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(1)); l.add(E(2)); '
          'var s = 0; for (final e in l) { s = s + e.v; } return s;',
        ),
        3,
      );
      // `next` is the SDK's own entry navigation, so it goes out through the
      // same read-back path.
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(1)); l.add(E(2)); '
          'return l.first.next.v;',
        ),
        2,
      );
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(3)); '
          'return l.map((e) => e.v).toList();',
        ),
        [3],
      );
      expect(
        run('final l = LinkedList<E>(); l.add(E(5)); return l.toList()[0].v;'),
        5,
      );
      // Removal from both sides, which is where an untied entry would show.
      expect(
        run(
          'final l = LinkedList<E>(); var e = E(1); l.add(e); l.remove(e); '
          'return l.length;',
        ),
        0,
      );
      expect(
        run(
          'final l = LinkedList<E>(); var e = E(1); l.add(e); e.unlink(); '
          'return l.length;',
        ),
        0,
      );
      expect(
        run(
          'final l = LinkedList<E>(); var e = E(1); l.add(e); '
          'return l.contains(e);',
        ),
        isTrue,
      );
    });

    test('F-SCE120-4: a read-back entry renders the script\'s toString '
        '[2026-09-22] (PASS)', () {
      // The leak this commit closes. `e.toString()` was already the script's;
      // `l.first.toString()` was the wrapper's, so the same object printed two
      // different ways depending on whether it had been through the list.
      expect(run('var e = E(1); return e.toString();'), 'E:1');
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(1)); '
          'return l.first.toString();',
        ),
        'E:1',
      );
      // Through interpolation, and through a native container, which are the
      // two routes SCD72 found for classes.
      expect(
        run('final l = LinkedList<E>(); l.add(E(1)); return "\${l.first}";'),
        'E:1',
      );
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(1)); l.add(E(2)); '
          'return l.toList().toString();',
        ),
        '[E:1, E:2]',
      );
    });

    test('F-SCE120-5: the gaps that stay, stated [2026-09-22] (PASS)', () {
      // Pinned so the next reader knows they were measured and left, not
      // missed. Both are questions about every D4InterpretedProxy or about
      // every interpreted class, and answering either here would answer it
      // everywhere.
      expect(
        run(
          'final l = LinkedList<E>(); l.add(E(1)); '
          'return l.first.runtimeType.toString();',
        ),
        '_OwnedLinkedListEntry',
        reason: 'a proxy reports the proxy type; `e.runtimeType` is `E`',
      );
      expect(run('var e = E(1); return e.runtimeType.toString();'), 'E');
      // An entry that never entered a list has no owner to speak for.
      expect(
        () => run('final l = LinkedList<E>(); return l.first;'),
        throwsA(anything),
        reason: 'an empty list has no first entry, proxy or otherwise',
      );
    });
  });
}
