// DGUB3: filesystem imports on the analyzer-free exec entry point.
//
// tom_d4rt got this in DFUB1 (basePath + allowFileSystemImports resolution),
// DFUB2 (the per-read FilesystemPermission gate + the missing-source error
// shapes) and DFUB3 (canonicalizing the module URI so nested relatives resolve
// against an absolute base). None of it was mirrored here, and the omission was
// invisible from the outside: `execute()` and `validateRegistrations()` have
// always ACCEPTED `basePath` / `allowFileSystemImports`, but `_initModule`
// dropped both on the floor — it never passed them to the ModuleLoader, which
// did not declare them. Exactly the dead-parameter shape DFUB1 fixed upstream.
//
// This suite is the exec-side mirror of `dfub1_filesystem_import_basepath_test`
// and the read-gate half of `dfub2_filesystem_import_permission_test`. It is
// deliberately written against the PUBLIC API rather than the loader, because
// the defect lived in the wiring between the two — a loader-level test would
// have passed while `execute()` stayed broken.
//
// WHAT THIS SUITE DOES NOT COVER: `executeFile()` reaches the same files by a
// different route — `resolveImportsRecursively`, a regex-based pre-walk in
// script_execution.dart that reads every transitive import off disk with NO
// permission check and folds them into `sources` before the interpreter runs.
// That path is older than this change and its reads stay ungated; F-DGUB3-7
// pins the boundary so nobody mistakes the gate below for whole-package
// coverage. Closing it is DGUC1.

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  late io.Directory tempRoot;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dgub3_fs_imports_');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DGUB3: filesystem imports via basePath', () {
    test('F-DGUB3-1: direct source can import a relative filesystem module '
        '[2026-07-27] (PASS)', () {
      final libDir = io.Directory('${tempRoot.path}/lib')
        ..createSync(recursive: true);
      io.File('${libDir.path}/utils.dart').writeAsStringSync('''
String greetFromUtils() {
  return "hello from fs";
}
''');

      final d4rt = D4rt();
      d4rt.grant(FilesystemPermission.readPath(libDir.path));

      final result = d4rt.execute(
        source: '''
import './utils.dart';

String main() {
  return greetFromUtils();
}
''',
        basePath: libDir.path,
        allowFileSystemImports: true,
      );

      expect(result, equals('hello from fs'));
    });

    test('F-DGUB3-2: filesystem root library can be loaded when enabled '
        '[2026-07-27] (PASS)', () {
      // The root library is not in `sources` at all here, so this also pins
      // that _parseSource stops requiring a preloaded entry once filesystem
      // imports are on — the gate that made `library:` file URIs unusable.
      final appDir = io.Directory('${tempRoot.path}/app')
        ..createSync(recursive: true);
      io.File('${appDir.path}/helpers.dart').writeAsStringSync('''
String helperValue() {
  return "from helper";
}
''');
      final mainFile = io.File('${appDir.path}/main.dart')
        ..writeAsStringSync('''
import './helpers.dart';

String main() {
  return helperValue();
}
''');

      final d4rt = D4rt();
      d4rt.grant(FilesystemPermission.readPath(appDir.path));

      final result = d4rt.execute(
        library: mainFile.absolute.uri.toString(),
        allowFileSystemImports: true,
        basePath: appDir.path,
      );

      expect(result, equals('from helper'));
    });

    test(
      'F-DGUB3-3: filesystem imports resolve nested relatives without shared '
      'state [2026-07-27] (PASS)',
      () {
        // The depth is the point. `value.dart` is reached by a relative import
        // written inside `feature.dart`, so it can only resolve if the loader
        // canonicalized feature.dart's own URI to an absolute file: spelling
        // first — resolving it against `basePath` instead would look for
        // <root>/messages/value.dart and miss.
        final rootDir = io.Directory('${tempRoot.path}/nested');
        io.Directory(
          '${rootDir.path}/features/messages',
        ).createSync(recursive: true);

        io.File('${rootDir.path}/main.dart').writeAsStringSync('''
import 'features/feature.dart';

String entryMessage() => loadMessage();
''');
        io.File('${rootDir.path}/features/feature.dart').writeAsStringSync('''
import 'messages/value.dart';

String loadMessage() => featureValue();
''');
        io.File(
          '${rootDir.path}/features/messages/value.dart',
        ).writeAsStringSync('''
String featureValue() => 'nested-ok';
''');

        final d4rt = D4rt();
        d4rt.grant(FilesystemPermission.readPath(rootDir.absolute.path));

        final result = d4rt.execute(
          source: '''
import 'main.dart';

String main() => entryMessage();
''',
          basePath: rootDir.absolute.path,
          allowFileSystemImports: true,
        );

        expect(result, equals('nested-ok'));
      },
    );
  });

  group('DGUB3: filesystem import permission gate + error shapes', () {
    test('F-DGUB3-4: filesystem import without FilesystemPermission is denied '
        '[2026-07-27] (PASS)', () {
      final libDir = io.Directory('${tempRoot.path}/lib')
        ..createSync(recursive: true);
      io.File('${libDir.path}/secret.dart').writeAsStringSync('''
String secretValue() => "should-not-read";
''');

      // Deliberately grant NO FilesystemPermission. The file exists and
      // basePath resolves to it, so only the gate can stop this.
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
          predicate(
            (e) => e.toString().contains('requires FilesystemPermission'),
          ),
        ),
      );
    });

    test(
      'F-DGUB3-5: filesystem import fails clearly when allowFileSystemImports '
      'is disabled [2026-07-27] (PASS)',
      () {
        final libDir = io.Directory('${tempRoot.path}/lib')
          ..createSync(recursive: true);
        final target = io.File('${libDir.path}/thing.dart')
          ..writeAsStringSync('String thingValue() => "x";');

        final d4rt = D4rt();
        d4rt.grant(FilesystemPermission.readPath(libDir.path));

        // Absolute file: import, permission granted, file present — the ONLY
        // reason this must fail is the disabled flag, so the message has to say
        // so rather than blaming the stdlib.
        final fileUri = target.absolute.uri.toString();
        expect(
          () => d4rt.execute(
            source:
                '''
import '$fileUri';

String main() => thingValue();
''',
            // allowFileSystemImports intentionally omitted (defaults to false).
          ),
          throwsA(
            predicate(
              (e) => e.toString().contains('Filesystem imports are disabled'),
            ),
          ),
        );
      },
    );

    test('F-DGUB3-6: missing filesystem import reports the resolved path '
        '[2026-07-27] (PASS)', () {
      final libDir = io.Directory('${tempRoot.path}/lib')
        ..createSync(recursive: true);
      // Note: no file is written — the import target does not exist. The
      // resolved path is what tells the caller WHERE the loader looked, which
      // is the whole diagnostic value when basePath is wrong.

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
          predicate(
            (e) =>
                e.toString().contains('not found on filesystem') &&
                e.toString().contains('resolved path:'),
          ),
        ),
      );
    });
  });

  group('DGUB3: the gate applies to the loader path only', () {
    test(
      'F-DGUB3-7: executeFile still reads transitive imports without a grant, '
      'because its pre-walk bypasses the loader [2026-07-27] (PASS)',
      () {
        // NOT an endorsement — a boundary pin. `executeFile` resolves imports
        // itself (regex pre-walk in script_execution.dart) and hands the result
        // to `sources`, so the loader never reaches the filesystem branch and
        // the F-DGUB3-4 gate never runs. Asserting the CURRENT behaviour keeps
        // the gap visible and gives DGUC1 a test to invert: when the pre-walk
        // is gated this test must be rewritten to expect a denial, and the
        // rewrite is the signal that consumers need grants.
        final appDir = io.Directory('${tempRoot.path}/unguarded')
          ..createSync(recursive: true);
        io.File('${appDir.path}/dep.dart').writeAsStringSync('''
String depValue() => "read-without-grant";
''');
        final mainFile = io.File('${appDir.path}/main.dart')
          ..writeAsStringSync('''
import './dep.dart';

String main() => depValue();
''');

        // No FilesystemPermission granted anywhere.
        final d4rt = D4rt();
        final result = executeFile(d4rt, mainFile.path);

        expect(
          result.success,
          isTrue,
          reason:
              'executeFile pre-walk is ungated today; if this now fails, '
              'DGUC1 has landed and this test must be inverted',
        );
        expect(result.result, equals('read-without-grant'));
        expect(result.sourcesLoaded, equals(2));
      },
    );
  });
}
