// DGUB2: the v2 d4rtgen executor must forward buildkit `recursiveBoundTypes:`
// to the generator.
//
// The runtime-dispatch bound-type escape hatch (BridgeConfig.recursiveBoundTypes)
// lets a package widen the set of types a recursive-bound generic function
// dispatches over at runtime (defaults: num, String, DateTime, Duration,
// BigInt). The v1 path (bridge_api.dart) forwarded these into the
// BridgeGenerator; the v2 executor (d4rtgen_executor.dart) silently omitted the
// parameter, so v2-path projects fell back to the built-in defaults and
// ignored their buildkit config.
//
// This test drives the v2 executor end-to-end against a temp project whose
// buildkit config adds `bool` (a dart:core type NOT in the defaults) as a
// recursive bound type, plus a top-level generic function with a recursive
// bound. It asserts the generated globals bridge contains runtime dispatch for
// `bool` — which is present ONLY when the config value reaches the generator.
// Without the fix the assertion fails (defaults only, no `bool`).

@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_executor.dart';

CommandContext _createTestContext({
  required String path,
  String executionRoot = '/workspace',
}) {
  return CommandContext(
    fsFolder: FsFolder(path: path),
    natures: [],
    executionRoot: executionRoot,
  );
}

void main() {
  group('DGUB2: v2 executor forwards recursiveBoundTypes', () {
    test(
      'G-DGUB2-1: config-supplied recursive bound type (bool) reaches '
      'generation via the v2 path [2026-07-23] (PASS)',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'dgub2_recursive_bounds_',
        );
        try {
          // pubspec.yaml
          await File(p.join(tempDir.path, 'pubspec.yaml')).writeAsString('''
name: test_project
version: 1.0.0
environment:
  sdk: ^3.0.0
''');

          // Source: a top-level generic function with a recursive type bound.
          // This triggers _generateRecursiveBoundDispatch in the generator,
          // which emits `if (firstElem is <BoundType>)` for every configured
          // recursive bound type.
          await Directory(p.join(tempDir.path, 'lib')).create(recursive: true);
          await File(p.join(tempDir.path, 'lib/core.dart')).writeAsString('''
/// Returns the first element; generic with a self-referential bound so the
/// generator emits runtime type dispatch.
T pickFirst<T extends Comparable<T>>(List<T> items) => items.first;
''');

          // buildkit.yaml: add `bool` — a dart:core type that is NOT one of the
          // built-in defaults (num, String, DateTime, Duration, BigInt).
          await File(p.join(tempDir.path, 'buildkit.yaml')).writeAsString('''
d4rtgen:
  name: test_project
  recursiveBoundTypes:
    - bool
  modules:
    - name: core
      barrelFiles:
        - lib/core.dart
      outputPath: lib/src/bridges/core_bridges.b.dart
''');

          final executor = D4rtgenExecutor();
          final context = _createTestContext(
            path: tempDir.path,
            executionRoot: tempDir.parent.path,
          );

          final result = await executor.execute(context, const CliArgs());
          expect(result.success, isTrue, reason: 'Generation must succeed');

          final bridgesPath = p.join(
            tempDir.path,
            'lib/src/bridges/core_bridges.b.dart',
          );
          final bridges = await File(bridgesPath).readAsString();

          // The default dispatch (String) is always present; that alone does
          // not prove the config was forwarded. `bool` is the discriminating
          // marker: it appears ONLY if the config value reached the generator.
          expect(
            bridges,
            contains('firstElem is bool'),
            reason:
                'The buildkit-configured recursive bound type `bool` must '
                'reach generation via the v2 path. Its absence means the v2 '
                'executor dropped config.recursiveBoundTypes and fell back to '
                'the built-in defaults.',
          );
        } finally {
          await tempDir.delete(recursive: true);
        }
      },
    );
  });
}
