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
@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

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

void main() {
  final skip = _execPackage.existsSync() && _execGuard.existsSync()
      ? null
      : 'needs the sibling checkout ../tom_d4rt_exec; this guard is about the '
            'repo, not the package, and cannot run from a published tom_d4rt '
            'on its own';

  group('SCD153: the reference corpus still matches its exec ports', () {
    late List<(String, String, String)> imports;
    late Set<String> baseline;
    late Set<String> divergent;

    setUp(() {
      if (skip != null) return;
      imports = _portImports();
      baseline = _divergentBaselineKeys();
      final ref = _filesUnder(Directory('test'));
      final exec = _filesUnder(Directory('${_execPackage.path}/test'));
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

    test('F-SCD153-3 (control): the two sources parsed as data were read '
        '[2026-09-15]', () {
      // Both inputs come from another package's source text, so a formatting
      // change there degrades this guard silently rather than loudly: an empty
      // port table normalises nothing and reports every ported file as
      // divergent (loud, fine), but an empty BASELINE makes F-SCD153-2 pass
      // over nothing while F-SCD153-1 goes red for the wrong reason. Measured
      // 2026-09-15: 6 port pairs, 17 baseline entries.
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
}
