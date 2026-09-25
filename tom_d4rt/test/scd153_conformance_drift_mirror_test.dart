// REPO-WIDE GUARD (tom_d4rt) — a test in this tree that stops matching its
// `tom_d4rt_exec` port fails HERE, in the run that changed it.
//
// WHY A SECOND COPY OF THIS CHECK EXISTS. `tom_d4rt_exec/test/
// conformance_drift_test.dart` already compares the two corpora, and compares
// them far more thoroughly than this file does. But it is a file in exec's
// suite, so it executes only when somebody runs exec — and every divergence it
// detects is authored HERE, because this is where the reference cases are
// written. A guard whose trigger condition is "someone edits tree A" and whose
// execution condition is "someone runs tree B's suite" has an unbounded lag.
//
// MEASURED, TWICE. SCC52 opened exec's suite and found eleven red entries
// authored one turn at a time by turns that had no reason to look. SCD153, the
// todo that produced this file, opened it again and found NINE unbaselined
// content divergences plus a stale case count — and two of those were authored
// by the three turns immediately preceding it, all of which ran the `tom_d4rt`
// and `tom_d4rt_ast` suites, saw green, and pushed.
//
// WHAT THIS CHECKS, AND WHAT IT DELIBERATELY DOES NOT. Only F-SCC6-4's subject:
// a file present in BOTH corpora whose normalised content differs. Exec's copy
// additionally checks coverage (a reference file with no counterpart at all),
// case counts, markers, guideline parity and the published-interpreter drift.
// Those stay there. This one is the half whose trigger is an edit to a file in
// this tree, which is the half that needs to fire in this tree.
//
// THERE IS ONE BASELINE, NOT TWO. `_divergentBaseline` is declared once, in
// exec's guard, and read here AS DATA — never copied. A second copy of a
// justified-exemption list is a new drift surface of exactly the kind this file
// exists to catch, and it would be the worst possible one: the two lists would
// disagree about which divergences are sanctioned.
//
// READING IT AS DATA IS ALREADY THE HOUSE IDIOM AND IS ALREADY VALIDATED.
// Exec's `_entryComments` parses the same map out of the same file to check
// that every entry carries a reason, and `F-SCC44-2` asserts the parsed key set
// EQUALS `_divergentBaseline.keys`. So the parse this file performs is
// cross-checked against the declaration in the one suite where both the text
// and the const are visible. Keep the pattern below in step with that one.
//
// AN IMPORT WOULD HAVE BEEN CLEANER AND IS WRONG. `import
// '../../tom_d4rt_exec/test/port_recipe.dart'` resolves on the filesystem and
// would give the port table directly — but a cross-package relative import is a
// COMPILE-time dependency, so this whole file would fail to load in a checkout
// without the sibling, where every other repo-wide guard in this package
// degrades to a skip. File I/O degrades; an import does not.
// SCD154 ADDED THE FINGERPRINT HALF. A `_divergentBaseline` entry is keyed by
// PATH, so on its own it exempts its file from ALL future drift — the second
// divergence in an already-listed file is invisible. Exec's guard now pins the
// difference each entry sanctions, and this file checks the same pins, for the
// same reason it checks membership: the edit that widens a divergence is made
// HERE.
//
// The fingerprint ALGORITHM is duplicated rather than read, because there is
// nothing to read it from — it is code, not data, and an import would be the
// compile-time dependency the paragraph above rules out. That duplication is
// self-detecting rather than silent: if the two implementations ever disagree,
// every recorded fingerprint stops matching and this file goes red naming
// recorded-versus-observed for all of them at once. Keep the two copies
// textually identical so the diff is trivial.
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The exec package, as seen from this package's test working directory.
final Directory _execPackage = Directory('../tom_d4rt_exec');

final File _execGuard = File(
  '${_execPackage.path}/test/conformance_drift_test.dart',
);
final File _portRecipe = File('${_execPackage.path}/test/port_recipe.dart');

/// One interpreter import in both spellings, parsed out of `port_recipe.dart`.
///
/// The table is SCD124's single source for what a port is: exec's `_normalise`
/// collapses both spellings to the token, and `tool/remeasure_pins.dart`
/// rewrites one into the other. A third copy here would be the same mistake
/// SCD124 removed, so the entries are read rather than restated.
final RegExp _portPair = RegExp(
  r"PortImport\(\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*\)",
);

/// An entry key in the `_divergentBaseline` map, matched the way exec's
/// `_entryComments` matches it — including the OPTIONAL value tail. The
/// formatter puts a long value on its own line, and a pattern that insisted on
/// finding it beside the key would silently skip exactly those entries.
final RegExp _baselineEntry = RegExp(
  r"^\s*'([^']+)'\s*:\s*(?:_Divergence\.\w+,)?\s*$",
);

List<(String, String, String)> _portImports() => [
  for (final m in _portPair.allMatches(_portRecipe.readAsStringSync()))
    (m.group(1)!, m.group(2)!, m.group(3)!),
];

Set<String> _divergentBaselineKeys() {
  final keys = <String>{};
  var inMap = false;
  for (final line in _execGuard.readAsLinesSync()) {
    if (!inMap) {
      inMap = line.startsWith(
        'const Map<String, _Divergence> _divergentBaseline = {',
      );
      continue;
    }
    if (line.startsWith('};')) break;
    if (_baselineEntry.firstMatch(line) case final m?) keys.add(m.group(1)!);
  }
  return keys;
}

/// An entry in the `_divergenceFingerprints` map: `'path': 'hex',`.
final RegExp _fingerprintEntry = RegExp(
  r"^\s*'([^']+)'\s*:\s*'([0-9a-f]+)',\s*$",
);

Map<String, String> _divergenceFingerprints() {
  final out = <String, String>{};
  var inMap = false;
  for (final line in _execGuard.readAsLinesSync()) {
    if (!inMap) {
      inMap = line.startsWith(
        'const Map<String, String> _divergenceFingerprints = <String, String>{',
      );
      continue;
    }
    if (line.startsWith('};')) break;
    if (_fingerprintEntry.firstMatch(line) case final m?) {
      out[m.group(1)!] = m.group(2)!;
    }
  }
  return out;
}

/// The fingerprint of one divergent pair. Kept textually identical to
/// `_divergenceFingerprint` in exec's guard — see the note at the top.
String _fingerprint(
  String refSource,
  String execSource,
  List<(String, String, String)> imports,
) {
  final ref = _normalise(refSource, imports).split('\n');
  final exec = _normalise(execSource, imports).split('\n');
  final onlyRef = _linesNotIn(ref, exec)..sort();
  final onlyExec = _linesNotIn(exec, ref)..sort();
  return _fnv1a('${onlyRef.join('\n')}\n@@SIDE@@\n${onlyExec.join('\n')}');
}

/// The lines of [a] that [b] does not also contain, counting duplicates.
List<String> _linesNotIn(List<String> a, List<String> b) {
  final remaining = <String, int>{};
  for (final line in b) {
    remaining[line] = (remaining[line] ?? 0) + 1;
  }
  final out = <String>[];
  for (final line in a) {
    final left = remaining[line] ?? 0;
    if (left > 0) {
      remaining[line] = left - 1;
    } else {
      out.add(line);
    }
  }
  return out;
}

String _fnv1a(String input) {
  var hash = BigInt.parse('cbf29ce484222325', radix: 16);
  final mask = (BigInt.one << 64) - BigInt.one;
  final prime = BigInt.parse('100000001b3', radix: 16);
  for (final unit in utf8.encode(input)) {
    hash = (hash ^ BigInt.from(unit)) * prime & mask;
  }
  return hash.toRadixString(16).padLeft(16, '0');
}

String _normalise(String source, List<(String, String, String)> imports) {
  var result = source;
  for (final (token, reference, exec) in imports) {
    result = result.replaceAll(reference, token).replaceAll(exec, token);
  }
  return result;
}

/// Every `.dart` file under [root], keyed by its path relative to [root].
Map<String, File> _filesUnder(Directory root) {
  final files = <String, File>{};
  if (!root.existsSync()) return files;
  final prefix = '${root.path}/';
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    files[entity.path.substring(prefix.length)] = entity;
  }
  return files;
}

/// SCE186. The three registers in exec's guard that account for a reference
/// test with no same-path port, by the line that opens each. Read as data for
/// the reason [_divergentBaselineKeys] is: one declaration, never a copy.
/// Exec's `F-SCE186-3` asserts that this parse, applied to its own file,
/// yields exactly the keys of the consts it declares.
const List<String> _coverageRegisters = [
  'const Map<String, _Coverage> _coveredElsewhere = {',
  'const Map<String, _CaseCounts> _uncoveredBaseline = {',
  'const _anchoredBaseline = <String>{',
];

/// A key of one of [_coverageRegisters]: a two-space-indented string literal
/// followed by `:` (a map entry) or `,` (a set element). Deeper indentation is
/// a value's contents, not a key.
final RegExp _registerKey = RegExp(r"^  '([^']+)'\s*[:,]");

/// The keys of the register opened by [declaration], or null when the line is
/// not found — reported, not read as an empty register.
Set<String>? _registerKeys(List<String> guardLines, String declaration) {
  final start = guardLines.indexOf(declaration);
  if (start < 0) return null;
  final keys = <String>{};
  for (final line in guardLines.skip(start + 1)) {
    if (line.startsWith('};')) break;
    if (_registerKey.firstMatch(line) case final m?) keys.add(m.group(1)!);
  }
  return keys;
}

/// Every `*_test.dart` under [root], keyed by its `/`-separated path relative
/// to [root] — exec's `_testFiles`, which is how F-SCC6-2 keys its census.
Set<String> _testPathsUnder(Directory root) {
  if (!root.existsSync()) return {};
  final prefix = '${root.path}${Platform.pathSeparator}';
  return {
    for (final entity in root.listSync(recursive: true))
      if (entity is File && entity.path.endsWith('_test.dart'))
        entity.path
            .substring(prefix.length)
            .replaceAll(Platform.pathSeparator, '/'),
  };
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt',
    subject: "this tree's test corpus and its exec ports",
  );

  final skip = _execPackage.existsSync() && _execGuard.existsSync()
      ? null
      : 'needs the sibling checkout ../tom_d4rt_exec; this guard is about the '
            'repo, not the package, and cannot run from a published tom_d4rt '
            'on its own';

  group('SCD153: the reference corpus still matches its exec ports', () {
    late List<(String, String, String)> imports;
    late Set<String> baseline;
    late Set<String> divergent;
    late Map<String, File> ref;
    late Map<String, File> exec;

    setUp(() {
      if (skip != null) return;
      imports = _portImports();
      baseline = _divergentBaselineKeys();
      ref = _filesUnder(Directory('test'));
      exec = _filesUnder(Directory('${_execPackage.path}/test'));
      divergent = {
        for (final path in ref.keys.where(exec.containsKey))
          if (_normalise(ref[path]!.readAsStringSync(), imports) !=
              _normalise(exec[path]!.readAsStringSync(), imports))
            path,
      };
    });

    test('F-SCD153-1: no file in this tree has started asserting something its '
        'exec port does not [2026-09-15]', () {
      final appeared = divergent.difference(baseline);
      expect(
        appeared,
        isEmpty,
        reason:
            'A test in THIS tree now differs from its `tom_d4rt_exec` port, '
            'and the difference is not sanctioned. The name is on both sides '
            'and both suites are green, so nothing else will notice.\n\n'
            'Either mirror the change down — copy this file over the exec one '
            'and rewrite only its interpreter imports, which is what a port is '
            '— or, if the exec copy must keep asserting the old thing because '
            'the interpreter it resolves has not shipped the fix yet (DGUC6), '
            'record it in `_divergentBaseline` in '
            '`tom_d4rt_exec/test/conformance_drift_test.dart` with the reason '
            'above the entry.\n\n'
            'Run `dart test test/conformance_drift_test.dart` in '
            '`tom_d4rt_exec` for the full comparison — coverage, case counts '
            'and marker parity are checked only there.\n${appeared.join('\n')}',
      );
    }, skip: skip);

    test('F-SCD153-2: no sanctioned divergence has quietly converged '
        '[2026-09-15]', () {
      final converged = baseline.difference(divergent);
      expect(
        converged,
        isEmpty,
        reason:
            'These files are listed in `_divergentBaseline` but no longer '
            'differ. Remove the entries: an entry absorbs every future drift '
            'in its file for as long as it stands, so a stale one is an '
            'exemption nobody decided to grant.\n${converged.join('\n')}',
      );
    }, skip: skip);

    test(
      'F-SCD153-4: a sanctioned divergence has not widened [2026-09-15]',
      () {
        // SCD154's half, checked here for SCD153's reason. Membership is by path,
        // so F-SCD153-1 stops looking at a file the moment it is listed — and the
        // edit that adds a SECOND, unrelated divergence to a listed file is made
        // in this tree, by somebody who has no reason to open exec's suite.
        final recorded = _divergenceFingerprints();
        expect(
          recorded.keys.toSet(),
          equals(baseline),
          reason:
              'Every `_divergentBaseline` entry needs a `_divergenceFingerprints` '
              'entry and vice versa. Exec\'s own F-SCC6-4 asserts this too; if '
              'it is failing there as well, fix it there — a path in one map and '
              'not the other is an exemption with no recorded shape, and the '
              'check below silently skips it.',
        );

        final widened = <String>[];
        for (final path in baseline.intersection(divergent)) {
          final observed = _fingerprint(
            ref[path]!.readAsStringSync(),
            exec[path]!.readAsStringSync(),
            imports,
          );
          if (observed != recorded[path]) {
            widened.add(
              '$path\n      recorded: ${recorded[path]}\n'
              '      observed: $observed',
            );
          }
        }
        expect(
          widened,
          isEmpty,
          reason:
              'This file still diverges from its exec port, but NOT in the way '
              'its `_divergentBaseline` entry sanctions — something else changed '
              'on one side only. The entry was a statement about ONE difference; '
              'it is not a licence for the next one.\n\n'
              'READ THE NEW DIFFERENCE BEFORE TOUCHING THE FINGERPRINT. Diff the '
              'pair and decide: a missed mirror (fix it, and the fingerprint goes '
              'back by itself) or a second sanctioned difference (extend the '
              'comment above the entry in '
              '`tom_d4rt_exec/test/conformance_drift_test.dart`, THEN paste the '
              'observed value). Pasting first turns the entry back into the '
              'blanket SCD154 replaced.\n\n'
              'If EVERY entry is listed below, suspect the fingerprint algorithm '
              'instead: this file carries a copy of exec\'s, and the two are '
              'meant to stay textually identical.\n${widened.join('\n')}',
        );
      },
      skip: skip,
    );

    test('F-SCD153-3 (control): the two sources parsed as data were read '
        '[2026-09-15]', () {
      // Both inputs come from another package's source text, so a formatting
      // change there degrades this guard silently rather than loudly: an empty
      // port table normalises nothing and reports every ported file as
      // divergent (loud, fine), but an empty BASELINE makes F-SCD153-2 pass
      // over nothing while F-SCD153-1 goes red for the wrong reason. Measured
      // 2026-09-15: 6 port pairs, 11 baseline entries.
      expect(
        imports.length,
        greaterThanOrEqualTo(5),
        reason:
            'Parsed ${imports.length} port pairs from port_recipe.dart, where '
            '6 were measured. The `PortImport(...)` formatting has changed and '
            'this guard is no longer normalising the interpreter imports, so '
            'every correctly-ported file now reads as divergent.',
      );
      expect(
        baseline,
        isNotEmpty,
        reason:
            'The `_divergentBaseline` scan found no entries. Exec\'s own '
            'F-SCC44-2 asserts this same parse against the declared map, so '
            'check there first — but until it is fixed, F-SCD153-2 above is '
            'asserting over an empty set.',
      );
      expect(
        divergent,
        isNotEmpty,
        reason:
            'No file in either corpus differs at all, which has not been true '
            'since the corpora were created. The file walk has probably '
            'stopped finding one of the two trees.',
      );
    }, skip: skip);
  });

  group('SCE186: a new reference test is accounted for in exec', () {
    // THE COVERAGE HALF OF SCD153, AND WHY IT HAS TO LIVE HERE. F-SCC6-2 in
    // exec's guard fails when a test in this tree has no counterpart there:
    // not ported under the same path, not paired in `_coveredElsewhere`, not
    // recorded in `_uncoveredBaseline` or `_anchoredBaseline`. It is right,
    // and it runs only when exec's suite runs. Every file it catches is
    // authored HERE, by a turn with no reason to open exec — which is how 40
    // unaccounted files accumulated before SCE186 was filed, and how SCE107
    // later found five more that four consecutive turns had each reported
    // green on this package's gate.
    //
    // So this asks F-SCC6-2's question at the moment the obligation comes
    // due, from the same registers, read as data. It is deliberately the
    // ACCOUNTING question only: whether an entry is right — a pairing that was
    // really read, a baseline reason that is true, counts that match — stays
    // in exec, which is the one suite that can see both trees' contents and
    // the consts at once.
    late List<String> guardLines;
    late Set<String> ref;
    late Set<String> ported;
    late Map<String, Set<String>?> registers;

    setUp(() {
      if (skip != null) return;
      guardLines = _execGuard.readAsLinesSync();
      ref = _testPathsUnder(Directory('test'));
      final exec = _testPathsUnder(Directory('${_execPackage.path}/test'));
      ported = ref.intersection(exec);
      registers = {
        for (final d in _coverageRegisters) d: _registerKeys(guardLines, d),
      };
    });

    test('F-SCE186-1: every test in this tree is ported to exec or recorded '
        'in one of its coverage registers [2026-09-25]', () {
      final recorded = {for (final keys in registers.values) ...?keys};
      final unaccounted = ref.difference(ported).difference(recorded).toList()
        ..sort();
      expect(
        unaccounted,
        isEmpty,
        reason:
            'These tests have no counterpart in tom_d4rt_exec and are not '
            'recorded there, so exec\'s F-SCC6-2 is red for them already — it '
            'just has not been run. Open ../tom_d4rt_exec/test/'
            'conformance_drift_test.dart and make ONE deliberate edit per file:\n'
            '  * port it, verbatim but for the interpreter import;\n'
            '  * record its twin in _coveredElsewhere, having read both files;\n'
            '  * or record in _uncoveredBaseline why it cannot be ported — a '
            'repo-wide guard that calls requirePackage(\'tom_d4rt\') goes in '
            '_anchoredBaseline instead.\n'
            'Then run `dart test test/conformance_drift_test.dart` there.\n'
            '${unaccounted.join('\n')}',
      );
    }, skip: skip);

    test('F-SCE186-2 (control): the registers parsed and the census reached '
        'both trees [2026-09-25]', () {
      // A register whose opening line moved parses as null, and an empty
      // parse accounts for nothing — both would turn F-SCE186-1 red for every
      // unported file rather than hide one, but only this names the cause.
      // Measured 2026-09-25: 64 / 49 / 28 register keys; 343 tests in this
      // tree, 203 of them ported under the same path.
      final missing = [
        for (final e in registers.entries)
          if (e.value == null) e.key,
      ];
      expect(
        missing,
        isEmpty,
        reason:
            'These register declarations were not found in exec\'s guard. If '
            'one was renamed or retyped, update _coverageRegisters here — and '
            'exec\'s F-SCE186-3, which checks the same parse against the '
            'consts.',
      );
      expect(
        registers.values.map((k) => k!.length),
        everyElement(greaterThanOrEqualTo(20)),
      );
      expect(ref.length, greaterThanOrEqualTo(300));
      expect(ported.length, greaterThanOrEqualTo(150));
    }, skip: skip);
  });
}
