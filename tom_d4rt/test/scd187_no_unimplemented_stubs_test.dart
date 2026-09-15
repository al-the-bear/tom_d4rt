// REPO-WIDE GUARD (tom_d4rt) — no stdlib adapter in either tree announces itself unimplemented.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD187 — the stub class is empty, and this is what keeps it empty.
//
// WHAT IT IS ABOUT. `HttpClientResponse.transform` threw `transform not yet
// implemented in interpreted environment` under a comment reading
// "Implementation for transform would be complex, placeholder". There was
// nothing to implement: the class is a `Stream<List<int>>` and the `Stream`
// bridge's `transform` already worked. Deleting the local adapter fixed it. The
// stub had been the only thing standing between scripts and the way every Dart
// tutorial reads an HTTP body.
//
// SWEPT AFTER THE DELETION: zero such messages remain, in either tree. The
// class is empty, which is exactly when a ratchet is worth having — it costs
// nothing now and refuses the first re-entry.
//
// WHY THE MESSAGE SHAPE IS THE SUBJECT, not the throw. An adapter that throws
// is often right: `UnsupportedError` is a real SDK contract, and half the
// stdlib raises `RuntimeD4rtException` for genuinely bad arguments. What this
// forbids is narrower and is a claim rather than a behaviour — an adapter
// telling a script that a FEATURE does not exist yet. Three things are wrong
// with that in every instance found so far:
//
//   * it is usually false. This one's inherited implementation was one lookup
//     away, and `HttpServer.transform` — same member, same supertype, no local
//     adapter — had worked the whole time.
//   * it is unbounded. "not yet implemented in interpreted environment" reads
//     as a statement about the interpreter; it was one adapter on one class.
//   * nothing expires it. A `RuntimeD4rtException` looks like every other
//     diagnostic, so a stub survives exactly as long as nobody happens to hit
//     it — this one lasted until somebody wrote a behaviour test for a
//     different member.
//
// If a member genuinely cannot be bridged, the honest forms are already in use
// elsewhere: leave it unregistered and let the unbridged-member diagnostic
// report it, or record it in the audit's `_notAuditable` with a reason. Both
// are visible to the coverage machinery. A stub is visible to nobody.
//
// SEEN TO FAIL: restoring the deleted adapter fires F-SCD187-6 in both trees;
// pointing the twin root at a path that does not exist fires F-SCD187-7.

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The two stdlib trees, relative to this package's root.
const _roots = <String, String>{
  'tom_d4rt': 'lib/src/stdlib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
};

/// Both trees held 126 stdlib files on 2026-09-15. The floor is well below that
/// because its job is to separate "scanned the corpus" from "scanned nothing".
const _minFiles = 100;

/// A message telling a script that a feature is not implemented yet.
///
/// Deliberately narrow. `UnsupportedError` is an SDK contract and is not
/// matched; neither is an ordinary argument diagnostic. What is matched is a
/// claim about the IMPLEMENTATION's completeness, which is the shape that
/// silently becomes false and that nothing else in the repo notices.
final _stubMessage = RegExp(
  r'''not\s+(yet\s+)?(implemented|supported)|'''
  r'''\bplaceholder\b|'''
  r'''\bTODO:\s*implement''',
  caseSensitive: false,
);

/// Lines that name the shape without being one — this guard's own prose, and
/// any future entry that has to quote the message it forbids.
bool _isProse(String line) {
  final trimmed = line.trimLeft();
  return trimmed.startsWith('//') || trimmed.startsWith('///');
}

List<String> _stubSites(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  final hits = <String>[];
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final lines = entity.readAsStringSync().split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (_isProse(lines[i])) continue;
      if (_stubMessage.hasMatch(lines[i])) {
        hits.add('${entity.path}:${i + 1}: ${lines[i].trim()}');
      }
    }
  }
  hits.sort();
  return hits;
}

int _dartFileCount(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) return 0;
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .length;
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it runs
  // in, so a copy anywhere else measures a different tree in silence.
  requirePackage('tom_d4rt', subject: 'both stdlib trees under lib/src/stdlib');

  group('SCD187: no stdlib adapter announces itself unimplemented', () {
    test('F-SCD187-7: the scan reached both trees [2026-09-15] (PASS)', () {
      // Ordered first, and it is the whole reason the case exists: F-SCD187-6
      // is an emptiness assertion over a walk, and a walk that found no files
      // satisfies it. The twin is a sibling checkout; if it is absent this
      // guard cannot make its comparison and must say so rather than pass.
      for (final entry in _roots.entries) {
        expect(
          _dartFileCount(entry.value),
          greaterThanOrEqualTo(_minFiles),
          reason:
              'Found too few files under ${entry.value} (${entry.key}). That '
              'is not a finding about the stdlib — the walk did not run.',
        );
      }
    });

    test('F-SCD187-6: neither tree ships an unimplemented-feature stub '
        '[2026-09-15] (PASS)', () {
      final found = <String>[
        for (final entry in _roots.entries) ..._stubSites(entry.value),
      ];

      expect(
        found,
        isEmpty,
        reason:
            'These stdlib lines tell a script that a feature is not '
            'implemented:\n  ${found.join('\n  ')}\n\n'
            'Before writing one, check whether the member is inherited — the '
            'stub this guard was written for was shadowing a working '
            '`Stream.transform`, and its removal was the entire fix. If the '
            'member really cannot be bridged, leave it UNREGISTERED so the '
            'unbridged-member diagnostic reports it, or record it in the '
            'audit\'s `_notAuditable` with a reason. Both are visible to the '
            'coverage machinery; a stub is visible to nobody.',
      );
    });
  });
}
