// REPO-WIDE GUARD (tom_d4rt) — the four registers of mirror divergence agree about which shared files diverge.
//
// Its subject reaches OUTSIDE this package (tom_d4rt_ast's
// `tool/check_mirrored_sources.dart`), so it runs only when tom_d4rt's suite
// runs. SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE252 — four registers record which mirrored files diverge, at four
// granularities, and until now nothing kept them consistent:
//
//   | Register                  | Where                                            | Reads           |
//   | ------------------------- | ------------------------------------------------ | --------------- |
//   | `kDivergentMirrors`       | tom_d4rt_ast/tool/check_mirrored_sources.dart    | raw code lines  |
//   | `_allowed`                | tom_d4rt/test/scd49_stdlib_twin_sync_test.dart   | stdlib tokens   |
//   | `_allowedRegions`, `_structural` | tom_d4rt/test/scd183_mirror_source_sync_test.dart | tokens, `SFoo`→`Foo` |
//   | `_divergentBodies`        | tom_d4rt/test/scd199_mirror_body_agreement_test.dart | member bodies |
//
// Each has its own stale check and each works. What was missing is any
// assertion that they AGREE. `environment.dart` carried a file-level reason
// saying the reference declares a member this tree lacks — false — while
// SCD183 said, correctly, that both trees have it and the difference was
// ordering, and SCD199 counted 92 of 92 bodies identical. Three records, one
// wrong for eight days, and the wrong one was the file-level entry a reader
// meets first.
//
// NOT A MERGE, deliberately. The four answer different questions, and the
// finer ones are what showed a "file-level divergence" to be a single member.
// This file asserts only what must be true of their KEYS whatever the reasons
// say:
//
//   1. The stdlib half of the file-level register is exactly SCD49's register.
//      Both read code with comments and directives stripped; a stdlib file one
//      calls divergent and the other does not is a defect in one of them.
//   2. Every file SCD183 exempts is in the file-level register.
//   3. And the converse: every non-stdlib file the file-level register lists
//      is one SCD183 exempts. Both now read AFTER normalising `SFoo` to `Foo`
//      (the file-level check since SCE253), so a file one finds divergent and
//      the other identical is a wrong entry — the `environment.dart` case,
//      whose file-level reason SCD183 had disproved. Before SCE253 this was a
//      declared rename-only exception set, because the file-level check read
//      raw code; normalising there removed its only member and the need for it.
//   4. Every file SCD199 lists a divergent body for is one SCD183 exempts. A
//      body that disagrees under the same normalisation is a file that does.
//
// SEEN TO FAIL, as the todo required: F-SCE252-6 deletes one entry from each
// register in turn and asserts the comparison reports it. It was also seen
// against the real files on 2026-09-29: removing `callable.dart` from SCD183's
// `_structural` fired F-SCE252-4 and F-SCE252-5 — the file-level register and
// the body census both still named it.
library;

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

const _fileLevelPath = '../tom_d4rt_ast/tool/check_mirrored_sources.dart';
const _scd49Path = 'test/scd49_stdlib_twin_sync_test.dart';
const _scd183Path = 'test/scd183_mirror_source_sync_test.dart';
const _scd199Path = 'test/scd199_mirror_body_agreement_test.dart';

/// The top-level keys of the map literal assigned to [name] in [source].
///
/// A small reader rather than an import: three of the four registers are
/// private constants of test files, and the fourth lives in another package's
/// `tool/`. It skips comments and string contents while tracking brace depth,
/// and a key is a string literal at depth 1 followed by `:`.
Set<String> registerKeys(String source, String name) {
  final start = RegExp('\\b${RegExp.escape(name)}\\s*=').firstMatch(source);
  if (start == null) {
    throw StateError('no `$name =` in the source read');
  }
  var i = source.indexOf('{', start.end);
  final keys = <String>{};
  var depth = 0;
  while (i < source.length) {
    final c = source[i];
    if (c == '/' && i + 1 < source.length && source[i + 1] == '/') {
      i = source.indexOf('\n', i);
      if (i < 0) break;
      continue;
    }
    if (c == "'" || c == '"') {
      final end = _endOfString(source, i);
      if (depth == 1) {
        final after = source.substring(end).trimLeft();
        if (after.startsWith(':')) keys.add(source.substring(i + 1, end - 1));
      }
      i = end;
      continue;
    }
    if (c == '{') depth++;
    if (c == '}') {
      depth--;
      if (depth == 0) return keys;
    }
    i++;
  }
  throw StateError('`$name`: unterminated map literal');
}

/// Index just past the string literal opening at [i]. Handles escapes and
/// `${...}` interpolation; registers use no triple-quoted strings.
int _endOfString(String s, int i) {
  final quote = s[i];
  var j = i + 1;
  while (j < s.length) {
    final c = s[j];
    if (c == '\\') {
      j += 2;
      continue;
    }
    if (c == r'$' && j + 1 < s.length && s[j + 1] == '{') {
      var depth = 1;
      j += 2;
      while (j < s.length && depth > 0) {
        if (s[j] == '{') depth++;
        if (s[j] == '}') depth--;
        j++;
      }
      continue;
    }
    if (c == quote) return j + 1;
    j++;
  }
  throw StateError('unterminated string at $i');
}

/// Every way the registers disagree, as readable findings. Empty when they
/// agree. Paths are relative to `lib/src/` (reference) / `lib/src/runtime/`
/// (twin); SCD49's keys are relative to `stdlib/` and are prefixed here.
List<String> registerDisagreements({
  required Set<String> fileLevel,
  required Set<String> stdlibPinned,
  required Set<String> regions,
  required Set<String> structural,
  required Set<String> bodies,
}) {
  final findings = <String>[];
  final stdlib = {for (final k in stdlibPinned) 'stdlib/$k'};
  final fileStdlib = fileLevel.where((k) => k.startsWith('stdlib/')).toSet();
  final fileRest = fileLevel.difference(fileStdlib);
  final scd183 = regions.union(structural);

  for (final f in fileStdlib.difference(stdlib)) {
    findings.add(
      '$f: in kDivergentMirrors but not in SCD49 `_allowed` — one of them is '
      'wrong about whether this stdlib file diverges',
    );
  }
  for (final f in stdlib.difference(fileStdlib)) {
    findings.add(
      '$f: in SCD49 `_allowed` but not in kDivergentMirrors — one of them is '
      'wrong about whether this stdlib file diverges',
    );
  }
  for (final f in scd183.difference(fileRest)) {
    findings.add(
      '$f: SCD183 exempts it, so it differs even after `SFoo`→`Foo`, yet '
      'kDivergentMirrors does not list it',
    );
  }
  for (final f in fileRest.difference(scd183)) {
    findings.add(
      '$f: kDivergentMirrors calls it divergent but SCD183 finds it identical '
      'after the same `SFoo`→`Foo` normalisation. Either the file-level reason '
      'describes a divergence SCD183 has disproved and the entry is wrong, or '
      'the two differ only in layout (line breaks), which SCD183 ignores and '
      'the line-based check does not — reformat the pair',
    );
  }
  for (final f in bodies.difference(scd183)) {
    findings.add(
      '$f: SCD199 lists divergent bodies in it, but SCD183 does not exempt it '
      '— a body that disagrees under the same normalisation is a file that '
      'does',
    );
  }
  findings.sort();
  return findings;
}

void main() {
  requirePackage(
    'tom_d4rt',
    subject:
        'the four mirror-divergence registers in tom_d4rt and tom_d4rt_ast',
  );

  String read(String path) => File(path).readAsStringSync();
  final fileLevel = registerKeys(read(_fileLevelPath), 'kDivergentMirrors');
  final stdlibPinned = registerKeys(read(_scd49Path), '_allowed');
  final regions = registerKeys(read(_scd183Path), '_allowedRegions');
  final structural = registerKeys(read(_scd183Path), '_structural');
  final bodies = registerKeys(read(_scd199Path), '_divergentBodies');

  List<String> disagreements({
    Set<String>? f,
    Set<String>? s,
    Set<String>? r,
    Set<String>? st,
    Set<String>? b,
  }) => registerDisagreements(
    fileLevel: f ?? fileLevel,
    stdlibPinned: s ?? stdlibPinned,
    regions: r ?? regions,
    structural: st ?? structural,
    bodies: b ?? bodies,
  );

  group('SCE252: the mirror-divergence registers agree', () {
    test('F-SCE252-1: every register is read and non-empty '
        '[2026-09-29] (PASS)', () {
      // A reader that silently found nothing would make every other case
      // vacuous. Floors, not counts: the counts move whenever a file is
      // reconciled, which is the point of the registers.
      expect(fileLevel.length, greaterThanOrEqualTo(5));
      expect(stdlibPinned, isNotEmpty);
      expect(structural, isNotEmpty);
      expect(bodies, isNotEmpty);
      expect(fileLevel, contains('interpreter_visitor.dart'));
    });

    test('F-SCE252-2: the stdlib half of kDivergentMirrors is exactly SCD49 '
        '`_allowed` [2026-09-29] (PASS)', () {
      expect(disagreements().where((f) => f.startsWith('stdlib/')), isEmpty);
    });

    test('F-SCE252-3: every file SCD183 exempts is in kDivergentMirrors '
        '[2026-09-29] (PASS)', () {
      expect(
        disagreements().where((f) => f.contains('SCD183 exempts it')),
        isEmpty,
      );
    });

    test('F-SCE252-4: every non-stdlib file kDivergentMirrors lists is one '
        'SCD183 exempts [2026-09-29] (PASS)', () {
      expect(
        disagreements().where((f) => f.contains('SCD183 finds it identical')),
        isEmpty,
      );
    });

    test('F-SCE252-5: every file with a divergent body in SCD199 is exempted '
        'by SCD183 [2026-09-29] (PASS)', () {
      expect(disagreements(), isEmpty, reason: disagreements().join('\n'));
    });

    test('F-SCE252-6: removing one entry from any one register is reported '
        '[2026-09-29] (PASS)', () {
      Set<String> without(Set<String> s) => s.difference({s.first});
      final cases = <String, List<String>>{
        'kDivergentMirrors (stdlib)': disagreements(
          f: fileLevel.difference({
            fileLevel.firstWhere((k) => k.startsWith('stdlib/')),
          }),
        ),
        'kDivergentMirrors (rest)': disagreements(
          f: fileLevel.difference({structural.first}),
        ),
        'SCD49 _allowed': disagreements(s: without(stdlibPinned)),
        'SCD183 _structural': disagreements(st: without(structural)),
        'SCD199 _divergentBodies (added stray)': disagreements(
          b: {...bodies, 'no_such_file.dart'},
        ),
        'kDivergentMirrors (added stray)': disagreements(
          f: {...fileLevel, 'no_such_file.dart'},
        ),
      };
      for (final entry in cases.entries) {
        expect(entry.value, isNotEmpty, reason: '${entry.key} went unnoticed');
      }
    });
  });
}
