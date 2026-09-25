// REPO-WIDE GUARD (tom_d4rt_ast) — the reader still loads the bundles already shipped.
//
// Its subject is an artefact in ANOTHER package (`tom_d4rt_flutter_ast_test`'s
// committed demo assets), so it runs only when tom_d4rt_ast's suite runs. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE15 added an optional `generator` key to the bundle format and deliberately
// did NOT bump `AstBundleFormat.version`, on the grounds that the change is
// backwards compatible. `sce15_bundle_provenance_test.dart` argues that with a
// synthetic fixture — a freshly written bundle with the key stripped. This file
// argues it with the real thing: the 33 bundles the analyzer-free demo app
// actually ships, built in June by a generator that had never heard of the key.
//
// The synthetic fixture and this one are not redundant. The fixture is faithful
// to the shape but is produced by the same writer being tested, so it can only
// ever agree with itself. These files were produced by a tool that no longer
// exists in this tree, which is the only way to test a promise about the past.
//
// It skips rather than fails when the sibling package is absent (a partial
// checkout), because its absence says nothing about the reader.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import '../sibling_trees.dart';

/// The demo app's committed bundle assets.
final _assets = Directory('../tom_d4rt_flutter_ast_test/assets/bundles');

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_ast',
    subject: 'the reader still loads the bundles already shipped',
  );

  group('SCE15: bundles shipped before the generator key still load', () {
    test(
      'F-SCE15-7: every shipped bundle loads, with generator null '
      '[2026-09-18]',
      () {
        // `index.json` is the catalogue the app reads to list the demos
        // (`generated` + `bundles`), not a bundle. Excluded by name because
        // including it produced the one confusing failure while writing this.
        final bundles =
            _assets
                .listSync()
                .whereType<File>()
                .where(
                  (f) =>
                      f.path.endsWith('.json') &&
                      !f.path.endsWith('index.json'),
                )
                .toList()
              ..sort((a, b) => a.path.compareTo(b.path));

        // Anti-vacuity: an empty directory would make every expectation below
        // pass by never running.
        expect(
          bundles.length,
          greaterThanOrEqualTo(30),
          reason:
              'expected the demo app\'s shipped bundle set (33 when this was '
              'written); found ${bundles.length}. If the demo genuinely shrank, '
              'lower this floor deliberately — do not delete it, or the test '
              'starts passing by finding nothing.',
        );

        for (final file in bundles) {
          final name = file.uri.pathSegments.last;
          final json =
              jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

          // These predate the key. If one ever carries it, this file has stopped
          // testing what it claims to and the fixture needs replacing with an
          // older artefact.
          expect(
            json.containsKey(AstBundleFormat.keyGenerator),
            isFalse,
            reason:
                '$name already carries a generator key, so it is no longer a '
                'pre-change artefact and cannot witness the compatibility claim',
          );

          final bundle = AstBundle.fromJson(json);
          expect(
            bundle.generator,
            isNull,
            reason: '$name: absent provenance must read as null',
          );
          expect(
            bundle.moduleCount,
            greaterThan(0),
            reason: '$name: loaded but empty, so nothing was really parsed',
          );
          expect(bundle.modules.containsKey(bundle.entryPointUri), isTrue);
        }
      },
      skip: _assets.existsSync()
          ? null
          : 'tom_d4rt_flutter_ast_test is not checked out beside this package, '
                'so its shipped bundles cannot be read. Its absence says '
                'nothing about the reader, so this skips rather than fails.',
    );
  });
}
