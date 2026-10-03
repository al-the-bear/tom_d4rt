// DFIN2: the script runners read imports through the interpreter's
// permissions.
//
// `executeFile` used to resolve imports with a regex pre-walk that read every
// transitive import off disk itself, then handed the result to `sources`, so
// the loader's FilesystemPermission check never ran. A scoped grant did not
// hold, a symlink inside the script directory read outside it, and a run with
// no grant at all read anything the host could. Now the loader reads every
// import, and the runners add one implicit grant for the run: READ on the
// entry script's directory tree.
//
// Twin: tom_d4rt_exec ports this file verbatim.
import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  late io.Directory root;
  late io.Directory app;
  late io.Directory outside;

  setUp(() {
    root = io.Directory.systemTemp.createTempSync('dfin2_runner_');
    // Real paths, so a macOS /var -> /private/var link cannot blur a check.
    root = io.Directory(root.resolveSymbolicLinksSync());
    app = io.Directory('${root.path}/app')..createSync();
    outside = io.Directory('${root.path}/outside')..createSync();
    io.File(
      '${outside.path}/secret.dart',
    ).writeAsStringSync("String secret() => 'escaped';\n");
    io.File(
      '${app.path}/near.dart',
    ).writeAsStringSync("String near() => 'near';\n");
  });

  tearDown(() {
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  io.File script(String body) =>
      io.File('${app.path}/main.dart')..writeAsStringSync(body);

  group('DFIN2: executeFile', () {
    test('DFIN2-1: an import beside the script runs with no grant — the '
        'implicit grant [2026-10-03]', () {
      final d4rt = D4rt();
      final result = executeFile(
        d4rt,
        script("import './near.dart';\nString main() => near();\n").path,
      );
      expect(result.error, isNull);
      expect(result.result, 'near');
      expect(result.sourcesLoaded, 2);
    });

    test('DFIN2-2: an import outside the script directory is refused without '
        'a grant [2026-10-03]', () {
      final result = executeFile(
        D4rt(),
        script(
          "import '../outside/secret.dart';\nString main() => secret();\n",
        ).path,
      );
      expect(result.success, isFalse);
      expect(result.error, contains('FilesystemPermission'));
    });

    test('DFIN2-3: a symlink inside the script directory cannot read outside '
        'it [2026-10-03]', () {
      io.Link('${app.path}/escape').createSync(outside.path);
      final result = executeFile(
        D4rt(),
        script(
          "import './escape/secret.dart';\nString main() => secret();\n",
        ).path,
      );
      expect(result.success, isFalse);
      expect(result.error, contains('FilesystemPermission'));
    });

    test('DFIN2-4: a host grant still reaches outside the tree, and survives '
        'the run [2026-10-03]', () {
      final d4rt = D4rt();
      final hostGrant = FilesystemPermission.readPath(outside.path);
      d4rt.grant(hostGrant);
      final result = executeFile(
        d4rt,
        script(
          "import '../outside/secret.dart';\nString main() => secret();\n",
        ).path,
      );
      expect(result.error, isNull);
      expect(result.result, 'escaped');
      expect(d4rt.hasPermission(hostGrant), isTrue);
    });

    test('DFIN2-5: the implicit grant ends with the run [2026-10-03]', () {
      final d4rt = D4rt();
      executeFile(
        d4rt,
        script("import './near.dart';\nString main() => near();\n").path,
      );
      expect(
        d4rt.checkPermission({
          'type': 'filesystem',
          'path': '${app.path}/near.dart',
          'read': true,
        }),
        isFalse,
      );
    });
  });

  group('DFIN2: executeSource and executeFileContinued', () {
    test('DFIN2-6: executeSource refuses an import outside its basePath '
        '[2026-10-03]', () {
      final result = executeSource(
        D4rt(),
        "import '../outside/secret.dart';\nString main() => secret();\n",
        app.path,
      );
      expect(result.success, isFalse);
      expect(result.error, contains('FilesystemPermission'));
    });

    test('DFIN2-7: executeFileContinued reads an import beside the script and '
        'refuses one through a symlink [2026-10-03]', () {
      // `executeFileContinued` evaluates into an existing context, imports
      // first. (Its main file cannot itself hold an import directive: `eval`
      // parses statements, a limitation older than this change. What is
      // measured here is the gated READ of each import.)
      final d4rt = D4rt()..execute(source: 'main() {}');
      executeFileContinued(
        d4rt,
        script("import './near.dart';\nnear();\n").path,
      );
      expect(d4rt.eval('near()'), 'near');

      io.Link('${app.path}/escape').createSync(outside.path);
      final refused = executeFileContinued(
        D4rt()..execute(source: 'main() {}'),
        script("import './escape/secret.dart';\nsecret();\n").path,
      );
      expect(refused.success, isFalse);
      expect(refused.error, contains('FilesystemPermission'));
    });
  });
}
