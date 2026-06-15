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
  });
}
