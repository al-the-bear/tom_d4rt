// SCE52: everything a generation WRITES must be in the list it REPORTS.
//
// `--verify-output` analyses exactly `GenerationResult.outputFiles` — the CLI's
// `_processProjectDirect` ends `return result.outputFiles`. So a file the
// generation writes but does not report is a file the gate never analyses, and
// the run still prints "N generated file(s) analysed clean". That is the same
// failure shape as SCE51, where verification analysed nothing and said so in
// the same words; the lesson taken from it is that a gate reporting success is
// worth nothing until something pins what it covered.
//
// THE OPPOSITE DIRECTION IS ALREADY CHECKED and was never the hole:
// `checkBridgeFreshness` walks `outputFiles` and fails on a reported path the
// scratch tree does not hold. Nothing walked the writes. This does.
//
// HOW THE GROUND TRUTH IS OBTAINED. `previewGeneration` redirects the
// package's `*.b.dart` writes into a scratch tree and records every one, so
// `preview.writes` is what the generation actually wrote — observed at the
// filesystem boundary rather than derived from the generator's own bookkeeping,
// which is the thing under test. The examples are the corpus because they are
// the only projects in this package that enable the full set of emitters
// (barrel, dartscript, test runner, proxies, relaxers) across their configs.
//
// A KNOWN LIMIT, stated so a green run is not over-read: the overlay redirects
// `*.b.dart`, which is every destination `generateBridges` produces because
// each passes through `ensureBDartExtension`. A future emitter writing some
// other suffix would escape both the overlay and this check — and would be
// caught instead by `checkBridgeFreshness`, which fails when a reported file is
// not in the scratch tree.
@Tags(['generation'])
library;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/testing.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  final examples = findD4rtgenProjects('example');

  /// Writes and reports for [example], both package-relative.
  Future<({Set<String> written, Set<String> reported})> generate(
    String example,
  ) async {
    final root = p.normalize(p.absolute('example', example));
    final unresolved = await resolveIfUnresolved(root);
    expect(unresolved, isNull, reason: unresolved);

    final config = BuildConfigLoader.loadFromTomBuildYaml(root);
    expect(config, isNotNull, reason: '$example has no d4rtgen config');

    final preview = await previewGeneration(
      packageRoot: root,
      purpose: 'sce52',
      generate: () => generateBridges(config: config!, projectPath: root),
    );

    return (
      written: {for (final write in preview.writes) write.path},
      reported: {
        for (final file in preview.result.outputFiles)
          p.relative(p.normalize(p.absolute(file)), from: root),
      },
    );
  }

  test(
    'G-SCE52-0: the corpus writes something, so the subset check below is not '
    'vacuous [2026-09-18] (PASS)',
    () async {
      expect(examples, isNotEmpty, reason: 'discovery found no example');
      final sets = await generate(examples.first);
      expect(
        sets.written,
        isNotEmpty,
        reason:
            'a generation that writes nothing satisfies "every write is '
            'reported" for free, which would make every case below green '
            'without testing anything',
      );
    },
  );

  for (final example in examples) {
    test('G-SCE52[$example]: every file the generation writes is reported in '
        'outputFiles [2026-09-18] (PASS)', () async {
      final sets = await generate(example);
      final unreported = sets.written.difference(sets.reported);

      expect(
        unreported,
        isEmpty,
        reason:
            'these files were written and are not in outputFiles, so '
            '`d4rtgen --verify-output` never analyses them and reports the '
            'run clean regardless of what they contain: '
            '${(unreported.toList()..sort()).join(', ')}',
      );
    });
  }
}
