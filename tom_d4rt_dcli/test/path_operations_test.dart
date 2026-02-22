/// Comprehensive tests for DCli path operations.
///
/// Tests truepath, join, dirname, basename, extension, relative functions.
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

  group('truepath', () {
    test('expands relative path', () {
      final path = 'file.txt';

      final result = truepath(path);

      expect(result, isNot(equals(path)));
      expect(result, contains('file.txt'));
      expect(p.isAbsolute(result), isTrue);
    });

    test('treats ~ as literal character (no shell expansion)', () {
      // truepath does NOT expand ~ - it just makes path absolute
      final result = truepath('~');

      // ~ is treated as a literal directory name
      expect(p.isAbsolute(result), isTrue);
      expect(result, endsWith('~'));
    });

    test('treats ~/subfolder as literal (no shell expansion)', () {
      // truepath does NOT expand ~ - use HOME constant instead
      final result = truepath('~/Documents');

      // ~/Documents is treated as literal path
      expect(p.isAbsolute(result), isTrue);
      expect(result, contains('~/Documents'));
    });

    test('normalizes path separators', () {
      final result = truepath('dir//subdir///file.txt');

      expect(result, isNot(contains('//')));
    });

    test('handles absolute path', () {
      final path = '/absolute/path/file.txt';

      final result = truepath(path);

      expect(result, equals(path));
    });

    test('removes trailing slashes', () {
      final result = truepath('/path/to/dir/');

      expect(result, isNot(endsWith('/')));
    });

    test('handles . and .. segments', () {
      final result = truepath('/path/./to/../file.txt');

      expect(result, isNot(contains('./')));
      expect(result, isNot(contains('..')));
    });

    test('accepts multiple path parts', () {
      final result = truepath('a', 'b', 'c');

      expect(result, contains('a'));
      expect(result, contains('b'));
      expect(result, contains('c'));
    });
  });

  group('join', () {
    test('joins two path segments', () {
      final result = p.join('dir', 'file.txt');

      expect(result, equals('dir${Platform.pathSeparator}file.txt'));
    });

    test('joins multiple segments', () {
      final result = p.join('a', 'b', 'c', 'd');

      expect(
          result,
          equals('a${Platform.pathSeparator}b${Platform.pathSeparator}'
              'c${Platform.pathSeparator}d'));
    });

    test('handles empty segments', () {
      final result = p.join('dir', '', 'file.txt');

      expect(result, contains('dir'));
      expect(result, contains('file.txt'));
    });

    test('handles absolute segments', () {
      final result = p.join('relative', '/absolute');

      // Absolute segment replaces previous segments
      expect(result, equals('/absolute'));
    });

    test('handles trailing separators', () {
      final result = p.join('dir/', 'file.txt');

      expect(result, equals('dir/file.txt'));
    });
  });

  group('dirname', () {
    test('returns parent directory', () {
      final result = p.dirname('/path/to/file.txt');

      expect(result, equals('/path/to'));
    });

    test('returns . for filename only', () {
      final result = p.dirname('file.txt');

      expect(result, equals('.'));
    });

    test('returns / for root directory file', () {
      final result = p.dirname('/file.txt');

      expect(result, equals('/'));
    });

    test('strips trailing filename', () {
      final result = p.dirname('/a/b/c/d');

      expect(result, equals('/a/b/c'));
    });

    test('handles paths with trailing slash', () {
      final result = p.dirname('/path/to/dir/');

      expect(result, equals('/path/to'));
    });
  });

  group('basename', () {
    test('returns filename from path', () {
      final result = p.basename('/path/to/file.txt');

      expect(result, equals('file.txt'));
    });

    test('returns filename with extension', () {
      final result = p.basename('dir/file.dart');

      expect(result, equals('file.dart'));
    });

    test('handles path without directory', () {
      final result = p.basename('file.txt');

      expect(result, equals('file.txt'));
    });

    test('returns directory name for path ending in dir', () {
      final result = p.basename('/path/to/dir');

      expect(result, equals('dir'));
    });

    test('handles paths with multiple extensions', () {
      final result = p.basename('file.tar.gz');

      expect(result, equals('file.tar.gz'));
    });
  });

  group('extension', () {
    test('returns file extension with dot', () {
      final result = p.extension('file.txt');

      expect(result, equals('.txt'));
    });

    test('returns last extension for multiple', () {
      final result = p.extension('file.tar.gz');

      expect(result, equals('.gz'));
    });

    test('returns empty for no extension', () {
      final result = p.extension('Makefile');

      expect(result, equals(''));
    });

    test('handles hidden files', () {
      final result = p.extension('.gitignore');

      expect(result, equals(''));
    });

    test('handles hidden files with extension', () {
      final result = p.extension('.hidden.txt');

      expect(result, equals('.txt'));
    });

    test('returns multiple extensions with level param', () {
      final result = p.extension('file.tar.gz', 2);

      expect(result, equals('.tar.gz'));
    });
  });

  group('relative', () {
    test('creates relative path from absolute', () {
      final base = '/home/user/projects';
      final path = '/home/user/projects/app/main.dart';

      final result = p.relative(path, from: base);

      expect(result, equals('app${Platform.pathSeparator}main.dart'));
    });

    test('handles same directory', () {
      final base = '/home/user';
      final path = '/home/user';

      final result = p.relative(path, from: base);

      expect(result, equals('.'));
    });

    test('handles parent directory', () {
      final base = '/home/user/projects';
      final path = '/home/user';

      final result = p.relative(path, from: base);

      expect(result, equals('..'));
    });

    test('handles sibling directory', () {
      final base = '/home/user/projects';
      final path = '/home/user/documents';

      final result = p.relative(path, from: base);

      expect(result, equals('..${Platform.pathSeparator}documents'));
    });
  });

  group('absolute', () {
    test('returns absolute path for relative', () {
      final result = p.absolute('file.txt');

      expect(p.isAbsolute(result), isTrue);
    });

    test('returns same path for absolute', () {
      final path = '/absolute/path';

      final result = p.absolute(path);

      expect(result, equals(path));
    });
  });

  group('normalize', () {
    test('removes double slashes', () {
      final result = p.normalize('dir//file.txt');

      expect(result, equals('dir${Platform.pathSeparator}file.txt'));
    });

    test('resolves . segments', () {
      final result = p.normalize('dir/./file.txt');

      expect(result, equals('dir${Platform.pathSeparator}file.txt'));
    });

    test('resolves .. segments', () {
      final result = p.normalize('dir/sub/../file.txt');

      expect(result, equals('dir${Platform.pathSeparator}file.txt'));
    });

    test('handles trailing separator', () {
      final result = p.normalize('dir/subdir/');

      expect(result, equals('dir${Platform.pathSeparator}subdir'));
    });
  });

  group('isAbsolute', () {
    test('returns true for absolute path', () {
      expect(p.isAbsolute('/absolute/path'), isTrue);
    });

    test('returns false for relative path', () {
      expect(p.isAbsolute('relative/path'), isFalse);
    });

    test('returns false for empty string', () {
      expect(p.isAbsolute(''), isFalse);
    });

    test('handles ~ as relative', () {
      expect(p.isAbsolute('~'), isFalse);
    });
  });

  group('isRelative', () {
    test('returns false for absolute path', () {
      expect(p.isRelative('/absolute/path'), isFalse);
    });

    test('returns true for relative path', () {
      expect(p.isRelative('relative/path'), isTrue);
    });
  });

  group('split', () {
    test('splits path into components', () {
      final result = p.split('/home/user/file.txt');

      expect(result, equals(['/', 'home', 'user', 'file.txt']));
    });

    test('splits relative path', () {
      final result = p.split('dir/subdir/file.txt');

      expect(result, equals(['dir', 'subdir', 'file.txt']));
    });

    test('handles single component', () {
      final result = p.split('file.txt');

      expect(result, equals(['file.txt']));
    });
  });

  group('withoutExtension', () {
    test('removes extension from path', () {
      final result = p.withoutExtension('file.txt');

      expect(result, equals('file'));
    });

    test('removes only last extension', () {
      final result = p.withoutExtension('file.tar.gz');

      expect(result, equals('file.tar'));
    });

    test('handles no extension', () {
      final result = p.withoutExtension('Makefile');

      expect(result, equals('Makefile'));
    });

    test('preserves directory path', () {
      final result = p.withoutExtension('/path/to/file.txt');

      expect(result, equals('/path/to/file'));
    });
  });

  group('setExtension', () {
    test('adds extension to path', () {
      final result = p.setExtension('file', '.txt');

      expect(result, equals('file.txt'));
    });

    test('replaces existing extension', () {
      final result = p.setExtension('file.txt', '.dart');

      expect(result, equals('file.dart'));
    });

    test('handles empty new extension', () {
      final result = p.setExtension('file.txt', '');

      expect(result, equals('file'));
    });
  });

  group('real-world scenarios', () {
    test('build output path from source', () {
      final source = '/project/lib/src/feature/component.dart';
      final outputDir = '/project/build/output';

      final filename = p.basenameWithoutExtension(source);
      final output = p.join(outputDir, '$filename.js');

      expect(output, equals('/project/build/output/component.js'));
    });

    test('resolve config file relative to project', () {
      final projectDir = '/project';
      final configPath = 'config/settings.yaml';

      final resolved = p.join(projectDir, configPath);

      expect(resolved, equals('/project/config/settings.yaml'));
    });

    test('create backup filename', () {
      final original = '/data/important.dat';
      final ext = p.extension(original);
      final base = p.withoutExtension(original);
      final backup = '$base.backup$ext';

      expect(backup, equals('/data/important.backup.dat'));
    });
  });
}
