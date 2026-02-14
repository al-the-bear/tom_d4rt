import '../../interpreter_test.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('File methods - comprehensive', () {
    test('I-FILE-157: ExistsSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_157.txt");
        file.writeAsStringSync("Hello, world!");
        var exists1 = file.existsSync();
        file.deleteSync();
        var exists2 = file.existsSync();
        return [exists1, exists2];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-FILE-1: WriteAsStringSync and readAsStringSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_1.txt");
        file.writeAsStringSync("Hello, world!");
        var content = file.readAsStringSync();
        file.deleteSync();
        return content;
      }
      ''';
      expect(execute(source), equals('Hello, world!'));
    });

    test('I-FILE-154: DeleteSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_154.txt");
        file.writeAsStringSync("Hello, world!");
        file.deleteSync();
        return file.existsSync();
      }
      ''';
      expect(execute(source), isFalse);
    });

    test('I-FILE-155: RenameSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_155.txt");
        file.writeAsStringSync("Hello, world!");
        File renamedFile = file.renameSync(file.path + "_renamed");
        var exists = renamedFile.existsSync();
        renamedFile.deleteSync();
        return exists;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-FILE-156: CopySync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_156.txt");
        file.writeAsStringSync("Hello, world!");
        File copiedFile = file.copySync(file.path + "_copy");
        var exists = copiedFile.existsSync();
        file.deleteSync();
        copiedFile.deleteSync();
        return exists;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-FILE-158: LengthSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_158.txt");
        file.writeAsStringSync("Hello, world!");
        var length = file.lengthSync();
        file.deleteSync();
        return length;
      }
      ''';
      expect(execute(source), equals(13));
    });

    test('I-FILE-159: LastModifiedSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_159.txt");
        file.writeAsStringSync("Hello, world!");
        var lastModified = file.lastModifiedSync();
        file.deleteSync();
        return lastModified;
      }
      ''';
      expect(execute(source), isA<DateTime>());
    });

    test('I-FILE-151: ResolveSymbolicLinksSync. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_151.txt");
        file.writeAsStringSync("Hello, world!");
        var path = file.resolveSymbolicLinksSync();
        file.deleteSync();
        return path;
      }
      ''';
      expect(execute(source), isA<String>());
    });

    test('I-FILE-152: Absolute. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_152.txt");
        file.writeAsStringSync("Hello, world!");
        var path = file.absolute.path;
        file.deleteSync();
        return path;
      }
      ''';
      expect(execute(source), isA<String>());
      expect((execute(source) as String).contains('/test_152.txt'), isTrue);
    });

    test('I-FILE-153: Parent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:io';
     main() {
        File file = File(Directory.systemTemp.path + "/test_153.txt");
        file.writeAsStringSync("Hello, world!");
        var path = file.parent.path;
        file.deleteSync();
        return path;
      }
      ''';
      expect(execute(source), isA<String>());
      expect(execute(source), equals(Directory.systemTemp.path));
    });
  });
}
