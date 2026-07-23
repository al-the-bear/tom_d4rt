// DFUB2: gate filesystem source reads behind FilesystemPermission and produce
// clear, resolved-path/package-specific error messages.
//
// Builds on DFUB1 (basePath + allowFileSystemImports wiring). DFUB1 read the
// module off disk whenever `allowFileSystemImports` was set — with NO
// per-read permission check. DFUB2 ports upstream kodjodevf/d4rt 973feab's
// `_checkFileSystemSourceReadPermission` gate plus the distinct
// missing-source error shapes:
//   (a) fs imports FAIL without a matching FilesystemPermission;
//   (b) fs imports FAIL CLEARLY when allowFileSystemImports is disabled;
//   (c) missing fs imports fail with the resolved path in the error;
//   (d) missing package imports fail with a package-specific error.
//
// The read-permission GATE and the path-scope canonicalization are separate:
// path-scope hardening (`..` traversal / canonicalization) is DFUB11; the
// platform io/web split is DFUB12. This suite covers only the read gate and
// the error-message shapes.

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  late io.Directory tempRoot;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dfub2_fs_imports_');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DFUB2: filesystem import permission + error shapes', () {
    test(
      'F-DFUB2-1: filesystem import without FilesystemPermission is denied '
      '[2026-07-23] (PASS)',
      () {
        final libDir = io.Directory('${tempRoot.path}/lib')
          ..createSync(recursive: true);
        io.File('${libDir.path}/secret.dart').writeAsStringSync('''
String secretValue() => "should-not-read";
''');

        // Deliberately grant NO FilesystemPermission.
        final d4rt = D4rt();

        expect(
          () => d4rt.execute(
            source: '''
import './secret.dart';

String main() => secretValue();
''',
            basePath: libDir.path,
            allowFileSystemImports: true,
          ),
          throwsA(
            predicate((e) =>
                e.toString().contains('requires FilesystemPermission')),
          ),
        );
      },
    );

    test(
      'F-DFUB2-2: filesystem import fails clearly when allowFileSystemImports '
      'is disabled [2026-07-23] (PASS)',
      () {
        final libDir = io.Directory('${tempRoot.path}/lib')
          ..createSync(recursive: true);
        final target = io.File('${libDir.path}/thing.dart')
          ..writeAsStringSync('String thingValue() => "x";');

        final d4rt = D4rt();
        d4rt.grant(FilesystemPermission.readPath(libDir.path));

        // Absolute file: import, but allowFileSystemImports is left disabled.
        final fileUri = target.absolute.uri.toString();
        expect(
          () => d4rt.execute(
            source: '''
import '$fileUri';

String main() => thingValue();
''',
            // allowFileSystemImports intentionally omitted (defaults to false).
          ),
          throwsA(
            predicate(
                (e) => e.toString().contains('Filesystem imports are disabled')),
          ),
        );
      },
    );

    test(
      'F-DFUB2-3: missing filesystem import reports the resolved path '
      '[2026-07-23] (PASS)',
      () {
        final libDir = io.Directory('${tempRoot.path}/lib')
          ..createSync(recursive: true);
        // Note: no file is written — the import target does not exist.

        final d4rt = D4rt();
        d4rt.grant(FilesystemPermission.readPath(libDir.path));

        expect(
          () => d4rt.execute(
            source: '''
import './missing.dart';

String main() => "unreachable";
''',
            basePath: libDir.path,
            allowFileSystemImports: true,
          ),
          throwsA(
            predicate((e) =>
                e.toString().contains('not found on filesystem') &&
                e.toString().contains('resolved path:')),
          ),
        );
      },
    );

    test(
      'F-DFUB2-4: missing package import reports a package-specific error '
      '[2026-07-23] (PASS)',
      () {
        final d4rt = D4rt();

        expect(
          () => d4rt.execute(
            source: '''
import 'package:no_such_pkg/foo.dart';

String main() => "unreachable";
''',
          ),
          throwsA(
            predicate((e) =>
                e.toString().contains('Package module source not preloaded')),
          ),
        );
      },
    );
  });
}
