// GEN-123: every path handed to `AnalysisContextCollection*.includedPaths`
// must be absolute AND normalized.
//
// Reproduction. Regenerating the non-Flutter D4rt corpus with a *relative*
// scan root aborts on the one project in it that has user bridges:
//
//     $ cd tom_ai/d4rt/tom_d4rt_samples
//     $ d4rtgen -s . -r -p d4rt_userbridges_sample
//     Error processing ./d4rt_userbridges_sample: Invalid argument(s):
//       Only absolute normalized paths are supported: d4rt_userbridges_sample
//
// The same command with `-s "$(pwd)"` succeeds. So the defect is not in the
// project — it is that a relative project directory reaches the analyzer.
//
// Root cause. The requirement was written out by hand at five call sites, and
// three of them only did half of it:
//
//     final normalizedProjectDir = p.normalize(projectDir);   // WRONG
//
// `p.normalize` collapses `.` and `..`; it does not make a path absolute. Two
// sites (`bridge_generator.dart`, `proxy_generator.dart`) additionally joined
// against `Directory.current.path` and were correct; the three user-bridge
// pre-scan sites (`bridge_api.dart`, `per_package_orchestrator.dart`,
// `v2/d4rtgen_executor.dart`) did not. That is why only a project carrying
// `lib/src/d4rt_user_bridges/` could trip it — everywhere else the analyzer
// context is built from an already-absolutised path.
//
// The comments at the wrong sites explain the Windows half of the rule
// ("a forward-slash absolute path is not normalized on Windows") and are
// perfectly accurate as far as they go. The bug is what they leave out, which
// is exactly the failure mode of writing one rule down five times.
//
// The fix is the extraction: a single `analysisIncludedPath()` that states the
// whole contract once, used at every site. G-GEN123-04 is what keeps it that
// way — a sixth site that re-derives the path by hand fails the suite.
//
// NOTE ON TEST DESIGN: like the GEN-119/GEN-120/GEN-121/GEN-122 suites, this
// file deliberately does NOT chdir. `dart test` runs test files as isolates
// inside one process and `Directory.current` is process-wide, so changing it
// here breaks every other test file that resolves fixtures against the cwd.

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/analysis_paths.dart';
import 'package:tom_d4rt_generator/src/sdk_utils.dart';
import 'package:tom_d4rt_generator/src/user_bridge_prescan.dart';

/// Source files that build an `AnalysisContextCollection`, relative to `lib/`.
///
/// Listed explicitly rather than globbed so that G-GEN123-04 fails loudly when
/// a file is renamed, instead of quietly scanning nothing.
const _contextBuildingSources = <String>[
  'src/bridge_generator.dart',
  'src/per_package_orchestrator.dart',
  'src/proxy_generator.dart',
  'src/user_bridge_prescan.dart',
];

/// `includedPaths: [<identifier>]`, capturing the identifier.
final _includedPathsPattern = RegExp(r'includedPaths:\s*\[\s*(\w+)\s*\]');

/// `<identifier> = analysisIncludedPath(`, capturing the identifier.
///
/// The declaration keyword is optional: one site absolutises a variable it
/// already derived (`packageRoot = analysisIncludedPath(packageRoot)`), which
/// is a plain reassignment.
final _helperAssignmentPattern = RegExp(
  r'(?:(?:final|var)\s+)?(\w+)\s*=\s*analysisIncludedPath\(',
);

void main() {
  group('GEN-123: analysisIncludedPath states the whole contract', () {
    test(
      'G-GEN123-01: a relative path becomes absolute [2026-08-12] (FAIL)',
      () {
        final resolved = analysisIncludedPath('d4rt_userbridges_sample');

        expect(
          p.isAbsolute(resolved),
          isTrue,
          reason:
              'This is the exact argument that aborted the corpus regen. '
              '`p.normalize` alone leaves it relative. Got: $resolved',
        );
        expect(
          resolved,
          equals(
            p.normalize(
              p.join(Directory.current.path, 'd4rt_userbridges_sample'),
            ),
          ),
          reason: 'a relative path resolves against the current directory',
        );
      },
    );

    test(
      'G-GEN123-02: an absolute path is preserved, and normalized '
      '[2026-08-12] (FAIL)',
      () {
        final root = Directory.current.path;
        final denormalized = p.join(root, 'lib', '..', 'lib', 'src');

        final resolved = analysisIncludedPath(denormalized);

        expect(resolved, equals(p.join(root, 'lib', 'src')));
        expect(
          resolved,
          isNot(contains('..')),
          reason:
              'the analyzer rejects a non-normalized path just as firmly as a '
              'relative one — both raise the same ArgumentError',
        );
      },
    );

    test(
      'G-GEN123-03: the analyzer accepts the result for a relative input '
      '[2026-08-12] (FAIL)',
      () {
        // The behavioural half. G-GEN123-01 asserts a property of a string;
        // this asserts that the operation which actually threw now succeeds,
        // and that it still throws without the helper — so the test cannot
        // pass for the wrong reason (e.g. if `analysisIncludedPath` were
        // reduced to `p.normalize` again, this would go red too).
        final relative = p.relative(
          Directory.current.path,
          from: p.dirname(Directory.current.path),
        );

        expect(
          () => AnalysisContextCollection(
            includedPaths: [p.normalize(relative)],
            sdkPath: getSdkPath(),
          ),
          throwsArgumentError,
          reason:
              'guards the premise: if the analyzer ever starts accepting a '
              'relative includedPath, this suite is no longer testing '
              'anything and GEN-123 should be revisited rather than kept',
        );

        expect(
          () => AnalysisContextCollection(
            includedPaths: [analysisIncludedPath(relative)],
            sdkPath: getSdkPath(),
          ),
          returnsNormally,
        );
      },
    );
  });

  group('GEN-123: a relative project dir finds the same user bridges', () {
    // The half that the first fix missed. Absolutising `includedPaths` alone
    // stopped the crash but moved the failure downstream: `contextFor` and
    // `getResolvedLibrary` were still handed relative paths, threw, and the
    // throw was swallowed by a verbose-gated catch. The run then emitted
    // bridges with every user-bridge override silently dropped — no error,
    // no warning, wrong output. A count assertion is what catches that;
    // "does not throw" would have passed the whole time.

    /// `tom_d4rt_samples/d4rt_userbridges_sample` — the project whose four
    /// user bridges (3 class + 1 globals) exposed the bug.
    late final String sampleAbsolute = p.normalize(
      p.join(
        Directory.current.path,
        '..',
        'tom_d4rt_samples',
        'd4rt_userbridges_sample',
      ),
    );

    setUpAll(() {
      if (!Directory(sampleAbsolute).existsSync()) {
        throw StateError(
          'GEN-123 fixture missing: $sampleAbsolute. This suite asserts on a '
          'real project rather than a synthetic one because the defect was in '
          'how a real scan root reaches the analyzer.',
        );
      }
    });

    test(
      'G-GEN123-06: relative and absolute project dirs yield identical '
      'user-bridge counts [2026-08-12] (FAIL)',
      () async {
        final fromAbsolute = await preScanUserBridges(sampleAbsolute);
        final fromRelative = await preScanUserBridges(
          p.relative(sampleAbsolute, from: Directory.current.path),
        );

        expect(
          fromAbsolute.userBridges.length,
          greaterThan(0),
          reason:
              'anti-vacuity: if the fixture stops carrying user bridges both '
              'sides go to zero and the comparison below passes for free',
        );
        expect(
          fromRelative.userBridges.length,
          equals(fromAbsolute.userBridges.length),
          reason:
              'a relative scan root found '
              '${fromRelative.userBridges.length} class user bridges where an '
              'absolute one found ${fromAbsolute.userBridges.length}. That '
              'gap is emitted as bridges missing overrides, not as an error.',
        );
        expect(
          fromRelative.globalsUserBridges.length,
          equals(fromAbsolute.globalsUserBridges.length),
        );
      },
      timeout: const Timeout(Duration(minutes: 4)),
    );
  });

  group('GEN-123: no call site re-derives the path by hand', () {
    late Map<String, String> sources;

    setUpAll(() {
      final libDir = p.join(Directory.current.path, 'lib');
      sources = {
        for (final relative in _contextBuildingSources)
          relative: File(p.join(libDir, relative)).readAsStringSync(),
      };
    });

    test(
      'G-GEN123-04: every includedPaths argument comes from '
      'analysisIncludedPath [2026-08-12] (FAIL)',
      () {
        final offenders = <String>[];
        var checkedSites = 0;

        sources.forEach((file, source) {
          final helperVariables = _helperAssignmentPattern
              .allMatches(source)
              .map((m) => m.group(1)!)
              .toSet();

          for (final match in _includedPathsPattern.allMatches(source)) {
            checkedSites++;
            final variable = match.group(1)!;
            if (!helperVariables.contains(variable)) {
              offenders.add('$file: includedPaths: [$variable]');
            }
          }
        });

        expect(
          checkedSites,
          greaterThanOrEqualTo(5),
          reason:
              'anti-vacuity: the five known context-building sites must still '
              'be found. If this drops, a file was renamed or the call was '
              'reshaped — update `_contextBuildingSources` rather than '
              'deleting the gate.',
        );
        expect(
          offenders,
          isEmpty,
          reason:
              'Each of these builds an analyzer context from a path it '
              'derived itself. That is how GEN-123 happened: three of five '
              'hand-written derivations forgot to absolutise. Offenders: '
              '$offenders',
        );
      },
    );

    test(
      'G-GEN123-05: no context-building source calls bare p.normalize on a '
      'project path [2026-08-12] (FAIL)',
      () {
        // The specific wrong shape, named so it cannot creep back in under a
        // different variable name than the ones G-GEN123-04 knows about.
        final barePattern = RegExp(
          r'(?:final|var)\s+\w*(?:[Pp]roject|[Ww]orkspace)\w*\s*=\s*'
          r'p\.normalize\(\s*\w+\s*\)',
        );

        final offenders = <String>[];
        sources.forEach((file, source) {
          for (final match in barePattern.allMatches(source)) {
            offenders.add('$file: ${match.group(0)}');
          }
        });

        expect(
          offenders,
          isEmpty,
          reason:
              '`p.normalize(x)` collapses `.`/`..` but leaves a relative path '
              'relative. Use `analysisIncludedPath(x)`. Offenders: $offenders',
        );
      },
    );
  });
}
