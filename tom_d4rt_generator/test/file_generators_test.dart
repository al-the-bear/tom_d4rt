import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/file_generators.dart';

void main() {
  group('File generators', () {
    test(
      'G-FGEN-01: Barrel exports are relative to barrelPath directory. [2026-02-27] (FAIL)',
      () {
        final config = BridgeConfig(
          name: 'flutter_material_bridges',
          barrelPath: 'lib/src/bridges/flutter_bridges_barrel.b.dart',
          modules: const [
            ModuleConfig(
              name: 'flutter_painting',
              barrelFiles: ['package:flutter/painting.dart'],
              outputPath: 'lib/src/bridges/painting_bridges.b.dart',
            ),
            ModuleConfig(
              name: 'flutter_widgets',
              barrelFiles: ['package:flutter/widgets.dart'],
              outputPath: 'lib/src/bridges/widgets_bridges.b.dart',
            ),
          ],
        );

        final content = generateBarrelFileContent(config);

        expect(
          content,
          contains("export 'painting_bridges.b.dart';"),
          reason:
              'Exports must be relative to barrel file directory when barrelPath is nested in lib/src/bridges',
        );
        expect(
          content,
          contains("export 'widgets_bridges.b.dart';"),
          reason:
              'Exports must not duplicate src/bridges prefix from module output paths',
        );
        expect(content, isNot(contains("export 'src/bridges/")));
      },
    );

    test(
      'G-FGEN-02: toImportUri converts host backslashes to POSIX slashes. '
      '[2026-06-15] (FAIL)',
      () {
        // `p.relative` returns host-native separators (backslashes on
        // Windows). Dart import/export URIs must always use `/` — `\t` would
        // otherwise be parsed as a TAB escape, corrupting the URI.
        expect(
          toImportUri(r'src\tom_basics\tom_basics_bridges.b.dart'),
          equals('src/tom_basics/tom_basics_bridges.b.dart'),
        );
        // Already-POSIX input is preserved.
        expect(
          toImportUri('src/foo/bar.b.dart'),
          equals('src/foo/bar.b.dart'),
        );
        // Mixed separators are normalised.
        expect(
          toImportUri(r'src/foo\bar.b.dart'),
          equals('src/foo/bar.b.dart'),
        );
      },
    );

    test(
      'G-FGEN-03: Dartscript module imports use POSIX separators on every host. '
      '[2026-06-15] (FAIL)',
      () {
        // Reproduces the tom_core_d4rt Windows defect: relative module imports
        // in lib/dartscript.b.dart were emitted with backslashes, so Dart
        // could not parse them (`src\tom_basics\…` → invalid URI).
        final config = BridgeConfig(
          name: 'tom_dartscript_bridges',
          dartscriptPath: 'lib/dartscript.b.dart',
          modules: const [
            ModuleConfig(
              name: 'tom_basics',
              barrelFiles: ['package:tom_basics/tom_basics.dart'],
              outputPath: 'lib/src/tom_basics/tom_basics_bridges.b.dart',
            ),
          ],
        );

        final content = generateDartscriptFileContent(
          config,
          dartscriptPath: 'lib/dartscript.b.dart',
          packageName: 'tom_core_d4rt',
        );

        expect(
          content,
          contains(
            "import 'src/tom_basics/tom_basics_bridges.b.dart' "
            'as tom_basics_bridges;',
          ),
        );
        // No import/export line may contain a backslash, regardless of host OS.
        final offending = const LineSplitter()
            .convert(content)
            .where((l) => l.trimLeft().startsWith('import '))
            .where((l) => l.contains(r'\'))
            .toList();
        expect(
          offending,
          isEmpty,
          reason: 'Import URIs must not contain backslashes: $offending',
        );
      },
    );

    test(
      'G-FGEN-04: Test runner carries no hardcoded developer log path. '
      '[2026-06-28] (FAIL)',
      () {
        // Issue #3: the generated d4rtrun.b.dart baked in a developer-specific
        // absolute path (`/Users/alexiskyaw/.../tom2/d4_invocations.log`) and an
        // unconditional per-invocation logger that threw (and was swallowed) on
        // every other machine. The per-invocation log was dropped entirely; the
        // generated runner must contain no trace of it.
        final config = BridgeConfig(
          name: 'tom_dartscript_bridges',
          modules: const [
            ModuleConfig(
              name: 'tom_basics',
              barrelFiles: ['package:tom_basics/tom_basics.dart'],
              outputPath: 'lib/src/tom_basics/tom_basics_bridges.b.dart',
            ),
          ],
        );

        final content = generateTestRunnerContent(
          config,
          testRunnerPath: 'bin/d4rtrun.b.dart',
          packageName: 'tom_core_d4rt',
        );

        expect(content, isNot(contains('d4_invocations.log')));
        expect(content, isNot(contains('_d4InvocationsLogPath')));
        expect(content, isNot(contains('_logD4Invocation')));
        // Guard against any absolute developer path leaking back in.
        expect(content, isNot(contains('/Users/')));
      },
    );
  });
}
