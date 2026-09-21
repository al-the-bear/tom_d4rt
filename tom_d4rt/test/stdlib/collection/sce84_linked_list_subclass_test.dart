// `class E extends LinkedListEntry<E>` — the only way the SDK type is usable.
//
//     import 'dart:collection';
//     class E extends LinkedListEntry<E> { final int v; E(this.v); }
//     main() { final l = LinkedList<E>(); l.add(E(1)); return l.length; }
//
// reported `Error during implicit bridged super constructor: Constructor
// LinkedListEntry(value) expects one positional argument.` — the script failed
// before any member of its own class was reached. `LinkedList` has no other
// entry point: the SDK declares `abstract base mixin class LinkedListEntry<E
// extends LinkedListEntry<E>>`, so subclassing is the API.
//
// WHY THE MEMBER AUDIT COULD NOT SEE IT. `LinkedListEntry`'s adapter map was
// complete and the class reported zero confirmed gaps. The divergence was in
// CONSTRUCTION, not membership: the bridge wrapped d4rt's own
// `BridgedLinkedListEntry`, whose constructor took the entry's value, so the
// implicit `super()` a subclass makes could never match. SCD46 predicted this
// shape and found it by trying to construct one.
//
// SO EVERY CASE HERE CONSTRUCTS. A case calling `insertAfter` on an entry the
// bridge handed out passes against the broken bridge and proves nothing — that
// is exactly how the class came to look complete.
//
// TWO NON-SDK MEMBERS WENT WITH THE FIX, and they are why the old cases in
// `linked_list_test.dart` had to be rewritten rather than kept: the
// `LinkedListEntry(value)` constructor and the `value` getter. Neither is in
// the SDK — its entry has `list`, `next`, `previous`, `insertAfter`,
// `insertBefore`, `unlink` and nothing else — so a script using them ran here
// and did not compile as Dart. That is the same judgement F-SCC8-5 makes about
// `removeFirst`, applied to a constructor and a getter.
//
// THE ENTRIES THE LIST HANDS BACK ARE THE SCRIPT'S OWN OBJECTS, which is the
// half that is not about construction. The native list can only hold native
// entries, so `list.first` is the native one; it carries the interpreted
// instance as a [D4InterpretedProxy], and the interpreter's existing unwrap
// path makes `list.first.myField` reach the script's class. F-SCE84-4..7 are
// that half, and they are separate cases because they fail for a different
// reason than the constructor ones.
//
// ABLATED by restoring the value-taking constructor: 11 of 12 go red — every
// case that builds an entry, plus F-SCE84-12, which under the ablation finds
// the dialect accepted again. The survivor is F-SCE84-11, the control: it
// passes a string to `add`, which is refused either way, so it must be
// indifferent to the constructor or it is not a control.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String body) async {
  const path = 'd4rt-mem:/sce84_linked_list_subclass.dart';
  final d4rt = D4rt();
  return await d4rt.execute(
    library: path,
    name: 'main',
    sources: {
      path:
          "import 'dart:collection';\n"
          'class E extends LinkedListEntry<E> {\n'
          '  final int v;\n'
          '  E(this.v);\n'
          '}\n'
          'Object? main() {\n'
          '$body\n'
          '}\n',
    },
  );
}

void main() {
  group('SCE84: a script declares its own LinkedListEntry subclass', () {
    test('F-SCE84-1: the subclass constructs and links [2026-09-21] '
        '(PASS)', () {
      // The reproduction from the todo, verbatim in shape.
      expect(
        _run('final l = LinkedList<E>(); l.add(E(1)); return l.length;'),
        completion(1),
      );
    });

    test('F-SCE84-2: addFirst and addAll take the subclass too '
        '[2026-09-21] (PASS)', () {
      // The two members that are LinkedList's own rather than Iterable's, so
      // they are the two whose argument handling is written here.
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'l.addAll([E(2), E(3)]);\n'
          'l.addFirst(E(1));\n'
          'return l.length;',
        ),
        completion(3),
      );
    });

    test('F-SCE84-3: insertAfter and insertBefore take the subclass '
        '[2026-09-21] (PASS)', () {
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'final a = E(1);\n'
          'final c = E(3);\n'
          'l.addAll([a, c]);\n'
          'a.insertAfter(E(2));\n'
          'c.insertBefore(E(9));\n'
          'return l.length;',
        ),
        completion(4),
      );
    });

    test('F-SCE84-4: the list hands back the script\'s own object '
        '[2026-09-21] (PASS)', () {
      // `first` comes from `Iterable`'s adapter and returns the NATIVE entry.
      // Reading a field the script declared is what proves the two are tied
      // together rather than merely both existing.
      expect(
        _run('final l = LinkedList<E>(); l.add(E(7)); return l.first.v;'),
        completion(7),
      );
    });

    test('F-SCE84-5: iteration and map see the script\'s objects '
        '[2026-09-21] (PASS)', () {
      // `map` matters more than `for-in` here: it calls the NATIVE iterable,
      // so a fix that only mapped the bridged `iterator` would pass the loop
      // and fail this.
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'l.addAll([E(1), E(2)]);\n'
          'final out = [];\n'
          'for (final e in l) { out.add(e.v); }\n'
          'return out.join(",") + "|" + l.map((e) => e.v).join(",");',
        ),
        completion('1,2|1,2'),
      );
    });

    test('F-SCE84-6: next and previous walk to the script\'s objects '
        '[2026-09-21] (PASS)', () {
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'l.addAll([E(1), E(2)]);\n'
          'return l.first.next.v + l.last.previous.v;',
        ),
        completion(3),
      );
    });

    test('F-SCE84-7: an entry the script added is identical to the one it '
        'gets back [2026-09-21] (PASS)', () {
      // The two carriers of one object: the script holds its instance, the
      // list holds the native entry behind it. `identical` has to see through
      // that or a script cannot recognise its own entry.
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'final a = E(3);\n'
          'l.add(a);\n'
          'return identical(l.first, a) && (l.first == a) && l.contains(a);',
        ),
        completion(isTrue),
      );
    });

    test('F-SCE84-8: remove and unlink take the script\'s object '
        '[2026-09-21] (PASS)', () {
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'final a = E(1);\n'
          'final b = E(2);\n'
          'l.addAll([a, b]);\n'
          'l.remove(a);\n'
          'b.unlink();\n'
          'return l.length;',
        ),
        completion(0),
      );
    });

    test('F-SCE84-9: an unlinked entry can be added again [2026-09-21] '
        '(PASS)', () {
      // The native entry outlives the unlink, so this asks that the tie to the
      // script's object is not consumed by one membership.
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'final a = E(5);\n'
          'l.add(a);\n'
          'a.unlink();\n'
          'l.add(a);\n'
          'return l.first.v;',
        ),
        completion(5),
      );
    });

    test('F-SCE84-10: list reads back the list the entry is in '
        '[2026-09-21] (PASS)', () {
      expect(
        _run(
          'final l = LinkedList<E>();\n'
          'final a = E(1);\n'
          'l.add(a);\n'
          'return identical(a.list, l) && a.list.length == 1;',
        ),
        completion(isTrue),
      );
    });

    test('F-SCE84-11: add still refuses something that is not an entry '
        '[2026-09-21] (PASS)', () {
      // Real Dart rejects this statically, so the interpreter rejects it at
      // run time — and the widened argument handling must not have widened
      // into accepting anything.
      expect(
        _run('final l = LinkedList<E>(); l.add("not an entry"); return null;'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains('LinkedList.add'),
          ),
        ),
      );
    });

    test('F-SCE84-12: the removed dialect is refused, and says what to write '
        'instead [2026-09-21] (PASS)', () {
      // `LinkedListEntry(value)` was a constructor the SDK does not have. A
      // script using it ran here and did not compile as Dart — the class of
      // defect no test catches by itself, which is why the absence is pinned
      // rather than left to the diagnostic.
      expect(
        _run('final l = LinkedList(); l.add(LinkedListEntry(1)); return null;'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('takes no arguments'),
              contains('extends LinkedListEntry'),
            ),
          ),
        ),
      );
    });
  });
}
