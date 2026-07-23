// DFUB1: resolve relative filesystem imports via basePath in ModuleLoader.
//
// Our execute()/executeAsync() already ACCEPT `basePath` + `allowFileSystemImports`,
// but before this fix the parameters were dead no-ops: _initModule received
// them yet never passed them to the ModuleLoader constructor, and ModuleLoader
// did not declare them at all. A relative import therefore threw
// "Base URI not defined in ModuleLoader" even when basePath was supplied.
//
// Ported from upstream kodjodevf/d4rt commit 973feab (basePath +
// allowFileSystemImports wiring) and 93f8c42 (nested relatives without shared
// state). The read-permission GATE is deferred to DFUB2 — these tests grant
// FilesystemPermission so they pass at both DFUB1 (no gate) and DFUB2 (gate).

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  late io.Directory tempRoot;

  setUp(() {
    tempRoot = io.Directory.systemTemp.createTempSync('dfub1_fs_imports_');
  });

  tearDown(() {
    if (tempRoot.existsSync()) {
      tempRoot.deleteSync(recursive: true);
    }
  });

  group('DFUB1: filesystem imports via basePath', () {
    test(
      'F-DFUB1-1: direct source can import a relative filesystem module '
      '[2026-07-23] (PASS)',
      () {
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
      },
    );

    test(
      'F-DFUB1-2: filesystem root library can be loaded when enabled '
      '[2026-07-23] (PASS)',
      () {
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
      },
    );

    test(
      'F-DFUB1-3: filesystem imports resolve nested relatives without shared '
      'state [2026-07-23] (PASS)',
      () {
        final rootDir = io.Directory('${tempRoot.path}/nested');
        io.Directory('${rootDir.path}/features/messages')
            .createSync(recursive: true);

        io.File('${rootDir.path}/main.dart').writeAsStringSync('''
import 'features/feature.dart';

String entryMessage() => loadMessage();
''');
        io.File('${rootDir.path}/features/feature.dart')
            .writeAsStringSync('''
import 'messages/value.dart';

String loadMessage() => featureValue();
''');
        io.File('${rootDir.path}/features/messages/value.dart')
            .writeAsStringSync('''
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
}
