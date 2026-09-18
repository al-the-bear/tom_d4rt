// SCE15: a bundle records what produced it, and a bundle without that still loads.
//
// `AstBundleFormat.version` identifies the FORMAT. It says nothing about the
// producer, and for this artefact that gap is worse than it is for a generated
// `*.b.dart`: a bundle is built on a server and shipped to an app that cannot
// re-derive it, so a bundle that fails to interpret on device could not say
// whether it was written by a generator older than the app's AST model. scd4
// closed the same hole one layer up by making every `*.b.dart` name its
// generator; this is the analyzer-free line's equivalent.
//
// WHY THE FORMAT VERSION DOES NOT BUMP. The key is additive and every reader in
// `ast_bundle.dart` takes known keys only, so an older reader ignores it and an
// older bundle still loads. A format stamp bumps for a change that is NOT
// backwards compatible; bumping it here would strand readers for a field they
// are free to ignore. F-SCE15-4 and F-SCE15-5 are the two halves of that claim:
// old bundle into new reader, and the stamp left alone.

import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// The smallest bundle that satisfies the entry-point invariant.
AstBundle _bundle({String? generator}) => AstBundle(
  entryPointUri: 'package:x/main.dart',
  modules: {'package:x/main.dart': SCompilationUnit(offset: 0, length: 0)},
  generator: generator,
);

void main() {
  group('SCE15: bundle provenance', () {
    const stamp = 'tom_ast_generator 0.1.6';

    test('F-SCE15-1: generator survives the JSON round trip [2026-09-18]', () {
      final json = _bundle(generator: stamp).toJson();
      expect(
        json[AstBundleFormat.keyGenerator],
        equals(stamp),
        reason: 'the key is not written into the JSON map',
      );
      expect(AstBundle.fromJson(json).generator, equals(stamp));
    });

    test(
      'F-SCE15-2: generator survives the gzip byte round trip [2026-09-18]',
      () {
        // The bytes path is what a download uses, so it has to carry provenance
        // too — a bundle is diagnosed in whichever form it arrived in.
        final restored = AstBundle.fromBytes(
          _bundle(generator: stamp).toBytes(),
        );
        expect(restored.generator, equals(stamp));
      },
    );

    test('F-SCE15-3: generator survives the ZIP manifest round trip '
        '[2026-09-18]', () {
      final zipped = _bundle(generator: stamp).toZip();
      final restored = AstBundle.fromZip(zipped);
      expect(
        restored.generator,
        equals(stamp),
        reason:
            'the ZIP path carries provenance in the manifest, and fromZip must '
            'propagate it back onto the bundle',
      );

      // And it is really in the manifest, readable without reconstructing the
      // whole bundle — which is the cheap thing a diagnosis wants to do.
      final manifest = AstBundleManifest.fromJson(
        jsonDecode(utf8.decode(rawManifestBytes(zipped)))
            as Map<String, dynamic>,
      );
      expect(manifest.generator, equals(stamp));
    });

    test(
      'F-SCE15-4: a bundle with no generator key still loads [2026-09-18]',
      () {
        // The pre-change artefact: exactly what a bundle written before this
        // existed looks like. Built by stripping the key rather than by
        // constructing one without it, so the test cannot pass just because the
        // writer happens to omit it.
        final json = _bundle(generator: stamp).toJson()
          ..remove(AstBundleFormat.keyGenerator);
        expect(json.containsKey(AstBundleFormat.keyGenerator), isFalse);

        final restored = AstBundle.fromJson(json);
        expect(
          restored.generator,
          isNull,
          reason: 'absent provenance must read as null, not fail',
        );
        expect(restored.entryPointUri, equals('package:x/main.dart'));
        expect(restored.moduleCount, equals(1));

        // Same for the manifest, whose fromJson validates its required keys and
        // must not have started requiring this one.
        final manifestJson = <String, dynamic>{
          AstBundleFormat.keyVersion: AstBundleFormat.version,
          AstBundleFormat.keyEntryPoint: 'package:x/main.dart',
          AstBundleFormat.keyFiles: {'0.ast.json': 'package:x/main.dart'},
        };
        expect(AstBundleManifest.fromJson(manifestJson).generator, isNull);
      },
    );

    test('F-SCE15-5: the format version did not bump for an additive key '
        '[2026-09-18]', () {
      expect(
        AstBundleFormat.version,
        equals('1.0'),
        reason:
            'Adding an optional key is backwards compatible: old readers ignore '
            'it, old bundles still load (F-SCE15-4). A format stamp bumps only '
            'for a change that is NOT backwards compatible, so bumping here '
            'would strand readers over a field they may ignore. If the format '
            'genuinely broke, change this expectation deliberately and say why.',
      );
    });

    test(
      'F-SCE15-6: omitting the generator writes no key at all [2026-09-18]',
      () {
        // Not merely null — absent. A null-valued key would make every bundle
        // claim to carry provenance and supply none, which is worse than silence
        // because a reader cannot tell it from a producer that tried and failed.
        final json = _bundle().toJson();
        expect(json.containsKey(AstBundleFormat.keyGenerator), isFalse);

        final manifestJson = AstBundleManifest(
          version: AstBundleFormat.version,
          entryPoint: 'package:x/main.dart',
          files: const {'0.ast.json': 'package:x/main.dart'},
        ).toJson();
        expect(manifestJson.containsKey(AstBundleFormat.keyGenerator), isFalse);
      },
    );
  });
}

/// The raw manifest bytes inside a bundle ZIP.
///
/// Reaches into the archive directly rather than through [AstBundle.fromZip],
/// because F-SCE15-3 is asserting what is ON DISK, and going through the reader
/// would only prove the reader agrees with itself.
List<int> rawManifestBytes(List<int> zipped) {
  final archive = ZipDecoder().decodeBytes(zipped);
  final file = archive.findFile(AstBundleFormat.manifestFileName);
  if (file == null) {
    throw StateError('no ${AstBundleFormat.manifestFileName} in the archive');
  }
  return file.content;
}
