import '../../interpreter_test.dart';
import 'package:test/test.dart';
import 'dart:io'; // Need dart:io for File, Directory, etc.

void main() {
  group('FileSystemEntity methods - comprehensive', () {
    test('I-FILE-148: ExistsSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_148.txt");
        file.writeAsStringSync("Hello, world!");
        var exists1 = file.existsSync();
        file.deleteSync();
        var exists2 = file.existsSync();
        return [exists1, exists2];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-FILE-144: DeleteSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_144.txt");
        file.writeAsStringSync("Hello, world!");
        file.deleteSync();
        return file.existsSync();
      }
      ''';
      expect(execute(source), isFalse);
    });

    test('I-FILE-145: RenameSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_145.txt");
        file.writeAsStringSync("Hello, world!");
        File renamedFile = file.renameSync(file.path + "_renamed");
        var exists = renamedFile.existsSync();
        renamedFile.deleteSync();
        return exists;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-FILE-146: Absolute. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_146.txt");
        file.writeAsStringSync("Hello, world!");
        var path = file.absolute.path;
        file.deleteSync();
        return path;
      }
      ''';
      expect(execute(source), isA<String>());
    });

    test('I-FILE-147: Parent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_147.txt");
        file.writeAsStringSync("Hello, world!");
        var path = file.parent.path;
        file.deleteSync();
        return path;
      }
      ''';
      expect(execute(source), isA<String>());
      expect(execute(source), equals(Directory.systemTemp.path));
    });

    test('I-FILE-149: StatSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_149.txt");
        file.writeAsStringSync("Hello, world!");
        var type = file.statSync().type;
        file.deleteSync();
        return type.toString();
      }
      ''';
      expect(execute(source), equals('file'));
    });

    test('I-FILE-150: ResolveSymbolicLinksSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_150.txt");
        file.writeAsStringSync("Hello, world!");
        var path = file.resolveSymbolicLinksSync();
        file.deleteSync();
        return path;
      }
      ''';
      expect(execute(source), isA<String>());
    });
  });
}
