// SCE77: the audit's error vocabulary is tied to the interpreter's throw sites.
//
// The gap audit decides whether a member exists by classifying the error the
// interpreter produced, and it did that by MATCHING THE TEXT against a
// hand-written list of wordings. Nothing connected that list to the places the
// interpreter throws from, so a wording the list did not know made a whole
// column silently unfalsifiable — the probe ran, the error arrived, and it was
// scored as *reachable*.
//
// THAT HAPPENED TWICE IN CONSECUTIVE TODOS, in two different columns:
//
//   SCD36  `Cannot access property 'x' on target of type _Foo`
//          the return-type pass reported 0 of 411 while blind to every gap it
//          existed to find
//   SCD39  `Unsupported operator (STAR) for types String and String`
//          the operator column could only ever answer "reachable" for
//          `String *`; with `*` removed from the interpreter it still reported
//          0 confirmed gaps
//
// Both were found by planting a defect. Neither would have been found by any
// passing test, and `core/map.dart` had even documented SCD36's wording against
// `_ConstMap` for a release — nothing connected the comment to the classifier.
//
// THE TIE IS STRUCTURAL NOW. `RuntimeD4rtException.resolutionFailure` marks the
// throw sites that mean A NAME DID NOT RESOLVE, the probe isolate classifies on
// that flag rather than on the message, and a reworded message therefore cannot
// silently leave the set.
//
// WHY THE GUARD IS NOT "EVERY THROW SITE MUST BE RECOGNISED". Some of these
// wordings genuinely do not mean a name was absent. `Unsupported operator (...)`
// fires both when an operator does not resolve and when the operand types are
// simply wrong; SCD39 could only classify on it in the OPERATOR path, where the
// operand is derived from the SDK signature and is therefore known to
// type-check. Tagging it here would make the tool report gaps it invented,
// which is the one direction it must never move in. So the rule is the
// `unverified-with-a-reason` shape the member columns already use, applied to
// the instrument's own vocabulary: every resolution-SHAPED throw site is either
// tagged, or registered with the reason tagging it would be wrong.

import 'dart:io';

import 'package:test/test.dart';

import '../tool/stdlib_member_diff.dart';

void main() {
  group('SCE77: resolution-failure throw sites are tagged or registered', () {
    test('F-SCE77-1: no resolution-shaped throw site is unaccounted for '
        '[2026-09-21] (PASS)', () {
      expect(
        unrecognisedResolutionThrowSites(Directory.current.path),
        isEmpty,
        reason:
            'A throw site reads like a resolution failure and is neither '
            'tagged with `RuntimeD4rtException.resolutionFailure` nor recorded '
            'in `kUntaggedResolutionShapedSites`. Until it is one or the other, '
            'every audit column that classifies a failure is unfalsifiable — '
            'the audit itself refuses to publish those figures, so this is not '
            'only a red test.',
      );
    });

    test('F-SCE77-2 (control): the scanner can still find one [2026-09-21] '
        '(PASS)', () {
      // The case above asserts an EMPTY set, which is exactly the shape that
      // passes when the instrument is broken — a scanner that reads no files,
      // or a regex that matches nothing, gives the same green. So the scanner
      // is pointed at a tree it must report on.
      final dir = Directory.systemTemp.createTempSync('sce77_control_');
      addTearDown(() => dir.deleteSync(recursive: true));
      Directory('${dir.path}/lib/src').createSync(recursive: true);
      File('${dir.path}/lib/src/interpreter_visitor.dart').writeAsStringSync('''
void f() {
  throw RuntimeD4rtException("Widget has no instance method named 'x'.");
}
''');
      expect(
        unrecognisedResolutionThrowSites(dir.path),
        hasLength(1),
        reason:
            'an untagged, unregistered resolution-shaped throw must be found; '
            'if this is empty the scanner is measuring nothing and F-SCE77-1 '
            'means nothing either',
      );
    });

    test('F-SCE77-3 (control): a registered wording is NOT reported '
        '[2026-09-21] (PASS)', () {
      // The other half. If the register were ignored, F-SCE77-1 would be
      // unsatisfiable rather than satisfied, and somebody would "fix" it by
      // tagging the ambiguous sites — which is the failure this whole file
      // exists to prevent.
      final dir = Directory.systemTemp.createTempSync('sce77_control2_');
      addTearDown(() => dir.deleteSync(recursive: true));
      Directory('${dir.path}/lib/src').createSync(recursive: true);
      File('${dir.path}/lib/src/interpreter_visitor.dart').writeAsStringSync('''
void f() {
  throw RuntimeD4rtException("Unsupported operator (STAR) for types A and B");
}
''');
      expect(unrecognisedResolutionThrowSites(dir.path), isEmpty);
    });

    test('F-SCE77-4: every register entry carries a reason [2026-09-21] '
        '(PASS)', () {
      // An entry saying only "not a resolution failure" is a name nobody can
      // re-judge. The reason is what lets the next reader decide whether it is
      // still true after the wording moves.
      final thin = kUntaggedResolutionShapedSites.entries
          .where((e) => e.value.trim().length < 60)
          .map((e) => e.key)
          .toList();
      expect(thin, isEmpty, reason: 'entries with no usable reason: $thin');
    });
  });
}
