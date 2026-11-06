// REPO-WIDE GUARD (tom_d4rt_ast) — the bundles the demo app ships are current.
//
// Its subject is an artefact in ANOTHER package (`tom_d4rt_flutter_ast_test`'s
// committed demo assets), so it runs only when tom_d4rt_ast's suite runs. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// What it asks changed with VSTDM3. SCE15 wrote it to witness a promise about
// the past: the demo app's June bundles, built before the optional `generator`
// key existed, still loaded. Format 2.0 (analyzer 14's AST, tom_ast_model 0.3)
// withdrew that promise by decision — no reader for older bundles, because
// bundles come from a toolchain whose versions match the app's — and the demo
// assets were regenerated. So the guard now asks what a shipped bundle owes
// the app today: it is in the reader's format, it loads, and it names the
// generator that wrote it, so a bundle that misbehaves on device can say which
// toolchain to look at.
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
    subject: 'the bundles the demo app ships are current',
  );

  group('SCE15: the bundles the demo app ships are current', () {
    test(
      'F-SCE15-7: every shipped bundle is in the reader\'s format, loads, and '
      'names its generator [2026-11-06]',
      () {
        // `index.json` is the catalogue the app reads to list the demos
        // (`generated` + `bundles`), not a bundle.
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
          expect(
            json[AstBundleFormat.keyVersion],
            AstBundleFormat.version,
            reason:
                '$name is not in the reader\'s format; regenerate the demo '
                'assets (tom_d4rt_flutter_ast_test: flutter test '
                'tool/compile_samples_to_bundles.dart)',
          );
          final bundle = AstBundle.fromJson(json);
          expect(
            bundle.generator,
            isNotNull,
            reason: '$name: a shipped bundle names the generator that wrote it',
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
