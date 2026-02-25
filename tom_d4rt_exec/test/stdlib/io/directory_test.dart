import '../../interpreter_test.dart';
import 'package:test/test.dart';
import 'dart:io'; // Import dart:io

void main() {
  group('Directory methods - comprehensive', () {
    test('I-FILE-142: ExistsSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        var result1, result2;
        try {
        result1 = dir.existsSync();
          dir.deleteSync();
        result2 = dir.existsSync();
        } finally {
          if (dir.existsSync()) dir.deleteSync(); // Cleanup if needed
        }
        return [result1, result2];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-FILE-139: CreateSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        Directory newDir = Directory(dir.path + "/newDir");
        var newDirExists;
        try {
          newDir.createSync();
        newDirExists = newDir.existsSync();
        } finally {
          if (newDir.existsSync()) newDir.deleteSync();
          if (dir.existsSync()) dir.deleteSync();
        }
        return newDirExists;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-FILE-140: DeleteSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        var existsAfterDelete;
        try {
          dir.deleteSync();
        existsAfterDelete = dir.existsSync();
        } finally {
           if (dir.existsSync()) dir.deleteSync(); // Cleanup if needed
        }
        return existsAfterDelete;
      }
      ''';
      expect(execute(source), isFalse);
    });

    test('I-FILE-141: ListSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        List<String> paths = [];
        try {
          File file = File(dir.path + "/test.txt");
          file.writeAsStringSync("Hello, world!");
          paths = dir.listSync().map((e) => e.path).toList();
        } finally {
          // Cleanup files and directory
          if (dir.existsSync()) {
             try { dir.deleteSync(recursive: true); } catch (e) {}
          }
        }
        return paths;
      }
      ''';
      // Check that listSync returns a list containing the path of the created file
      final result = execute(source) as List;
      expect(result, isA<List>());
      expect(result.length, equals(1));
      expect((result[0] as String), endsWith('/test.txt'));
    });

    test('I-FILE-143: RenameSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        Directory renamedDir = Directory(dir.path + "_renamed");
        var renamedExists;
        try {
          dir.renameSync(renamedDir.path);
        renamedExists = renamedDir.existsSync();
        } finally {
          if (dir.existsSync()) dir.deleteSync();
          if (renamedDir.existsSync()) renamedDir.deleteSync();
        }
        return renamedExists;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-FILE-136: Absolute. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        String? path;
        try {
          path = dir.absolute.path;
        } finally {
          dir.deleteSync();
        }
        return path;
      }
      ''';
      final result = execute(source);
      expect(result, isA<String>());
      expect((result as String).isNotEmpty, isTrue);
      expect((result).startsWith('/'), isTrue);
    });

    test('I-FILE-137: Parent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        String? path;
        try {
          path = dir.parent.path;
        } finally {
          dir.deleteSync();
        }
        return path;
      }
      ''';
      final result = execute(source);
      expect(result, isA<String>());
      expect((result as String).isNotEmpty, isTrue);
      expect(result, equals(Directory.systemTemp.path));
    });

    test('I-FILE-138: ResolveSymbolicLinksSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:io';
      main() {
        Directory dir = Directory.systemTemp.createTempSync();
        String? path;
        try {
          path = dir.resolveSymbolicLinksSync();
        } finally {
          dir.deleteSync();
        }
        return path;
      }
      ''';
      final result = execute(source);
      expect(result, isA<String>());
      expect((result as String).isNotEmpty, isTrue);
    });
  });
}
