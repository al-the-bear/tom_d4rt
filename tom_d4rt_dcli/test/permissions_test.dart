/// Comprehensive tests for DCli permission operations.
///
/// Tests isReadable, isWritable, isExecutable, chmod functions.
@TestOn('vm')
library;

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Whether upstream dcli can see that this process owns the files it creates.
///
/// dcli (8.4.2 through at least 10.0.0) decides the owner and group branches of
/// `isWritable` / `isReadable` / `isExecutable` by comparing the file's owner
/// with `Shell.current.loggedInUser` — the session's LOGIN name, from
/// `getlogin()` — rather than with the user the process runs as. On macOS a
/// process started outside a login session (VS Code launched from the Dock, a
/// launchd job, anything they spawn) has the login name `root`; on Linux
/// `getlogin()` fails without a controlling terminal and dcli maps that to
/// `root` too. A file the test itself just created, mode 644, then reads as not
/// writable, because only the owner may write it and `root` is not the owner.
///
/// This was measured, not assumed: in such a session `getlogin()` returned
/// `root` while `geteuid()` named the user, and the same tests pass 34/34
/// against a dcli whose `_checkPermission` compares effective ids. The fix
/// belongs upstream — see PR candidate DCLI-1 in
/// `_ai/quests/d4rt/pull-requests.d4rt.todo.md`.
///
/// So the owner-bit tests are skipped exactly when that precondition holds —
/// not by platform. In a login shell they run as before, on any OS.
// `id -un` names the EFFECTIVE user. Windows has no such command, and dcli's
// permission checks are POSIX-only anyway, so there is nothing to compare.
final String? _effectiveUser = Platform.isWindows
    ? Shell.current.loggedInUser
    : 'id -un'.firstLine;
final String? _loginUser = Shell.current.loggedInUser;
final bool _dcliMisidentifiesUser = _loginUser != _effectiveUser;

/// A test whose result depends on dcli recognising this process as the file's
/// owner. See [_dcliMisidentifiesUser].
void ownerTest(String description, dynamic Function() body) => test(
  description,
  body,
  skip: _dcliMisidentifiesUser
      ? 'upstream dcli takes the session login name ($_loginUser) for the '
            'process user ($_effectiveUser); see DCLI-1 in '
            '_ai/quests/d4rt/pull-requests.d4rt.todo.md'
      : null,
);

void main() {
  // The skips above must not outlive the bug. While they are active, this
  // asserts the bug is still there; when an upgraded dcli answers correctly,
  // it fails — delete [ownerTest]'s skip and this test together.
  test(
    'upstream dcli still misreads ownership in this session (tripwire for the '
    'ownerTest skips)',
    () {
      final dir = createTempDir();
      try {
        final path = p.join(dir, 'own.txt');
        touch(path, create: true);
        expect(
          isWritable(path),
          isFalse,
          reason:
              'dcli now recognises the process as the owner even though the '
              'session login name is $_loginUser: remove the ownerTest skip '
              'and this tripwire.',
        );
      } finally {
        deleteDir(dir, recursive: true);
      }
    },
    skip: _dcliMisidentifiesUser
        ? null
        : 'the session login name matches the process user, so the upstream '
              'bug cannot show here',
  );
  late String testDir;

  setUp(() {
    testDir = createTempDir();
  });

  tearDown(() {
    if (exists(testDir)) {
      deleteDir(testDir, recursive: true);
    }
  });

  group('isReadable', () {
    test('returns true for readable file', () {
      final path = p.join(testDir, 'readable.txt');
      touch(path, create: true);

      expect(isReadable(path), isTrue);
    });

    test('returns true for readable directory', () {
      final path = p.join(testDir, 'readable_dir');
      createDir(path);

      expect(isReadable(path), isTrue);
    });

    test('throws for non-existent file', () {
      final path = p.join(testDir, 'nonexistent');

      // DCli permission functions use stat internally which throws on non-existent files
      // Use exists() check before calling permission functions
      expect(exists(path), isFalse);
      expect(() => isReadable(path), throwsA(isA<RunException>()));
    });

    test('handles symlink', () {
      final target = p.join(testDir, 'target.txt');
      final link = p.join(testDir, 'link.txt');
      touch(target, create: true);
      Link(link).createSync(target);

      expect(isReadable(link), isTrue);
    });
  });

  group('isWritable', () {
    ownerTest('returns true for writable file', () {
      final path = p.join(testDir, 'writable.txt');
      touch(path, create: true);

      expect(isWritable(path), isTrue);
    });

    ownerTest('returns true for writable directory', () {
      final path = p.join(testDir, 'writable_dir');
      createDir(path);

      expect(isWritable(path), isTrue);
    });

    test('throws for non-existent file', () {
      final path = p.join(testDir, 'nonexistent');

      // DCli permission functions use stat internally which throws on non-existent files
      expect(exists(path), isFalse);
      expect(() => isWritable(path), throwsA(isA<RunException>()));
    });

    ownerTest('can write to writable file', () {
      final path = p.join(testDir, 'write_test.txt');
      touch(path, create: true);

      expect(isWritable(path), isTrue);

      // Actually write to verify
      path.write('test content');
      expect(read(path).toList().first, equals('test content'));
    });
  });

  group('isExecutable', () {
    test('returns true for executable file', () {
      final path = p.join(testDir, 'script.sh');
      path.write('#!/bin/bash\necho hello');
      'chmod +x $path'.run;

      expect(isExecutable(path), isTrue);
    });

    test('returns false for non-executable file', () {
      final path = p.join(testDir, 'data.txt');
      touch(path, create: true);
      'chmod -x $path'.run;

      expect(isExecutable(path), isFalse);
    });

    test('throws for non-existent file', () {
      final path = p.join(testDir, 'nonexistent');

      // DCli permission functions use stat internally which throws on non-existent files
      expect(exists(path), isFalse);
      expect(() => isExecutable(path), throwsA(isA<RunException>()));
    });

    test('directories are typically executable (traversable)', () {
      final path = p.join(testDir, 'exec_dir');
      createDir(path);

      expect(isExecutable(path), isTrue);
    });
  });

  group('chmod via shell', () {
    test('makes file executable', () {
      final path = p.join(testDir, 'make_exec.sh');
      path.write('#!/bin/bash\necho hello');

      'chmod 755 $path'.run;

      expect(isExecutable(path), isTrue);
    });

    test('removes execute permission', () {
      final path = p.join(testDir, 'remove_exec.sh');
      path.write('#!/bin/bash\necho hello');
      'chmod 755 $path'.run;

      'chmod 644 $path'.run;

      expect(isExecutable(path), isFalse);
    });

    test('makes file read-only', () {
      final path = p.join(testDir, 'readonly.txt');
      touch(path, create: true);

      'chmod 444 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isFalse);

      // Restore for cleanup
      'chmod 644 $path'.run;
    });

    ownerTest('makes file writable', () {
      final path = p.join(testDir, 'writable.txt');
      touch(path, create: true);
      'chmod 444 $path'.run;

      'chmod 644 $path'.run;

      expect(isWritable(path), isTrue);
    });

    ownerTest('handles directory permissions', () {
      final path = p.join(testDir, 'perm_dir');
      createDir(path);

      'chmod 755 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isTrue);
    });

    test('applies recursive permissions', () {
      final path = p.join(testDir, 'recursive');
      createDir(p.join(path, 'sub'), recursive: true);
      touch(p.join(path, 'sub', 'file.txt'), create: true);

      'chmod -R 755 $path'.run;

      expect(isExecutable(path), isTrue);
      expect(isExecutable(p.join(path, 'sub')), isTrue);
    });
  });

  group('stat', () {
    test('gets file stats', () {
      final path = p.join(testDir, 'stat_file.txt');
      path.write('test content');

      final stat = File(path).statSync();

      expect(stat.type, equals(FileSystemEntityType.file));
      expect(stat.size, greaterThan(0));
    });

    test('gets directory stats', () {
      final path = p.join(testDir, 'stat_dir');
      createDir(path);

      final stat = Directory(path).statSync();

      expect(stat.type, equals(FileSystemEntityType.directory));
    });

    test('gets modification time', () {
      final path = p.join(testDir, 'time_file.txt');
      touch(path, create: true);

      final stat = File(path).statSync();

      expect(stat.modified, isA<DateTime>());
      expect(
        stat.modified.isBefore(DateTime.now().add(Duration(seconds: 1))),
        isTrue,
      );
    });

    test('gets access time', () {
      final path = p.join(testDir, 'access_file.txt');
      touch(path, create: true);

      final stat = File(path).statSync();

      expect(stat.accessed, isA<DateTime>());
    });
  });

  group('file ownership', () {
    test('can check current user', () {
      final user = env['USER'];

      expect(user, isNotNull);
      expect(user, isNotEmpty);
    });

    test('files created have current user ownership', () {
      final path = p.join(testDir, 'owned.txt');
      touch(path, create: true);

      // On Unix, we can check ownership via ls -l
      final output = 'ls -l $path'.firstLine;

      expect(output, contains(env['USER'] ?? ''));
    });
  });

  group('permission modes', () {
    ownerTest('mode 644 - rw-r--r--', () {
      final path = p.join(testDir, 'mode644.txt');
      touch(path, create: true);
      'chmod 644 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isFalse);
    });

    ownerTest('mode 755 - rwxr-xr-x', () {
      final path = p.join(testDir, 'mode755.sh');
      touch(path, create: true);
      'chmod 755 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isTrue);
    });

    ownerTest('mode 600 - rw-------', () {
      final path = p.join(testDir, 'mode600.txt');
      touch(path, create: true);
      'chmod 600 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isFalse);
    });

    ownerTest('mode 700 - rwx------', () {
      final path = p.join(testDir, 'mode700.sh');
      touch(path, create: true);
      'chmod 700 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isTrue);
    });
  });

  group('special permissions', () {
    ownerTest('hidden files are accessible', () {
      final path = p.join(testDir, '.hidden');
      touch(path, create: true);

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
    });

    ownerTest('symlink permissions follow target', () {
      final target = p.join(testDir, 'target.txt');
      final link = p.join(testDir, 'link.txt');
      touch(target, create: true);
      'chmod 644 $target'.run;
      Link(link).createSync(target);

      expect(isReadable(link), isTrue);
      expect(isWritable(link), isTrue);
    });
  });

  group('real-world scenarios', () {
    test('create executable script', () {
      final script = p.join(testDir, 'deploy.sh');
      script.write('''
#!/bin/bash
echo "Deploying..."
''');
      'chmod 755 $script'.run;

      expect(isExecutable(script), isTrue);
    });

    ownerTest('create config file with restricted permissions', () {
      final config = p.join(testDir, 'secrets.conf');
      config.write('API_KEY=secret123');
      'chmod 600 $config'.run;

      expect(isReadable(config), isTrue);
      expect(isWritable(config), isTrue);
    });

    test('verify directory traversable', () {
      final dir = p.join(testDir, 'traversable');
      createDir(dir);
      'chmod 755 $dir'.run;

      expect(isExecutable(dir), isTrue); // x on dir means traversable
    });

    ownerTest('check before writing', () {
      final path = p.join(testDir, 'check_write.txt');
      touch(path, create: true);

      if (isWritable(path)) {
        path.write('safe to write');
      }

      expect(read(path).toList().first, equals('safe to write'));
    });
  });
}
