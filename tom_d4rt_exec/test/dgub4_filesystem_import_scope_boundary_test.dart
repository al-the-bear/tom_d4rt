// DGUB4: the FilesystemPermission scope boundary, exercised through the MODULE
// IMPORT gate.
//
// DFUB11 hardened `FilesystemPermission._isPathWithinScope` so a sibling that
// merely shares the scope's string prefix (`/x/lib` vs `/x/library_evil`) is
// outside the scope. Its 16+5+16 tests verify that through two routes: the
// `dart:io` bridge (`File(...).readAsStringSync()` from interpreted code) and a
// direct unit test on the matcher.
//
// Neither route is the one DGUB4 asked about. An `import './x.dart'` does not
// go through the dart:io bridge at all — it reaches the filesystem through the
// ModuleLoader's `_checkFileSystemSourceReadPermission`, a separate call site
// with its own path-resolution step in front of it. A boundary bug there (say,
// checking the UNRESOLVED import string, or resolving after the check) would
// leave every DFUB11 test green while filesystem imports escaped their scope.
//
// So this suite pins the same boundary on the import path. It is the evidence
// DGUB4's RED-test requirement specified and DFUB11 did not, in fact, supply.
//
// The analyzer-based reference copy of this suite is
// `tom_d4rt/test/dgub4_filesystem_import_scope_boundary_test.dart`.
// `tom_d4rt_ast` needs no mirror: its `AstModuleLoader` is lookup-only and has
// no filesystem branch, so the import gate does not exist there. Its copy of
// the matcher is covered by F-DFUB11-A1.

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  late io.Directory tempRoot;
  late io.Directory libDir;
  late io.Directory siblingDir;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dgub4_fs_scope_');

    // The names are load-bearing: '<root>/lib' is a strict STRING prefix of
    // '<root>/library_evil'. A naive `startsWith(allowedPath)` admits the
    // sibling; only a segment-boundary check rejects it.
    libDir = io.Directory('${tempRoot.path}/lib')..createSync(recursive: true);
    siblingDir = io.Directory('${tempRoot.path}/library_evil')
      ..createSync(recursive: true);

    io.File('${libDir.path}/allowed.dart').writeAsStringSync('''
String allowedValue() => "in-scope";
''');
    io.File('${siblingDir.path}/secret.dart').writeAsStringSync('''
String secretValue() => "should-not-read";
''');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DGUB4: import-path scope boundary', () {
    test(
      'F-DGUB4-1: a genuine import inside the granted scope is allowed '
      '[2026-07-27] (PASS)',
      () {
        // The anchor. Without it, the two denials below would pass just as
        // happily if filesystem imports were broken outright — a denial proves
        // nothing unless the same setup can also succeed.
        final d4rt = D4rt()
          ..grant(FilesystemPermission.readPath(libDir.absolute.path));

        final result = d4rt.execute(
          source: '''
import './allowed.dart';

String main() => allowedValue();
''',
          basePath: libDir.absolute.path,
          allowFileSystemImports: true,
        );

        expect(result, equals('in-scope'));
      },
    );

    test(
      'F-DGUB4-2: a sibling sharing the scope prefix is denied on the import '
      'path [2026-07-27] (PASS)',
      () {
        // DGUB4's literal RED-test requirement: grant readPath('<root>/lib'),
        // then import '<root>/library_evil/secret.dart' and expect a denial.
        final d4rt = D4rt()
          ..grant(FilesystemPermission.readPath(libDir.absolute.path));

        expect(
          () => d4rt.execute(
            source: '''
import '../library_evil/secret.dart';

String main() => secretValue();
''',
            basePath: libDir.absolute.path,
            allowFileSystemImports: true,
          ),
          throwsA(
            predicate(
                (e) => e.toString().contains('requires FilesystemPermission')),
          ),
        );
      },
    );

    test(
      'F-DGUB4-3: the sibling is denied by absolute URI too, so it is the '
      'scope that rejects it and not the `..` [2026-07-27] (PASS)',
      () {
        // F-DGUB4-2 reaches the sibling through '..'. On its own that leaves a
        // cheaper explanation open: the loader might be rejecting traversal
        // syntax rather than testing the scope. Spelling the same target as an
        // absolute file: URI removes the '..' and must still be denied — which
        // is only true if the check is a real scope comparison.
        final targetUri =
            io.File('${siblingDir.path}/secret.dart').absolute.uri.toString();

        final d4rt = D4rt()
          ..grant(FilesystemPermission.readPath(libDir.absolute.path));

        expect(
          () => d4rt.execute(
            source: '''
import '$targetUri';

String main() => secretValue();
''',
            basePath: libDir.absolute.path,
            allowFileSystemImports: true,
          ),
          throwsA(
            predicate(
                (e) => e.toString().contains('requires FilesystemPermission')),
          ),
        );
      },
    );

    test(
      'F-DGUB4-4: granting the parent admits both directories, so the denials '
      'above are scope-driven [2026-07-27] (PASS)',
      () {
        // The complement of F-DGUB4-1: widen the grant to the shared parent and
        // the previously-denied sibling loads. This pins that F-DGUB4-2/-3 fail
        // because of the GRANT's extent, not because the sibling file is
        // somehow unreadable or the resolution is broken.
        final d4rt = D4rt()
          ..grant(FilesystemPermission.readPath(tempRoot.absolute.path));

        final result = d4rt.execute(
          source: '''
import '../library_evil/secret.dart';

String main() => secretValue();
''',
          basePath: libDir.absolute.path,
          allowFileSystemImports: true,
        );

        expect(result, equals('should-not-read'));
      },
    );
  });
}
