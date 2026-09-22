// SCE116 — an extension-type instance renders as the thing it wraps.
//
// SCD72 taught `InterpretedInstance.toString()` to dispatch to a script's own
// override and left two siblings in the same file untouched. This file's first
// half is the one that is NOT about overrides at all, which is why it lands on
// its own: `extension type Y(int v) {}` declares no `toString`, so the call
// erases to `Object.toString()` on the value `Y` wraps, and real Dart prints
// `7`. d4rt printed `<instance of Y>` — a description of a wrapper that has no
// runtime existence to describe.
//
// AN EXTENSION TYPE IS ITS REPRESENTATION AT RUN TIME. That is the whole
// reason: the wrapper is a static fiction, so there is nothing for a
// diagnostic string to be about. `<instance of Y>` was not an imprecise
// rendering of the right object, it was a rendering of the wrong one.
//
// THE OVERRIDE HALF IS A SEPARATE DEFECT in the same method, and landed in its
// own commit — F-SCE116-4 onwards. `InterpretedEnumValue.toString()` got the
// DEFAULT right and the override wrong; `InterpretedExtensionTypeInstance`
// got both wrong. Both now go through the function SCD72's body became.
//
// THE MECHANISM IS SHARED, NOT COPIED. SCD72 wrote the render-or-fall-back
// body — find the override, get a visitor, guard re-entry, dispatch, degrade
// on anything recoverable, rethrow the two VM errors — for one type; a third
// and fourth copy would have been three and four places for the next
// correction to land in. It is now `renderInterpretedToString`, and the
// re-entry guard is ONE identity set for all three, because a cycle can run
// through them and three separate guards would each see a first visit.
//
// THE CONTRACT STILL SPLITS BY CALLER, and F-SCE116-7 and -8 are the halves
// SCD72 established: `stringify` (interpolation inside a script) keeps Dart's
// semantics and propagates, `toString()` (what HOST code reaches) degrades.
// Sharing a call between them is exactly how that distinction could be lost,
// so both are asserted for the two new types.
//
// ABLATED 2026-09-22, three ways:
//
//   | Reverted                                    | Fails              |
//   | ------------------------------------------- | ------------------ |
//   | the representation fallback                 | -1, -2             |
//   | the override dispatch in `toString()`       | -4, -5, -6, -7     |
//   | `stringify`'s two new branches              | -8 ALONE           |
//
// -3 passes under all three (an enum's default was already right), and -9 is
// SCD72's own behaviour re-asked, because its mechanism moved out from under
// it into a shared function.
//
// THE THIRD ROW IS THE ONE WORTH READING. Drop `stringify`'s branches and
// everything still renders correctly — interpolation falls through to
// `toString()`, which dispatches. What is lost is the SEMANTICS: a throwing
// override inside a script starts degrading instead of propagating, and F-
// SCE116-8 is the only case that notices. That is precisely the distinction
// sharing a call between the two paths could have erased.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// What a HOST sees when it interpolates what `execute` returned.
///
/// The boundary is the point: inside a script `stringify` has its own path, so
/// a defect here is invisible until a value crosses into native code.
String hostSees(String source) =>
    '${D4rt().execute(source: source, name: 'main')}';

/// What the SCRIPT sees interpolating the same value.
Object? scriptSees(String source) =>
    D4rt().execute(source: source, name: 'main');

void main() {
  group('SCE116: an extension type renders as its representation', () {
    test('F-SCE116-1: no override renders the wrapped value [2026-09-22] '
        '(PASS)', () {
      expect(hostSees('extension type Y(int v) {}\nmain() => Y(7);'), '7');
      // Not just numbers: whatever the representation's own toString gives.
      expect(
        hostSees("extension type Z(String s) {}\nmain() => Z('hi');"),
        'hi',
      );
      expect(
        hostSees('extension type L(List<int> xs) {}\nmain() => L([1, 2]);'),
        '[1, 2]',
      );
    });

    test('F-SCE116-2: the same inside the script [2026-09-22] (PASS)', () {
      // `stringify` has no branch for an extension type, so it falls through
      // to this `toString()` — the two paths agree because one of them is the
      // other.
      expect(
        scriptSees('extension type Y(int v) {}\nmain() => "\${Y(7)}";'),
        '7',
      );
      // Through a native container, which is the third leak SCD72 found for
      // classes: `List.toString()` is native and calls the native toString.
      expect(
        scriptSees('extension type Y(int v) {}\nmain() => "\${[Y(7)]}";'),
        '[7]',
      );
    });

    test('F-SCE116-3 (control): an enum default is unchanged [2026-09-22] '
        '(PASS)', () {
      // `EnumName.valueName` is what Dart prints and what d4rt already
      // printed. It is here because it lives in the same file as the defect.
      expect(hostSees('enum P { a, b }\nmain() => P.a;'), 'P.a');
      expect(scriptSees('enum P { a, b }\nmain() => "\${P.b}";'), 'P.b');
    });
  });

  group('SCE116: the override is dispatched to', () {
    test('F-SCE116-4: an enum override reaches the host [2026-09-22] '
        '(PASS)', () {
      expect(
        hostSees(
          "enum E { a, b; String toString() => 'E<' + name + '>'; }\n"
          'main() => E.a;',
        ),
        'E<a>',
      );
      // And inside the script, through `stringify`'s own branch.
      expect(
        scriptSees(
          "enum E { a, b; String toString() => 'E<' + name + '>'; }\n"
          'main() => "\${E.b}";',
        ),
        'E<b>',
      );
      // Through a native container, which is the leak SCD72 found for classes.
      expect(
        scriptSees(
          "enum E { a, b; String toString() => 'E<' + name + '>'; }\n"
          'main() => "\${[E.a]}";',
        ),
        '[E<a>]',
      );
    });

    test('F-SCE116-5: an enum override may come from a mixin [2026-09-22] '
        '(PASS)', () {
      // `InterpretedEnumValue.get` resolves a member through the enum's mixins,
      // so the toString lookup has to as well — otherwise the two disagree
      // about which members the value has.
      expect(
        hostSees(
          'mixin Loud { String toString() => "LOUD"; }\n'
          'enum E with Loud { a, b }\n'
          'main() => E.a;',
        ),
        'LOUD',
      );
    });

    test('F-SCE116-6: an extension-type override reaches the host '
        '[2026-09-22] (PASS)', () {
      expect(
        hostSees(
          "extension type X(int v) { String toString() => 'X:' + "
          'v.toString(); }\nmain() => X(7);',
        ),
        'X:7',
      );
      expect(
        scriptSees(
          "extension type X(int v) { String toString() => 'X:' + "
          'v.toString(); }\nmain() => "\${X(7)}";',
        ),
        'X:7',
      );
    });

    test('F-SCE116-7: the host path degrades rather than throwing '
        '[2026-09-22] (PASS)', () {
      // SCD72's contract, now shared. A host receiving a value logs it first;
      // a second exception raised while reporting the first is worse than an
      // imperfect string.
      expect(
        hostSees(
          'enum E { a; String toString() => throw "no"; }\n'
          'main() => E.a;',
        ),
        'E.a',
      );
      expect(
        hostSees(
          'extension type X(int v) { String toString() => throw "no"; }'
          '\nmain() => X(7);',
        ),
        '7',
      );
      // A cycle through a NATIVE container terminates — the case the shared
      // re-entry guard earns. `E.values` is a native list holding `E.a`, so
      // rendering it re-enters this value's `toString()`; the guard answers
      // with the fallback for the inner visit rather than recursing.
      //
      // Not a self-call: `toString() => '<' + this.toString() + '>'` recurses
      // through the INTERPRETER, which the guard cannot see and real Dart
      // overflows on too. The guard is for re-entry from native code.
      expect(
        hostSees(
          'enum E { a, b; String toString() => "E:" + '
          'E.values.toString(); }\nmain() => E.a;',
        ),
        'E:[E.a, E:[...]]',
      );
      expect(
        hostSees(
          'extension type X(List v) { String toString() => "X:" + '
          'v.toString(); }\n'
          'main() { var l = []; var x = X(l); l.add(x); return x; }',
        ),
        'X:[[...]]',
      );
    });

    test('F-SCE116-8 (rail): the in-script path still propagates '
        '[2026-09-22] (PASS)', () {
      // The other half of the split. `stringify` keeps Dart's semantics, so a
      // throwing `toString` is a throwing interpolation — it must NOT pick up
      // the host path's degradation just because the two now share a call.
      expect(
        () => scriptSees(
          'enum E { a; String toString() => throw "no"; }\n'
          'main() => "\${E.a}";',
        ),
        throwsA(anything),
      );
      expect(
        () => scriptSees(
          'extension type X(int v) { String toString() => throw "no"; }\n'
          'main() => "\${X(7)}";',
        ),
        throwsA(anything),
      );
    });

    test('F-SCE116-9 (control): a class is unaffected [2026-09-22] (PASS)', () {
      // SCD72's own cases, re-asked because its mechanism moved out of
      // `InterpretedInstance` into a shared function this commit wrote.
      expect(
        hostSees("class C { String toString() => 'C!'; }\nmain() => C();"),
        'C!',
      );
      expect(hostSees('class D {}\nmain() => D();'), '<instance of D>');
      expect(
        hostSees(
          'class T { String toString() => throw "no"; }\nmain() => T();',
        ),
        '<instance of T>',
      );
    });
  });
}
