// DFIN3/AST: the working directory and the execute flag are permission-checked.
//
// The analyzer-free twin of `tom_d4rt/test/dfin3_cwd_and_execute_permission_test
// .dart`. This tree has no parser, so the adapters are driven directly through
// a module context whose checker is the interpreter's real permission set.
@TestOn('vm')
library;

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// A visitor whose permission checks consult [grants], as a sandboxed run's do.
InterpreterVisitor _visitor(List<Permission> grants) {
  final env = Environment();
  return InterpreterVisitor(
    globalEnvironment: env,
    moduleContext: NoOpModuleContext(
      globalEnvironment: env,
      permissionChecker: (operation) => grants.any((g) => g.allows(operation)),
    ),
  );
}

String _echoPath() {
  for (final candidate in ['/bin/echo', '/usr/bin/echo']) {
    final f = io.File(candidate);
    if (f.existsSync()) return f.resolveSymbolicLinksSync();
  }
  throw StateError('no echo binary');
}

final _posixOnly = io.Platform.isWindows ? 'POSIX echo binary' : null;

void main() {
  final runSync = ProcessIo.definition.staticMethods['runSync']!;
  final setCurrent = DirectoryIo.definition.staticSetters['current']!;

  group('DFIN3/AST: Directory.current', () {
    late io.Directory saved;
    late io.Directory root;

    setUp(() {
      saved = io.Directory.current;
      root = io.Directory(
        io.Directory.systemTemp
            .createTempSync('dfin3_ast_cwd_')
            .resolveSymbolicLinksSync(),
      );
      io.Directory('${root.path}/inside').createSync();
      io.Directory('${root.path}/outside').createSync();
    });

    tearDown(() {
      io.Directory.current = saved;
      if (root.existsSync()) root.deleteSync(recursive: true);
    });

    test('DFIN3-AST-1: outside every write grant it is refused and the '
        'directory does not move [2026-10-03]', () {
      final visitor = _visitor([
        FilesystemPermission.writePath('${root.path}/inside'),
      ]);
      expect(
        () => setCurrent(visitor, '${root.path}/outside'),
        throwsA(isA<RuntimeD4rtException>()),
      );
      expect(io.Directory.current.path, saved.path);
    });

    test('DFIN3-AST-2: a write grant on the target allows it '
        '[2026-10-03]', () {
      // In place: the working directory is process-wide and other test files
      // run concurrently, so moving it would break their relative paths.
      final here = saved.resolveSymbolicLinksSync();
      final visitor = _visitor([FilesystemPermission.writePath(here)]);
      setCurrent(visitor, io.Directory(here));
      expect(io.Directory.current.resolveSymbolicLinksSync(), here);
    });
  });

  group('DFIN3/AST: process execution', () {
    String run(List<Permission> grants, String executable) =>
        (runSync(
                  _visitor(grants),
                  [
                    executable,
                    ['hi'],
                  ],
                  const {},
                  null,
                )
                as io.ProcessResult)
            .stdout
            .toString()
            .trim();

    test('DFIN3-AST-3: an execute grant on the binary allows it '
        '[2026-10-03]', () {
      final echo = _echoPath();
      expect(
        run([
          FilesystemPermission.executePath(io.File(echo).parent.path),
        ], echo),
        'hi',
      );
    }, skip: _posixOnly);

    test('DFIN3-AST-4: a bare command resolves through PATH '
        '[2026-10-03]', () {
      final echo = _echoPath();
      expect(
        run([
          FilesystemPermission.executePath(io.File(echo).parent.path),
        ], 'echo'),
        'hi',
      );
    }, skip: _posixOnly);

    test('DFIN3-AST-5: read and write grants alone do not allow it '
        '[2026-10-03]', () {
      expect(
        () => run([
          FilesystemPermission.read,
          FilesystemPermission.write,
        ], _echoPath()),
        throwsA(isA<RuntimeD4rtException>()),
      );
    }, skip: _posixOnly);

    test('DFIN3-AST-6: a command-scoped ProcessRunPermission allows its '
        'command and checks the arguments [2026-10-03]', () {
      expect(run([ProcessRunPermission.command('echo')], 'echo'), 'hi');
      expect(
        () => run([ProcessRunPermission.command('echo')], 'printf'),
        throwsA(isA<RuntimeD4rtException>()),
      );
      expect(
        () => run([
          ProcessRunPermission.commandWithArgs('echo', ['bye']),
        ], 'echo'),
        throwsA(isA<RuntimeD4rtException>()),
      );
    }, skip: _posixOnly);
  });
}
