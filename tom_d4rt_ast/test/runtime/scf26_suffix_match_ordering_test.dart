/// SCF26 — a PRECISE `nativeNames` match in an ENCLOSING frame must beat a
/// FUZZY name-SUFFIX match in a NEARER one.
///
/// The twin of `tom_d4rt_flutter/test/mapped_iterable_resolution_test.dart`,
/// which pins the same property for the name-PREFIX strategy. That fix split
/// `toBridgedClass` into a precise chain walk and a fuzzy one. The suffix match
/// is equally fuzzy — it is anchored on the BRIDGE's name appearing inside the
/// native type's name, not on any declared relationship — and it stayed inside
/// the precise walk, so it alone kept resolving by proximity.
///
/// WHAT IT COST. Under the lazy-bridge substrate the Flutter bridges sit in the
/// child frame and the stdlib bridges in the warm parent. `UnmodifiableSetView`
/// is named outright in the stdlib `Set` bridge's `nativeNames`, yet it
/// resolved to Flutter's `View` WIDGET, because `View` is the longest bridge
/// name that is a suffix of `UnmodifiableSetView` and that frame was reached
/// one sooner. A script passing `const <String>{'shiftLeft'}` to a
/// `Set<String>` parameter was then refused with
///
///     type 'View<String>' is not a subtype of type 'Set<String>' of 'mods'
///
/// — the last of SCE162's four base-corpus regressions, and the one that held
/// the publish.
///
/// WHY THIS LIVES HERE AND NOT IN A TWIN. The Flutter registry is where the
/// defect was found, but both twins resolve the interpreter from pub.dev
/// (DGUC6), so a guard there could not pass until the fix shipped. The property
/// is a property of `Environment`, so the two frames are built directly: a
/// nearer frame holding a bridge whose NAME is a suffix of the native type, an
/// enclosing frame holding a bridge that NAMES the type outright.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/d4rt.dart';

/// Stands for `UnmodifiableSetView<E>` — the native type both bridges could
/// claim.
///
/// GENERIC ON PURPOSE. The suffix strategy only runs for a type whose name
/// carries type arguments, which is the branch the real
/// `UnmodifiableSetView<String>` takes. A non-generic stand-in never reaches it
/// and the controls below would assert nothing.
class UnmodifiableSetView<E> {
  const UnmodifiableSetView();
}

/// A bridge whose NAME is a suffix of the native type's name and which declares
/// no relationship to it. Flutter's `View` widget, in the real registry.
BridgedClass _suffixBridge() =>
    BridgedClass(nativeType: Object, name: 'View', constructors: const {});

/// A bridge that NAMES the native type. The stdlib `Set`, in the real registry.
BridgedClass _preciseBridge() => BridgedClass(
  nativeType: UnmodifiableSetView,
  name: 'Set',
  nativeNames: const ['UnmodifiableSetView'],
  constructors: const {},
);

void main() {
  group('SCF26: precise nativeNames beats a fuzzy suffix in a nearer frame', () {
    test('F-SCF26-AST-1: the enclosing PRECISE match wins over the nearer FUZZY '
        'one [2026-09-23]', () {
      final parent = Environment();
      parent.defineBridge(
        _preciseBridge(),
        sourceUri: 'package:probe/set.dart',
      );
      final child = Environment(enclosing: parent);
      child.defineBridge(_suffixBridge(), sourceUri: 'package:probe/view.dart');

      expect(
        child.toBridgedClass(UnmodifiableSetView<String>).name,
        'Set',
        reason:
            'the declared `nativeNames` entry in the parent must win over the '
            'name-suffix coincidence in the child. Before SCE162 the chain was '
            'walked once per frame with the fuzzy strategy inside the precise '
            'pass, so proximity decided it and this answered `View`',
      );
    });

    test('F-SCF26-AST-2 (control): the hazard is real — the suffix bridge DOES '
        'claim it when nothing more precise exists [2026-09-23]', () {
      // Without this, F-SCF26-1 would pass just as happily against a build
      // where the suffix strategy had been deleted rather than reordered.
      final parent = Environment();
      final child = Environment(enclosing: parent);
      child.defineBridge(_suffixBridge(), sourceUri: 'package:probe/view.dart');

      expect(
        child.toBridgedClass(UnmodifiableSetView<String>).name,
        'View',
        reason:
            'the suffix strategy is REORDERED, not removed: with no bridge '
            'naming the type, the suffix match is still how it resolves',
      );
    });

    test('F-SCF26-AST-3 (control): proximity still decides between two equally '
        'precise matches [2026-09-23]', () {
      // The reordering must not invert the ordinary case, where the nearer
      // frame is also the precise one.
      final parent = Environment();
      parent.defineBridge(_preciseBridge(), sourceUri: 'package:probe/a.dart');
      final child = Environment(enclosing: parent);
      child.defineBridge(
        BridgedClass(
          nativeType: UnmodifiableSetView,
          name: 'NearerSet',
          nativeNames: const ['UnmodifiableSetView'],
          constructors: const {},
        ),
        sourceUri: 'package:probe/b.dart',
      );

      expect(
        child.toBridgedClass(UnmodifiableSetView<String>).name,
        'NearerSet',
      );
    });
  });
}
