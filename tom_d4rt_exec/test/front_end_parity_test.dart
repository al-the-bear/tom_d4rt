// scd10_aicx: the front end is a mirror too, and nothing said so.
//
// The quest's mirroring rule names the INTERPRETER pair
// (`interpreter_visitor.dart` and friends), and that pair was in sync
// throughout. What drifted is the layer this package adds ON TOP of the
// analyzer-free interpreter: `lib/src/d4rt_base.dart` and
// `lib/src/module_loader.dart`, which mirror `tom_d4rt`'s files of the same
// names. They hold the host boundary, where an SDK-shaped error either
// survives or is re-wrapped, and the registration site, where a bridge's
// source URI either reaches the environment or does not.
//
// WHAT THAT COST (SCC3, 2026-09-03). Two production defects sat here for
// months:
//
//   * `_executeInEnvironment`'s catch-alls lacked `isSdkShapedError(e)` and
//     `AmbiguousBridgedNameException`, so a `D4rtTypeError` /
//     `D4rtNoSuchMethodError` / `AssertionError` came back to the host as
//     `RuntimeD4rtException('Unexpected error: …')` — defeating the whole
//     point of SCB10.
//   * the bridged-class registration computed `sourceUri` and used it only
//     for dedup and logging, never passing it to `defineBridgeLazy`. Without
//     it the environment cannot derive a package qualifier, so tcca19's
//     ambiguity detection never fires and the bare name binds to whichever
//     bridge registered last.
//
// Neither is visible from inside `tom_d4rt_ast`: the code lives in the
// consumer, so only this package's suite can see it — and it was pinned
// eleven minors behind, which is why it stayed invisible.
//
// WHY NOT A DIFF. These files are structurally similar, not identical: this
// package delegates to `D4rtRunner`, parses with the analyzer front end, and
// is ~1000 lines shorter. A byte diff reports everything and would be muted on
// its first run. So the guard compares VOCABULARY at the two places where
// drift actually hurt, and each rule below is measured against the real
// incident rather than imagined:
//
//   F-SCD10-1  every error/exception TYPE and bare guard helper the reference
//              names in code, this package names too. Measured against the
//              pre-fix PAIR (both trees at 25b4d764c^): reports
//              `AmbiguousBridgedNameException` and `isSdkShapedError`, the
//              exact SCB10 regression. It is green against today's pair in
//              both directions — SCC27 replaced that enumerated list with one
//              rule — so this is the forward-looking half: it covers the next
//              type or helper without anyone adding an assertion for it.
//   F-SCD10-3  every named ARGUMENT the reference passes at a mirrored call
//              site, this package passes too. Measured against the pre-fix
//              file: reports `sourceUri` missing from `defineBridgeLazy`, the
//              exact tcca19 regression.
//   F-SCD10-4  the boundary still routes through `throwAsHostFacingError` in
//              BOTH trees, and registration still qualifies by source URI.
//              Measured against the pre-fix file: red.
//
// Comments are stripped before comparing: `module_loader.dart` mentions
// `AmbiguousBridgedNameException` in a comment explaining where the throw
// lives, and a guard that counted that would pass while the code diverged.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// The mirrored front-end files, as `reference -> this package`.
/// Every `lib/src/` file this package shares a name with in the reference
/// tree. There are exactly three, and all three are covered: a pair that is
/// mirrored but unguarded is how this incident happened.
const _mirroredFiles = <String, String>{
  '../tom_d4rt/lib/src/d4rt_base.dart': 'lib/src/d4rt_base.dart',
  '../tom_d4rt/lib/src/module_loader.dart': 'lib/src/module_loader.dart',
  '../tom_d4rt/lib/src/script_execution.dart': 'lib/src/script_execution.dart',
};

/// Call sites whose named arguments must survive the port, by file.
///
/// `defineBridgeLazy`'s `sourceUri` is the tcca19 case: dropping it silently
/// disables ambiguity detection for every same-name bridge.
const _mirroredCalls = <String, List<String>>{
  '../tom_d4rt/lib/src/module_loader.dart': ['defineBridgeLazy'],
};

/// Names the reference uses that this package legitimately does not.
///
/// Each entry is a statement that the difference is by design, with the
/// reason. An entry that stops being true should fail loudly rather than
/// linger, so F-SCD10-2 requires every entry to still be absent here.
const _expectedAbsences = <String, Map<String, String>>{
  'lib/src/d4rt_base.dart': {
    'StateError': 'registerExtensions/finalizeBridges delegate to D4rtRunner '
        'in tom_d4rt_ast, which is where the StateError is thrown; this file '
        'only forwards.',
  },
};

String _stripComments(String source) {
  var out = source.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
  out = out.replaceAll(RegExp(r'^\s*//.*$', multiLine: true), '');
  return out.replaceAll(RegExp(r'(?<![:"])//.*$', multiLine: true), '');
}

/// Error and exception type names the file references in code.
Set<String> _errorTypes(String source) => RegExp(
      r'\b([A-Z][A-Za-z0-9_]*(?:Exception|Error))\b',
    ).allMatches(_stripComments(source)).map((m) => m.group(1)!).toSet();

/// Bare `isSomething(` calls — the guard helpers, not methods on a receiver.
///
/// The receiver exclusion matters: `uri.isScheme('file')` is the SDK's, not a
/// shared helper, and reporting it would be the noise that gets a guard muted.
Set<String> _guardCalls(String source) => RegExp(
      r'(?<![.\w])(is[A-Z][A-Za-z0-9_]*)\s*\(',
    ).allMatches(_stripComments(source)).map((m) => m.group(1)!).toSet();

/// Named arguments passed to [function], at its own argument level.
Set<String> _namedArguments(String source, String function) {
  final stripped = _stripComments(source);
  final names = <String>{};
  for (final call
      in RegExp('(?<![A-Za-z0-9_])$function\\s*\\(').allMatches(stripped)) {
    var depth = 1;
    var i = call.end;
    while (i < stripped.length && depth > 0) {
      final ch = stripped[i];
      if (ch == '(') depth++;
      if (ch == ')') depth--;
      i++;
    }
    final body = stripped.substring(call.end, i - 1);
    var nested = 0;
    for (final token
        in RegExp(r'[()\[\]{}]|\b([a-z][A-Za-z0-9_]*)\s*:').allMatches(body)) {
      final text = token.group(0)!;
      if ('([{'.contains(text)) {
        nested++;
      } else if (')]}'.contains(text)) {
        nested--;
      } else if (token.group(1) != null && nested == 0) {
        names.add(token.group(1)!);
      }
    }
  }
  return names;
}

void main() {
  final haveReference = File(_mirroredFiles.keys.first).existsSync();
  final skipReason = haveReference
      ? null
      : 'needs the sibling checkout ../tom_d4rt; this guard is about the repo '
          'layout and cannot run from a published tom_d4rt_exec on its own';

  group('SCD10: the front end mirrors tom_d4rt where it has to', () {
    test(
      'F-SCD10-1: every error type and guard helper the reference names in '
      'code is named here too [2026-09-12] (PASS)',
      () {
        final findings = <String>[];
        _mirroredFiles.forEach((reference, ported) {
          final absences = _expectedAbsences[ported] ?? const {};
          final referenceSource = File(reference).readAsStringSync();
          final portedSource = File(ported).readAsStringSync();

          // Two vocabularies, because the SCB10 regression spanned both: an
          // exception type the boundary let through, and the bare helper that
          // classified the rest. `isSdkShapedError` has since been deleted
          // upstream, but the next such helper is covered without anyone
          // adding a rule for it.
          final missing = <String>{
            ..._errorTypes(referenceSource)
                .difference(_errorTypes(portedSource)),
            ..._guardCalls(referenceSource)
                .difference(_guardCalls(portedSource)),
          }.where((name) => !absences.containsKey(name)).toList()
            ..sort();
          for (final name in missing) {
            findings.add('$ported does not name $name, which '
                '${p.basename(reference)} uses');
          }
        });

        expect(
          findings,
          isEmpty,
          reason: 'An error type the reference handles and this file does not '
              'is how SCB10 was lost: the host boundary re-wrapped every '
              'SDK-shaped error as `Unexpected error: …`. Port the handling, '
              'or record the difference in _expectedAbsences with its '
              'reason.\n  ${findings.join('\n  ')}',
        );
      },
      skip: skipReason,
    );

    test(
      'F-SCD10-2: every recorded absence is still absent [2026-09-12] (PASS)',
      () {
        // An allowlist nobody re-checks becomes a list of things that used to
        // be true. When a delegation stops delegating, this fails rather than
        // granting a permanent exemption.
        final stale = <String>[];
        _expectedAbsences.forEach((ported, absences) {
          final present = _errorTypes(File(ported).readAsStringSync());
          for (final entry in absences.entries) {
            if (present.contains(entry.key)) {
              stale.add('$ported now names ${entry.key}; delete its '
                  '_expectedAbsences entry ("${entry.value}")');
            }
          }
        });
        expect(stale, isEmpty, reason: stale.join('\n'));
      },
      skip: skipReason,
    );

    test(
      'F-SCD10-3: every named argument the reference passes at a mirrored call '
      'site is passed here too [2026-09-12] (PASS)',
      () {
        final findings = <String>[];
        _mirroredCalls.forEach((reference, functions) {
          final ported = _mirroredFiles[reference]!;
          final referenceSource = File(reference).readAsStringSync();
          final portedSource = File(ported).readAsStringSync();
          for (final function in functions) {
            final missing = _namedArguments(referenceSource, function)
                .difference(_namedArguments(portedSource, function))
                .toList()
              ..sort();
            for (final argument in missing) {
              findings.add('$ported calls $function without `$argument:`, '
                  'which ${p.basename(reference)} passes');
            }
          }
        });

        expect(
          findings,
          isEmpty,
          reason: 'This is the tcca19 shape: the value is computed, used for '
              'logging, and never handed to the environment, so ambiguity '
              'detection silently never fires.\n  ${findings.join('\n  ')}',
        );
      },
      skip: skipReason,
    );

    test(
      'F-SCD10-4: the guard is looking at the files it claims to '
      '[2026-09-12] (PASS)',
      () {
        // Anti-vacuity. Every rule above passes trivially if a path is wrong
        // or a file stops containing the code this is about.
        for (final entry in _mirroredFiles.entries) {
          expect(File(entry.key).existsSync(), isTrue, reason: entry.key);
          expect(File(entry.value).existsSync(), isTrue, reason: entry.value);
        }
        // Every same-named `lib/src/` file is covered. A new one appearing
        // unguarded is the shape this guard exists to prevent.
        final shared = Directory('lib/src')
            .listSync()
            .whereType<File>()
            .map((f) => p.basename(f.path))
            .where((name) =>
                name.endsWith('.dart') &&
                File(p.join('..', 'tom_d4rt', 'lib', 'src', name)).existsSync())
            .toSet();
        expect(
          shared.difference(
            _mirroredFiles.values.map(p.basename).toSet(),
          ),
          isEmpty,
          reason: 'a lib/src file shares its name with one in tom_d4rt but is '
              'not in _mirroredFiles',
        );
        // What the boundary must still DO, in the shape it has today. SCC27
        // replaced the enumerated escape list — DFUB13's exception types plus
        // `isSdkShapedError`'s four SDK shapes — with one rule: anything that
        // is an Error or an Exception escapes as itself, via
        // `throwAsHostFacingError`, which also unwraps a native callee's error
        // out of its RuntimeD4rtException. Pinning the old symbols here would
        // pin a mechanism that was deliberately deleted, so this pins the
        // mechanism that replaced it.
        for (final file in const [
          'lib/src/d4rt_base.dart',
          '../tom_d4rt/lib/src/d4rt_base.dart',
        ]) {
          expect(
            _stripComments(File(file).readAsStringSync()),
            contains('throwAsHostFacingError('),
            reason: '$file must route its catch-all through the shared '
                'host-facing conversion, or SDK-shaped errors are re-wrapped '
                'as `Unexpected error: …` again (SCB10, then SCC27)',
          );
        }
        expect(
          _namedArguments(
            File('lib/src/module_loader.dart').readAsStringSync(),
            'defineBridgeLazy',
          ),
          contains('sourceUri'),
          reason: 'registration must still qualify the bridge by source URI',
        );
      },
      skip: skipReason,
    );
  });
}
