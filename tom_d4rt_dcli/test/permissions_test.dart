/// Comprehensive tests for DCli permission operations.
///
/// Tests isReadable, isWritable, isExecutable, chmod functions.
@TestOn('vm')
library;

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
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
      expect(
        () => isReadable(path),
        throwsA(isA<RunException>()),
      );
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
    test('returns true for writable file', () {
      final path = p.join(testDir, 'writable.txt');
      touch(path, create: true);

      expect(isWritable(path), isTrue);
    });

    test('returns true for writable directory', () {
      final path = p.join(testDir, 'writable_dir');
      createDir(path);

      expect(isWritable(path), isTrue);
    });

    test('throws for non-existent file', () {
      final path = p.join(testDir, 'nonexistent');

      // DCli permission functions use stat internally which throws on non-existent files
      expect(exists(path), isFalse);
      expect(
        () => isWritable(path),
        throwsA(isA<RunException>()),
      );
    });

    test('can write to writable file', () {
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
      expect(
        () => isExecutable(path),
        throwsA(isA<RunException>()),
      );
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

    test('makes file writable', () {
      final path = p.join(testDir, 'writable.txt');
      touch(path, create: true);
      'chmod 444 $path'.run;

      'chmod 644 $path'.run;

      expect(isWritable(path), isTrue);
    });

    test('handles directory permissions', () {
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
      expect(stat.modified.isBefore(DateTime.now().add(Duration(seconds: 1))),
          isTrue);
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
    test('mode 644 - rw-r--r--', () {
      final path = p.join(testDir, 'mode644.txt');
      touch(path, create: true);
      'chmod 644 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isFalse);
    });

    test('mode 755 - rwxr-xr-x', () {
      final path = p.join(testDir, 'mode755.sh');
      touch(path, create: true);
      'chmod 755 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isTrue);
    });

    test('mode 600 - rw-------', () {
      final path = p.join(testDir, 'mode600.txt');
      touch(path, create: true);
      'chmod 600 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isFalse);
    });

    test('mode 700 - rwx------', () {
      final path = p.join(testDir, 'mode700.sh');
      touch(path, create: true);
      'chmod 700 $path'.run;

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
      expect(isExecutable(path), isTrue);
    });
  });

  group('special permissions', () {
    test('hidden files are accessible', () {
      final path = p.join(testDir, '.hidden');
      touch(path, create: true);

      expect(isReadable(path), isTrue);
      expect(isWritable(path), isTrue);
    });

    test('symlink permissions follow target', () {
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

    test('create config file with restricted permissions', () {
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

    test('check before writing', () {
      final path = p.join(testDir, 'check_write.txt');
      touch(path, create: true);

      if (isWritable(path)) {
        path.write('safe to write');
      }

      expect(read(path).toList().first, equals('safe to write'));
    });
  });
}
