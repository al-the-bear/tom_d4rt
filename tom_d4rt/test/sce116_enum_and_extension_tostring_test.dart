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
// THE OVERRIDE HALF IS A SEPARATE DEFECT in the same method and lands
// separately — see F-SCE116-4 onwards below, added with it.
//
// CONTROL, measured by reverting `toString()` to `'<instance of ${name}>'`:
// F-SCE116-1 and -2 fail, -3 passes. -3 is the rail: an enum's DEFAULT was
// already right, and a fix aimed at extension types must not disturb it.

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
}
