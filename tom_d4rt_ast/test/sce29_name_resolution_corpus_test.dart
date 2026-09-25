// REPO-WIDE GUARD (tom_d4rt_ast) — every interpreter release that changes name
// resolution is matched by a recorded corpus run, or is explicitly deferred.
//
// The quest rule (scd5_aicv) is that a name-resolution change — Environment
// lookup, bridge registration and the ambiguity rule, import/export merging,
// prefixes, qualifier aliases, shadowing, the runner's warm-parent baseline —
// gets a base-corpus run of both Flutter twins after publishing, recorded
// under `Verification runs` in `tom_d4rt_flutter_ast/doc/interpreter_issues.md`.
//
// A rule nothing checks is the comment tcca19 shipped through: that commit
// stated an invariant and no test held it, and the regression it caused (17
// base scripts, every unit test green) was found by a corpus run that happened
// for another reason. The scd4_aicv publish then had to defer its own run and
// only a todo remembered it.
//
// A corpus run needs a GUI and half an hour, so it cannot be the thing CI
// checks. The RECORD can be. This guard reads:
//
//   * both interpreter CHANGELOGs, for sections marked `Name resolution: yes`;
//   * the `Verification runs` section, for the versions each run measured.
//
// and fails when a marked release has no run covering it and no deferral.
//
// The run is owed from the moment the change lands, not from the moment it
// publishes: an owed run stays owed, which is why an unpublished release is
// deferred with a reason rather than silently exempt.

import 'dart:io';

import 'package:test/test.dart';

/// Packages whose presence identifies the repo root.
const _repoPackages = ['tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_flutter_ast'];

Directory? _repoRoot() {
  var dir = Directory.current.absolute;
  for (var i = 0; i < 6; i++) {
    if (_repoPackages.every((p) => Directory('${dir.path}/$p').existsSync())) {
      return dir;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

/// The marker a name-resolution release carries, directly under its heading.
const _marker = 'Name resolution: yes';

/// Releases that are marked but cannot yet be certified, each with the reason.
///
/// An entry here is a debt, not an exemption: it says a corpus run is owed and
/// names what is preventing it. Delete the entry and record the run when the
/// blocker lifts — the guard then holds the release to the same standard as
/// every other.
const Map<String, String> _deferred = {
  // sce162 blocks publishing tom_d4rt / tom_d4rt_ast, and the twins resolve
  // the interpreter from pub.dev (DGUC6), so no corpus run can measure these
  // until they ship. Newest published when these were deferred: 1.77.0 / 0.65.0.
  '1.108.0': 'unpublished — sce162 publish block (scd132 prefix fallback)',
  '0.95.0': 'unpublished — sce162 publish block (scd132 prefix fallback)',
  '1.125.0': 'unpublished — sce162 publish block (scd194 enum displacement)',
  '0.111.0': 'unpublished — sce162 publish block (scd194 enum displacement)',
  '1.136.0': 'unpublished — sce162 publish block (sce25 same-name enums)',
  '0.121.0': 'unpublished — sce162 publish block (sce25 same-name enums)',
  '1.137.0': 'unpublished — sce162 publish block (sce25 narrowed retrieval)',
  '0.122.0': 'unpublished — sce162 publish block (sce25 narrowed retrieval)',
  // The release that CLOSES sce162's last base-corpus regression, and so the
  // one the publish is waiting on. It cannot be certified by a corpus run
  // before it ships, for exactly the reason it is deferred here — but it is the
  // least blind entry in this map: the defect it fixes was measured absent at
  // the published pair and present at the tree, and both twins' base corpus was
  // run at the tree through SCD66's pre-publish path resolution before the
  // version was written. See sce162's entry for those numbers.
  '1.180.0': 'unpublished — sce162 publish block (scf26 suffix-match ordering)',
  '0.163.0': 'unpublished — sce162 publish block (scf26 suffix-match ordering)',
  // Found and fixed by sce160's pre-publish pass, and published by it. The
  // post-publish full corpus run that sce160 records covers it; delete these
  // two with the rest of this map when that run is written.
  '1.182.0':
      'unpublished — sce160 publish in progress (StreamTransformer nativeNames)',
  '0.166.0':
      'unpublished — sce160 publish in progress (StreamTransformer nativeNames)',
  '1.183.0':
      'unpublished — sce160 publish in progress (sce177 nativeNames prune)',
  '0.167.0':
      'unpublished — sce160 publish in progress (sce177 nativeNames prune)',
  '1.184.0':
      'unpublished — sce160 publish in progress (sce178 Stream overrides)',
  '0.168.0':
      'unpublished — sce160 publish in progress (sce178 Stream overrides)',
};

List<int> _key(String v) => v.split('.').map(int.parse).toList();

int _compare(String a, String b) {
  final ka = _key(a), kb = _key(b);
  for (var i = 0; i < 3; i++) {
    final c = ka[i].compareTo(kb[i]);
    if (c != 0) return c;
  }
  return 0;
}

/// Versions in [changelog] whose section carries [_marker].
List<String> markedReleases(String changelog) {
  final out = <String>[];
  final lines = changelog.split('\n');
  for (var i = 0; i < lines.length; i++) {
    final m = RegExp(r'^## (\d+\.\d+\.\d+)$').firstMatch(lines[i]);
    if (m == null) continue;
    // The marker sits inside this section, before the next `## ` heading.
    for (var j = i + 1; j < lines.length; j++) {
      if (lines[j].startsWith('## ')) break;
      if (lines[j].contains(_marker)) {
        out.add(m.group(1)!);
        break;
      }
    }
  }
  return out;
}

const _verRe = r'(\d+\.\d+\.\d+)';

/// The newest version of each interpreter that any recorded run measured.
///
/// Read only from places that state what a run RESOLVED: the entry heading,
/// the `Resolved interpreter versions` table, and the `Resolved versions:`
/// prose. Scanning whole entry bodies does not work — the 2026-09-14 entry
/// names the working tree's 1.105.0 / 0.92.0 while reporting a run at 1.77.0 /
/// 0.65.0, and reading that as coverage would certify a version nobody ran.
({String? source, String? ast}) certifiedVersions(String doc) {
  final lines = doc.split('\n');
  final start = lines.indexWhere((l) => l.startsWith('## Verification runs'));
  if (start < 0) return (source: null, ast: null);
  var end = lines.length;
  for (var i = start + 1; i < lines.length; i++) {
    if (lines[i].startsWith('## ')) {
      end = i;
      break;
    }
  }
  final section = lines.sublist(start, end);
  final entryStarts = <int>[];
  for (var i = 0; i < section.length; i++) {
    if (section[i].startsWith('### ')) entryStarts.add(i);
  }

  String? bestSource, bestAst;
  void offer(String? v, bool isAst) {
    if (v == null) return;
    if (isAst) {
      if (bestAst == null || _compare(v, bestAst!) > 0) bestAst = v;
    } else {
      if (bestSource == null || _compare(v, bestSource!) > 0) bestSource = v;
    }
  }

  for (var n = 0; n < entryStarts.length; n++) {
    final from = entryStarts[n];
    final to = n + 1 < entryStarts.length ? entryStarts[n + 1] : section.length;
    final entry = section.sublist(from, to);

    void scanInline(String text) {
      for (final m in RegExp('tom_d4rt_ast\\s+$_verRe').allMatches(text)) {
        offer(m.group(1), true);
      }
      for (final m in RegExp('tom_d4rt(?!_)\\s+$_verRe').allMatches(text)) {
        offer(m.group(1), false);
      }
    }

    scanInline(entry.first);

    for (var i = 0; i < entry.length; i++) {
      final line = entry[i];
      if (line.startsWith('|') &&
          line.contains('Package') &&
          line.contains('tom_d4rt_ast')) {
        final cols = line
            .split('|')
            .map((c) => c.trim().replaceAll('`', ''))
            .toList();
        final ciSource = cols.indexOf('tom_d4rt');
        final ciAst = cols.indexOf('tom_d4rt_ast');
        for (var r = i + 1; r < entry.length; r++) {
          if (!entry[r].startsWith('|')) break;
          final cells = entry[r].split('|').map((c) => c.trim()).toList();
          if (ciSource >= 0 && ciSource < cells.length) {
            offer(RegExp(_verRe).firstMatch(cells[ciSource])?.group(1), false);
          }
          if (ciAst >= 0 && ciAst < cells.length) {
            offer(RegExp(_verRe).firstMatch(cells[ciAst])?.group(1), true);
          }
        }
        break;
      }
    }

    for (var i = 0; i < entry.length; i++) {
      if (entry[i].contains('Resolved versions')) {
        scanInline(entry.sublist(i, (i + 4).clamp(0, entry.length)).join('\n'));
      }
    }
  }

  return (source: bestSource, ast: bestAst);
}

void main() {
  final root = _repoRoot();

  group('SCE29: a name-resolution release is matched by a corpus run', () {
    late String sourceChangelog;
    late String astChangelog;
    late String issues;

    setUpAll(() {
      if (root == null) return;
      sourceChangelog = File(
        '${root.path}/tom_d4rt/CHANGELOG.md',
      ).readAsStringSync();
      astChangelog = File(
        '${root.path}/tom_d4rt_ast/CHANGELOG.md',
      ).readAsStringSync();
      issues = File(
        '${root.path}/tom_d4rt_flutter_ast/doc/interpreter_issues.md',
      ).readAsStringSync();
    });

    test('F-SCE29-1: the guard can see the repo it checks [2026-09-18]', () {
      expect(
        root,
        isNotNull,
        reason:
            'the guard reads tom_d4rt, tom_d4rt_ast and tom_d4rt_flutter_ast; '
            'without the repo root every assertion below holds vacuously',
      );
    });

    test('F-SCE29-2: both CHANGELOGs carry the marker on releases that changed '
        'name resolution [2026-09-18]', () {
      if (root == null) return;
      final source = markedReleases(sourceChangelog);
      final ast = markedReleases(astChangelog);

      // Anti-vacuity: a parser that finds nothing would make F-SCE29-4 pass
      // for the wrong reason, which is exactly how this rule failed before.
      expect(
        source,
        isNotEmpty,
        reason: 'tom_d4rt has name-resolution releases; none is marked',
      );
      expect(ast, isNotEmpty, reason: 'same for tom_d4rt_ast');

      // The two trees are mirrors, so a marked change lands in both.
      expect(
        source.length,
        ast.length,
        reason:
            'a name-resolution change is mirrored, so each marked tom_d4rt '
            'release has a tom_d4rt_ast counterpart:\n'
            '  tom_d4rt:     $source\n'
            '  tom_d4rt_ast: $ast',
      );
    });

    test('F-SCE29-3: the recorded runs report the versions they measured '
        '[2026-09-18]', () {
      if (root == null) return;
      final certified = certifiedVersions(issues);
      expect(
        certified.source,
        isNotNull,
        reason: 'no run records a tom_d4rt version; the parse found nothing',
      );
      expect(certified.ast, isNotNull, reason: 'same for tom_d4rt_ast');
    });

    test(
      'F-SCE29-4: every marked release is covered by a run or deferred with a '
      'reason [2026-09-18]',
      () {
        if (root == null) return;
        final certified = certifiedVersions(issues);
        final owed = <String>[];

        void check(List<String> marked, String? best, String package) {
          for (final v in marked) {
            if (best != null && _compare(best, v) >= 0) continue;
            if (_deferred.containsKey(v)) continue;
            owed.add(
              '$package $v — no Verification runs entry measured it '
              '(newest measured: ${best ?? "none"}), and it is not deferred',
            );
          }
        }

        check(markedReleases(sourceChangelog), certified.source, 'tom_d4rt');
        check(markedReleases(astChangelog), certified.ast, 'tom_d4rt_ast');

        expect(
          owed,
          isEmpty,
          reason:
              'These releases changed name resolution and owe a base-corpus '
              'run of both Flutter twins, recorded under `Verification runs` '
              'in tom_d4rt_flutter_ast/doc/interpreter_issues.md.\n\n'
              '${owed.join('\n')}\n\n'
              'If the run cannot be made yet — the usual reason is that the '
              'release is not published and the twins resolve from pub.dev '
              '(DGUC6) — add the version to `_deferred` with that reason. '
              'A deferral records a debt; it does not discharge it.',
        );
      },
    );

    test('F-SCE29-5: a marked release with no run and no deferral is detected '
        '[2026-09-18]', () {
      // Ablation in-test: the check above passes because the record is
      // complete, which is indistinguishable from a check that cannot fail.
      // Run the same logic over a synthetic changelog one release ahead of
      // anything measured, and it must be reported.
      const synthetic = '## 9.9.9\n\n$_marker\n\n### Fixed — something\n';
      final marked = markedReleases(synthetic);
      expect(marked, ['9.9.9']);

      const best = '1.77.0';
      expect(
        _compare(best, marked.single) >= 0,
        isFalse,
        reason: 'a release newer than anything measured is not covered',
      );
      expect(
        _deferred.containsKey(marked.single),
        isFalse,
        reason: 'and it is not deferred, so it would be reported as owed',
      );
    });

    test('F-SCE29-6: coverage is read only from what a run resolved, not from '
        'versions it mentions in passing [2026-09-18]', () {
      // The 2026-09-14 entry names the working tree's version while
      // reporting a run at an older one. Reading the body would certify a
      // version nobody ran, which is worse than no guard.
      const entry = '''
## Verification runs

### 2026-09-14 — BOTH twins at tom_d4rt 1.77.0 / tom_d4rt_ast 0.65.0: neutral

Note: the tree is at tom_d4rt 1.105.0 / tom_d4rt_ast 0.92.0 against a resolved
1.77.0 / 0.65.0.
''';
      final certified = certifiedVersions(entry);
      expect(certified.source, '1.77.0');
      expect(certified.ast, '0.65.0');
    });

    test('F-SCE29-7: every deferral names a reason [2026-09-18]', () {
      for (final entry in _deferred.entries) {
        expect(
          entry.value.trim(),
          isNotEmpty,
          reason: '${entry.key} is deferred with no reason given',
        );
        expect(
          entry.value.length,
          greaterThan(15),
          reason:
              '${entry.key}: "${entry.value}" does not say what is blocking '
              'the run',
        );
      }
    });
  });
}
