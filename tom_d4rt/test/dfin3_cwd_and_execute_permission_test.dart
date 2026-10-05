// DFIN3: the working directory and the execute flag are permission-checked.
//
// `Directory.current = x` was unchecked, so a script could move the process
// working directory out from under every relative-path grant, process-wide.
// FilesystemPermission's `execute` flag was read by `allows()` but every
// producer hard-coded `'execute': false`, so it gated nothing; and the process
// gate dropped the command and its arguments, so a command-scoped
// ProcessRunPermission allowed nothing either. The rule now: a process starts
// when a ProcessRunPermission covers the command and its arguments, OR a
// FilesystemPermission with execute covers the executable.
//
// Twin: tom_d4rt_exec ports this file verbatim.
import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// `/bin/echo` and friends exist on the macOS and Linux fleet hosts; the
/// process cases are skipped on Windows, where the executable differs.
final _onPosix = !io.Platform.isWindows;

String _echoPath() {
  for (final candidate in ['/bin/echo', '/usr/bin/echo']) {
    final f = io.File(candidate);
    if (f.existsSync()) return f.resolveSymbolicLinksSync();
  }
  throw StateError('no echo binary');
}

void main() {
  group('DFIN3: Directory.current', () {
    late io.Directory saved;
    late io.Directory root;

    setUp(() {
      saved = io.Directory.current;
      root = io.Directory(
        io.Directory.systemTemp
            .createTempSync('dfin3_cwd_')
            .resolveSymbolicLinksSync(),
      );
      io.Directory('${root.path}/inside').createSync();
      io.Directory('${root.path}/outside').createSync();
    });

    tearDown(() {
      io.Directory.current = saved;
      if (root.existsSync()) root.deleteSync(recursive: true);
    });

    test('DFIN3-1: setting the working directory outside every write grant '
        'is refused, and the directory does not move [2026-10-03]', () {
      final d4rt = D4rt()
        ..grant(FilesystemPermission.readPath(root.path))
        ..grant(FilesystemPermission.writePath('${root.path}/inside'));
      expect(
        () => d4rt.execute(
          source:
              '''
import 'dart:io';
void main() { Directory.current = '${root.path}/outside'; }
''',
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('change the working directory'),
          ),
        ),
      );
      expect(io.Directory.current.path, saved.path);
    });

    test('DFIN3-2: a write grant on the target allows it [2026-10-03]', () {
      // The target is the directory the process is ALREADY in: the working
      // directory is process-wide and `dart test` runs other files in this
      // process concurrently, so actually moving it would break their
      // relative paths. Setting it in place still passes through the gate.
      final here = saved.resolveSymbolicLinksSync();
      final d4rt = D4rt()..grant(FilesystemPermission.writePath(here));
      d4rt.execute(
        source:
            '''
import 'dart:io';
void main() { Directory.current = Directory('$here'); }
''',
      );
      expect(io.Directory.current.resolveSymbolicLinksSync(), here);
    });
  });

  group('DFIN3: process execution', () {
    String run(D4rt d4rt, String executable) =>
        d4rt.execute(
              source:
                  '''
import 'dart:io';
String main() => Process.runSync('$executable', ['hi']).stdout.toString().trim();
''',
            )
            as String;

    test('DFIN3-3: FilesystemPermission.executePath on the binary allows it, '
        'with no ProcessRunPermission [2026-10-03]', () {
      final echo = _echoPath();
      final d4rt = D4rt()
        ..grant(FilesystemPermission.executePath(io.File(echo).parent.path));
      expect(run(d4rt, echo), 'hi');
    }, skip: _onPosix ? null : 'POSIX echo binary');

    test('DFIN3-4: a bare command resolves through PATH for the execute '
        'check [2026-10-03]', () {
      final echo = _echoPath();
      final d4rt = D4rt()
        ..grant(FilesystemPermission.executePath(io.File(echo).parent.path));
      expect(run(d4rt, 'echo'), 'hi');
    }, skip: _onPosix ? null : 'POSIX echo binary');

    test('DFIN3-5: an execute grant elsewhere does not allow it '
        '[2026-10-03]', () {
      final d4rt = D4rt()
        ..grant(FilesystemPermission.executePath('/nonexistent-dfin3'));
      expect(
        () => run(d4rt, _echoPath()),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('ProcessRunPermission'),
          ),
        ),
      );
    }, skip: _onPosix ? null : 'POSIX echo binary');

    test('DFIN3-6: read and write grants alone do not allow it '
        '[2026-10-03]', () {
      final d4rt = D4rt()
        ..grant(FilesystemPermission.read)
        ..grant(FilesystemPermission.write);
      expect(
        () => run(d4rt, _echoPath()),
        throwsA(isA<RuntimeD4rtException>()),
      );
    }, skip: _onPosix ? null : 'POSIX echo binary');

    test('DFIN3-7: a command-scoped ProcessRunPermission now allows its '
        'command, and only it [2026-10-03]', () {
      final d4rt = D4rt()..grant(ProcessRunPermission.command('echo'));
      expect(run(d4rt, 'echo'), 'hi');
      expect(() => run(d4rt, 'printf'), throwsA(isA<RuntimeD4rtException>()));
    }, skip: _onPosix ? null : 'POSIX echo binary');

    test(
      'DFIN3-8: commandWithArgs checks the arguments [2026-10-03]',
      () {
        final allowed = D4rt()
          ..grant(ProcessRunPermission.commandWithArgs('echo', ['hi']));
        expect(run(allowed, 'echo'), 'hi');
        final other = D4rt()
          ..grant(ProcessRunPermission.commandWithArgs('echo', ['bye']));
        expect(() => run(other, 'echo'), throwsA(isA<RuntimeD4rtException>()));
      },
      skip: _onPosix ? null : 'POSIX echo binary',
    );
  });
}
