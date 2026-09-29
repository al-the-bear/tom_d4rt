/// SCF1: `generateBridges` produces the same bridges whatever form the project
/// path arrives in, and honours the barrel's `show` / `hide` clauses.
///
/// Measured before the fix on `example/dart_overview`: a RELATIVE project path
/// (what `d4rtgen -p .` passes) generated 110 classes, an ABSOLUTE one (what
/// `checkBridgeFreshness` passes) 97. The export-info map was keyed by the
/// barrel path in the caller's form, while every lookup used the parse step's
/// always-absolute `sourceFile`; relative keys matched nothing and the
/// export-clause filter failed OPEN. The 13 classes only the relative run kept
/// are each outside the `show` list the barrel applies to their file, so the
/// absolute output was the correct one — not, as first recorded, the broken
/// one.
///
/// Both runs go through `previewGeneration`, so nothing in `example/` is
/// written.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

const _example = 'example/dart_overview';
const _module = 'lib/src/d4rt_bridges/dart_overview_bridges.b.dart';

/// Every file one generation writes, by path relative to the package, with the
/// `// Generated:` line removed.
Future<Map<String, String>> _generate(String projectPath) async {
  final root = p.normalize(p.absolute(_example));
  final config = BuildConfigLoader.loadFromTomBuildYaml(root)!;
  final preview = await previewGeneration(
    packageRoot: root,
    purpose: 'scf1',
    generate: () async {
      final result = await generateBridges(
        config: config,
        projectPath: projectPath,
        runPubGet: false,
      );
      expect(result.errors, isEmpty, reason: result.errors.join('\n'));
      // Reads inside the overlay see this run's writes.
      return {
        for (final f in result.outputFiles)
          p.relative(p.normalize(p.absolute(f)), from: root):
              normaliseGeneratedContent(File(f).readAsStringSync()),
      };
    },
  );
  return preview.result;
}

void main() {
  late Map<String, String> relative;
  late Map<String, String> absolute;

  setUpAll(() async {
    relative = await _generate(_example);
    absolute = await _generate(p.normalize(p.absolute(_example)));
  });

  test('F-SCF1-1: a relative and an absolute project path generate the same '
      'files, byte for byte [2026-09-29] (PASS)', () {
    expect(relative.keys.toSet(), absolute.keys.toSet());
    expect(relative, contains(_module));
    for (final path in relative.keys) {
      expect(relative[path], absolute[path], reason: '$path differs');
    }
  });

  test(
    'F-SCF1-2: the barrel\'s show clause is honoured — a shown class is '
    'bridged, an unshown sibling in the same file is not [2026-09-29] (PASS)',
    () {
      final module = relative[_module]!;
      // `export 'generics/type_bounds/run_type_bounds.dart' show Statistics;`
      expect(module, contains('.Statistics,'));
      for (final hidden in [
        'SortedList',
        'PriorityQueue',
        'BinarySearchTree',
      ]) {
        expect(
          RegExp('nativeType: \\\$[a-z_0-9]+\\.$hidden\\b').hasMatch(module),
          isFalse,
          reason: '$hidden is not in the barrel\'s show list for its file',
        );
      }
    },
  );
}
