import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

void main() {
  group('BridgeGenerator._getPackageUri', () {
    test(
      'G-PURI-01: Unresolved host paths fall back to POSIX separators. '
      '[2026-06-15] (FAIL)',
      () {
        // Reproduces the tom_core_kernel_bridges.b.dart Windows defect: a
        // source file that does not resolve to a package was embedded raw into
        // the generated `classSourceUris()` map, so a backslash path such as
        // `C:\Code\...\user_principal_aci.dart` produced `\u`/`\t` escape
        // errors when the generated Dart was parsed.
        final generator = BridgeGenerator(workspacePath: r'C:\Code\workspace');

        final uri = generator.packageUriForTesting(
          r'C:\Code\al_the_bear\some\dir\user_principal_aci.dart',
        );

        expect(uri.contains(r'\'), isFalse, reason: 'URI: $uri');
        expect(
          uri,
          equals('C:/Code/al_the_bear/some/dir/user_principal_aci.dart'),
        );
      },
    );

    test(
      'G-PURI-02: Windows lib paths resolve to package URIs. '
      '[2026-06-15] (FAIL)',
      () {
        // The `/lib/` lookup must succeed on backslash input too.
        final generator = BridgeGenerator(
          workspacePath: r'C:\Code\workspace',
          packageName: 'tom_core_kernel',
        );

        final uri = generator.packageUriForTesting(
          r'C:\Code\pkg\tom_core_kernel\lib\src\foo\bar.dart',
        );

        expect(uri, equals('package:tom_core_kernel/src/foo/bar.dart'));
      },
    );

    test(
      'G-PURI-03: A relative source path still resolves to a package URI '
      '(GEN-125). [2026-08-12] (FAIL)',
      () {
        // `d4rtgen -s .` walks the project with relative paths, so a barrel
        // such as `lib/tom_d4rt_cli_api.dart` reaches here unrooted. Both
        // probes below look for a *leading-separator* `/lib/`, which a
        // relative path can never contain, so the source URI silently fell
        // through to the raw-path fallback and the generated
        // `bridgeReExports()` recorded `lib/tom_d4rt_cli_api.dart` instead of
        // `package:tom_d4rt_dcli/tom_d4rt_cli_api.dart` — a re-export key no
        // importer can ever match.
        //
        // `dart test` runs with the package root as cwd, so this generator's
        // own sources are the fixture.
        final generator = BridgeGenerator(workspacePath: Directory.current.path);

        final uri = generator.packageUriForTesting('lib/src/analysis_paths.dart');

        expect(uri, equals('package:tom_d4rt_generator/src/analysis_paths.dart'));
      },
    );

    test(
      'G-PURI-04: Already-resolved URIs are passed through unrooted. '
      '[2026-08-12] (FAIL)',
      () {
        // Several call sites feed `_getPackageUri` a URI that is already
        // resolved. Rooting a relative path must not treat `package:`/`dart:`
        // as a relative filename.
        final generator = BridgeGenerator(workspacePath: Directory.current.path);

        expect(
          generator.packageUriForTesting('package:tom_d4rt/d4rt.dart'),
          equals('package:tom_d4rt/d4rt.dart'),
        );
        expect(generator.packageUriForTesting('dart:core'), equals('dart:core'));
      },
    );
  });
}
