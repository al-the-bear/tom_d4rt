// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every non-driver file both twins
// carry in test/ is classified, and the derivable ones agree in code.
//
// Its subject reaches OUTSIDE this package (the sibling twin's test/ tree), so
// it runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made that
// arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
/// SCE170 — the twins' hand-duplicated test infrastructure.
///
/// The two Flutter twins share 63 tracked files in `test/` (measured
/// 2026-09-25). Forty-one are `flutter_{base,extended}_NN_test.dart` drivers,
/// whose assertions and skips are each twin's own. The other 22 are
/// infrastructure, and until this guard nothing compared any of them. SCD131
/// raised `IDLE_TIMEOUT` in ten runner scripts across both twins by hand; each
/// such edit was a chance to get one copy wrong with nothing to catch it.
///
/// MEASURED BEFORE A MECHANISM WAS CHOSEN. Compared as CODE, modulo comments,
/// directives and the twin parameters in [twinParameters], 16 of the 22 are
/// identical. That decides the mechanism: those 16 are asserted identical, and
/// no sync tool is built. A generator would overwrite each twin's comments,
/// which describe its own variant ("analyzer-free (AST)" versus
/// "source-direct") and are right to differ.
///
/// The other six diverge in code for reasons that are the twins' design, not
/// drift, and each is recorded in [divergent] with the measured reason, in the
/// same shape as `check_mirrored_sources.dart`'s allow-list (SCC92).
///
/// Four rules keep the lists honest:
///
/// - SCE170-1: every shared non-driver file is classified. A file that starts
///   being duplicated arrives red rather than joining the unguarded majority.
/// - SCE170-3: a divergent entry whose pair has converged is stale and must
///   move to [derivable]. Otherwise the list names a difference that no longer
///   exists, and that file stops being guarded.
/// - SCE170-4: every twin parameter is used by at least one derivable pair. A
///   substitution nothing needs can only mask a real difference.
/// - SCE170-5: no derivable copy carries the OTHER twin's parameter. Identity
///   cannot see that defect, because a copied-verbatim parameter compares
///   EQUAL. It is the one this guard found on its first run: the AST twin's
///   three profiler scripts read `TOM_D4RT_TEST_TEST_PORT`, the source twin's
///   port variable, while the AST app binds `TOM_D4RT_AST_TEST_PORT` — so
///   moving the AST app off a wedged port, the variable's documented purpose,
///   left the profiler probing the old one.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The sibling twin's test directory, relative to this package root.
const String siblingTest = '../tom_d4rt_flutter/test';

/// What legitimately differs between the twins' copies of a file that is
/// otherwise the same code, as `(AST twin, source twin, why)`.
///
/// Applied to the AST twin's text, in order, before comparing. Order matters:
/// the app-directory name must be replaced before the package prefix it
/// contains.
///
/// SCE170-4 keeps this list to what the code needs. On its first run it
/// removed two entries whose values occur only in comments, and flagged a
/// third that pointed at a real defect — see SCE170-5.
const List<(String, String, String)> twinParameters = [
  (
    'tom_d4rt_flutter_ast_app',
    'tom_d4rt_flutter_test_app',
    'the companion app each twin drives (named in the shared script path)',
  ),
  ('tom_d4rt_flutter_ast', 'tom_d4rt_flutter', 'the twin package itself'),
  ('tom_d4rt_ast', 'tom_d4rt', 'the interpreter each twin binds'),
  ('4247', '4248', 'the HTTP port — distinct so the two apps cannot collide'),
  (
    'TOM_D4RT_AST_TEST_PORT',
    'TOM_D4RT_TEST_TEST_PORT',
    'the environment variable overriding that port',
  ),
  ('D4rtRunner', 'D4rt', 'each interpreter\'s runner class'),
  ('FlutterD4rt', 'SourceFlutterD4rt', 'each twin\'s Flutter-bridged runner'),
];

/// Shared files whose code must be identical modulo [twinParameters].
const Set<String> derivable = {
  'companion_app_resolution.dart',
  'framework_error_isolation_test.dart',
  'idle_timeout.ps1',
  'idle_timeout.sh',
  'interpreter_generator_open_issues_test.dart',
  'registration_skip_test.dart',
  'run_attribution.dart',
  'run_base_tests.ps1',
  'run_base_tests.sh',
  'run_harness_tests.ps1',
  'run_harness_tests.sh',
  'run_issue_analysis_tests.ps1',
  'run_issue_analysis_tests.sh',
  'run_test_profiler.sh',
  'start_test_profiler.sh',
  'start_test_profiler_debug.sh',
};

/// Shared files that diverge in code by design, with the measured reason.
///
/// Sizes are code lines that differ after normalisation, measured 2026-09-25.
/// They are a dated observation, not a pin; what this guard pins is that each
/// entry still diverges (SCE170-3).
const Map<String, String> divergent = {
  'README.md':
      'prose written for each twin\'s own reader. What must agree is guarded '
      'by rule rather than by text: SCD65-3 and SCE169 in '
      'interpreter_issues_doc_test.dart.',
  'run_guard_tests.sh':
      '69 vs 29 code lines. This twin runs the repo-wide guards for the pair '
      '(user-bridge sync, skip hygiene, this file); the source twin runs only '
      'its own.',
  'scd133_registry_enum_resolution_test.dart':
      '18 lines: the AST line compiles the probe through AstBundler before '
      'executing it, and each twin\'s floors cite its own measured counts.',
  'scd195_registry_collision_test.dart':
      '12 lines: the same AstBundler step as scd133.',
  'send_test_runner.dart':
      '556 lines. Only this twin regenerates its bridges before a run '
      '(_ensureBridgesRegenerated and its fingerprint stamp) and bundles '
      'scripts through AstBundler; the source twin posts source '
      '(_httpPostSource) and reads THIS twin\'s script corpus. The pass '
      'verdict they must share is guarded by SCE167.',
  'suspicious_rewrite_test.dart':
      '4587 vs 781 code lines: each twin records its own per-script rewrite '
      'verdicts, and this twin carries about six times as many.',
};

/// A corpus driver: its assertions and skips belong to its own twin.
final RegExp corpusDriver = RegExp(r'^flutter_(base|extended)_\d+_test\.dart$');

/// Tracked files directly under [dir], by name.
Set<String> trackedTopLevel(String dir) {
  final result = Process.runSync('git', ['ls-files'], workingDirectory: dir);
  if (result.exitCode != 0) {
    throw StateError('git ls-files failed in $dir: ${result.stderr}');
  }
  return {
    for (final line in (result.stdout as String).split('\n'))
      if (line.isNotEmpty && !line.contains('/')) line,
  };
}

/// [text] reduced to its code: comments and directives removed, whitespace
/// collapsed, and — for the AST twin — [twinParameters] applied.
///
/// [used] collects the index of every parameter that changed something.
List<String> codeOf(
  String path,
  String text, {
  required bool astTwin,
  Set<int>? used,
}) {
  final isDart = path.endsWith('.dart');
  final isMarkdown = path.endsWith('.md');
  var body = text;
  if (isDart) body = body.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
  final out = <String>[];
  for (final raw in body.split('\n')) {
    var line = raw.trim();
    if (isDart) {
      if (line.startsWith('//')) continue;
      if (RegExp(r'^(import|export|library|part)\b').hasMatch(line)) continue;
      line = line.replaceFirst(RegExp(r'\s//\s.*$'), '');
    } else if (!isMarkdown) {
      if (line.startsWith('#') && !line.startsWith('#!')) continue;
    }
    if (astTwin) {
      for (var i = 0; i < twinParameters.length; i++) {
        final (from, to, _) = twinParameters[i];
        // Word-bounded, so `FlutterD4rt` does not rewrite the tail of a
        // `SourceFlutterD4rt` and `D4rtRunner` only matches the class.
        final pattern = RegExp('(?<![A-Za-z0-9_])${RegExp.escape(from)}');
        final next = line.replaceAll(pattern, to);
        if (next != line) used?.add(i);
        line = next;
      }
    }
    line = line.replaceAll(RegExp(r'\s+'), ' ');
    if (line.isNotEmpty) out.add(line);
  }
  return out;
}

/// The first place [a] and [b] disagree, for the failure message.
String firstDifference(List<String> a, List<String> b) {
  final n = a.length < b.length ? a.length : b.length;
  for (var i = 0; i < n; i++) {
    if (a[i] != b[i]) {
      return 'code line ${i + 1}:\n        AST twin (normalised): ${a[i]}\n'
          '        source twin:          ${b[i]}';
    }
  }
  return 'one copy has ${a.length} code lines, the other ${b.length}';
}

/// The twin parameters whose two values are textually distinct — neither
/// contains the other — so finding one twin's value in the other twin's copy
/// is unambiguous.
///
/// `tom_d4rt` is inside `tom_d4rt_ast` and `D4rt` inside `D4rtRunner`, so those
/// pairs cannot be told apart by text and are left to SCE170-2.
List<(String, String, String)> get distinctiveParameters => [
  for (final p in twinParameters)
    if (!p.$1.contains(p.$2) && !p.$2.contains(p.$1)) p,
];

/// Word-bounded occurrences of [value] in [code].
bool mentions(List<String> code, String value) {
  final pattern = RegExp(
    '(?<![A-Za-z0-9_])${RegExp.escape(value)}(?![A-Za-z0-9_])',
  );
  return code.any(pattern.hasMatch);
}

void main() {
  late Set<String> shared;

  setUpAll(() {
    shared = trackedTopLevel('test').intersection(trackedTopLevel(siblingTest));
  });

  group('SCE170: the twins\' duplicated test infrastructure', () {
    test(
      'SCE170-1: every non-driver file both twins carry is classified, and '
      'every classified file is carried by both. [2026-09-25 00:00] (PASS)',
      () {
        final infrastructure = {
          for (final name in shared)
            if (!corpusDriver.hasMatch(name)) name,
        };
        // Anti-vacuity: an empty intersection (wrong directory, git absent
        // from PATH) would satisfy every rule below while comparing nothing.
        expect(
          shared.where(corpusDriver.hasMatch).length,
          greaterThanOrEqualTo(41),
          reason:
              'The shared driver set is smaller than the 41 drivers each '
              'twin carries, so the twin trees were not read.',
        );

        final classified = {...derivable, ...divergent.keys};
        expect(
          derivable.intersection(divergent.keys.toSet()),
          isEmpty,
          reason: 'A file is either derivable or divergent, not both.',
        );
        expect(
          infrastructure.difference(classified),
          isEmpty,
          reason:
              'These files are now carried by BOTH twins and are in '
              'neither list. Compare them as this file does: if the code '
              'agrees modulo twinParameters, add the file to `derivable`; '
              'otherwise add it to `divergent` with the measured reason.',
        );
        expect(
          classified.difference(infrastructure),
          isEmpty,
          reason:
              'These entries name a file that is no longer carried by '
              'both twins. Delete the entry.',
        );
      },
    );

    test('SCE170-2: every derivable pair is the same code. '
        '[2026-09-25 00:00] (PASS)', () {
      final drifted = <String>[];
      for (final name in derivable) {
        final ast = codeOf(
          name,
          File('test/$name').readAsStringSync(),
          astTwin: true,
        );
        final source = codeOf(
          name,
          File('$siblingTest/$name').readAsStringSync(),
          astTwin: false,
        );
        if (ast.join('\n') == source.join('\n')) continue;
        drifted.add('$name — ${firstDifference(ast, source)}');
      }
      expect(
        drifted,
        isEmpty,
        reason:
            'These files are duplicated by hand across the twins, and '
            'one copy changed without the other. Comments may differ; code '
            'may not, except for the parameters listed in `twinParameters`. '
            'Apply the change to both copies:\n  ${drifted.join('\n  ')}',
      );
    });

    test('SCE170-3: every divergent entry still diverges. '
        '[2026-09-25 00:00] (PASS)', () {
      final converged = <String>[];
      for (final name in divergent.keys) {
        final ast = codeOf(
          name,
          File('test/$name').readAsStringSync(),
          astTwin: true,
        );
        final source = codeOf(
          name,
          File('$siblingTest/$name').readAsStringSync(),
          astTwin: false,
        );
        if (ast.join('\n') == source.join('\n')) converged.add(name);
      }
      expect(
        converged,
        isEmpty,
        reason:
            'These pairs are the same code now, so their `divergent` '
            'entry names a difference that no longer exists and exempts '
            'the file from SCE170-2. Move them to `derivable`:\n  '
            '${converged.join('\n  ')}',
      );
    });

    test('SCE170-4: every twin parameter is needed by some derivable pair. '
        '[2026-09-25 00:00] (PASS)', () {
      final used = <int>{};
      for (final name in derivable) {
        codeOf(
          name,
          File('test/$name').readAsStringSync(),
          astTwin: true,
          used: used,
        );
      }
      final unused = [
        for (var i = 0; i < twinParameters.length; i++)
          if (!used.contains(i))
            '${twinParameters[i].$1} -> ${twinParameters[i].$2}',
      ];
      expect(
        unused,
        isEmpty,
        reason:
            'No derivable file needs these substitutions any more. A '
            'substitution nothing needs can only hide a real difference, so '
            'delete it:\n  ${unused.join('\n  ')}',
      );
    });
    test('SCE170-5: no derivable copy carries the other twin\'s parameter. '
        '[2026-09-25 00:00] (PASS)', () {
      final crossed = <String>[];
      for (final name in derivable) {
        final ast = codeOf(
          name,
          File('test/$name').readAsStringSync(),
          astTwin: false,
        );
        final source = codeOf(
          name,
          File('$siblingTest/$name').readAsStringSync(),
          astTwin: false,
        );
        for (final (astValue, sourceValue, what) in distinctiveParameters) {
          if (mentions(ast, sourceValue)) {
            crossed.add(
              'test/$name uses `$sourceValue` — the source twin\'s $what; '
              'this twin\'s is `$astValue`',
            );
          }
          if (mentions(source, astValue)) {
            crossed.add(
              '$siblingTest/$name uses `$astValue` — the AST twin\'s '
              '$what; this twin\'s is `$sourceValue`',
            );
          }
        }
      }
      expect(
        distinctiveParameters,
        isNotEmpty,
        reason:
            'No twin parameter is textually distinct, so this check '
            'compares nothing.',
      );
      expect(
        crossed,
        isEmpty,
        reason:
            'A copy carries the other twin\'s value. SCE170-2 cannot see '
            'this — a parameter copied verbatim compares EQUAL — and it is '
            'the defect a hand copy produces:\n  ${crossed.join('\n  ')}',
      );
    });
  });
}
