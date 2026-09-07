import 'dart:io';

import 'package:test/test.dart';

import '../../tool/check_mirrored_sources.dart';

/// SCC92 — the tom_d4rt ↔ tom_d4rt_ast mirror rule, enforced by a suite.
///
/// The rule is that an interpreter fix lands in BOTH trees. Nothing checked it,
/// so a one-sided fix analyzed clean, passed both suites, and surfaced only
/// when somebody read the two files side by side. It had already happened: the
/// host error boundary in `exceptions.dart` unwrapped
/// `InternalInterpreterD4rtException` in the reference and not here, while THIS
/// tree's doc comment said it did — the prose was mirrored and the code was
/// not. Writing this guard is what found it.
///
/// WHERE THIS LIVES, and its one limitation. The tool and the test are in
/// `tom_d4rt_ast`, matching the Flutter twins' precedent that the AST side owns
/// mirror tooling and the overview's statement that this tree is the
/// authoritative target for new interpreter work. So `dart test` here catches
/// drift authored in EITHER tree — but only when this suite is run. That is the
/// shape SCD153 complains about for the conformance guard, and the mitigation
/// is the same: the quest's workflow runs both suites for any interpreter
/// change.
void main() {
  final haveReference = Directory(kReferenceRoot).existsSync();
  final skipReason = haveReference
      ? null
      : 'needs the sibling checkout at $kReferenceRoot; this package resolves '
            'nothing from it at runtime, so a consumer running these tests '
            'from a pub cache legitimately has no reference tree to compare.';

  group('SCC92: mirrored sources agree', () {
    test('F-SCC92-1: the guard is looking at a real corpus [2026-09-07]', () {
      // Anti-vacuity, and the failure this file is most exposed to: every
      // assertion below is "no differences found", so a stripper that returned
      // nothing, or a walk that found no pairs, would make all of them pass
      // while checking nothing at all.
      final paths = mirroredPaths();
      expect(
        paths.length,
        greaterThan(100),
        reason:
            '156 files sat at mirrored paths on 2026-09-07. Finding almost '
            'none means the layout moved and this file is comparing nothing.',
      );
      final sample = stripToCode(
        File('$kAstRoot/unbridged_reasons.dart').readAsStringSync(),
        ast: true,
      );
      expect(
        sample.length,
        greaterThan(30),
        reason:
            'stripToCode returned almost nothing for a file that is mostly '
            'code, so it is stripping too much and every comparison below is '
            'trivially equal.',
      );
    });

    test('F-SCC92-2: stripToCode removes prose and keeps code [2026-09-07]', () {
      // The stripper is the whole comparison. If it dropped code, drift would
      // pass; if it kept comments, the two trees' deliberately different
      // headers would read as drift and the guard would be switched off.
      const source = '''
// a line comment
/// a doc comment
/* a block
   comment */
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/environment.dart';

const x = 1; // trailing comments are NOT stripped, and need not be
''';
      expect(
        stripToCode(source, ast: true),
        equals([
          "import '@BARREL@';",
          "import '@SRC@environment.dart';",
          'const x = 1; // trailing comments are NOT stripped, and need not be',
        ]),
      );
    });

    test('F-SCC92-3: every mirrored pair agrees, or is baselined with a reason '
        '[2026-09-07]', () {
      final drifted = <String>[];
      for (final rel in mirroredPaths()) {
        if (kDivergentMirrors.containsKey(rel)) continue;
        final diff = diffFor(rel);
        if (diff.isNotEmpty) drifted.add('$rel\n${diff.join('\n')}');
      }
      expect(
        drifted,
        isEmpty,
        reason:
            'These files differ in CODE between the two trees. An interpreter '
            'fix belongs in both — mirror it. If the difference is genuinely '
            'architectural, add it to kDivergentMirrors with the reason, which '
            'is a deliberate act rather than a silent one.\n'
            '${drifted.join('\n\n')}',
      );
    });

    test('F-SCC92-4: no baselined pair has quietly started agreeing '
        '[2026-09-07]', () {
      // The half that keeps the baseline honest. Without it an entry outlives
      // the difference it describes and the file reads as permanently
      // divergent when somebody has already reconciled it — which is how a
      // baseline becomes a list nobody trusts. It fired on its first run: five
      // stdlib barrels had been copied in from an earlier measurement and did
      // not diverge at all.
      final stale = <String>[];
      final missing = <String>[];
      for (final rel in kDivergentMirrors.keys) {
        if (!File('$kReferenceRoot/$rel').existsSync() ||
            !File('$kAstRoot/$rel').existsSync()) {
          missing.add(rel);
          continue;
        }
        if (diffFor(rel).isEmpty) stale.add(rel);
      }
      expect(
        missing,
        isEmpty,
        reason:
            'These baseline entries name a pair that no longer exists on one '
            'side or the other. Delete them.\n${missing.join('\n')}',
      );
      expect(
        stale,
        isEmpty,
        reason:
            'These pairs now agree, so their baseline entries claim a '
            'difference that is gone. Remove them — the entry is what tells '
            'the next reader the divergence is deliberate.\n'
            '${stale.join('\n')}',
      );
    });

    test('F-SCC92-5: every baseline entry carries a reason worth reading '
        '[2026-09-07]', () {
      // The same rule the conformance guard's F-SCC44-1 applies to its own
      // divergence register: a one-word reason is a filename restated, and an
      // entry nobody can evaluate is an exemption nobody can withdraw.
      final thin = kDivergentMirrors.entries
          .where((e) => e.value.length < 60)
          .map((e) => '${e.key}: "${e.value}"')
          .toList();
      expect(
        thin,
        isEmpty,
        reason:
            'These entries do not say what differs or why it must. Write what '
            'the two copies assert differently and what makes converging '
            'wrong.\n${thin.join('\n')}',
      );
    });
  }, skip: skipReason);
}
