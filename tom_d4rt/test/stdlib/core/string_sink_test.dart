import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('StringSink methods - comprehensive', () {
    test('write [2026-02-10 06:37]', () {
      const source = '''
      main() {
        StringBuffer buffer = StringBuffer();
        buffer.write("hello");
        return buffer.toString();
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('writeln [2026-02-10 06:37]', () {
      const source = '''
      main() {
        StringBuffer buffer = StringBuffer();
        buffer.writeln("hello");
        buffer.writeln("world");
        return buffer.toString();
      }
      ''';
      expect(execute(source), equals('hello\nworld\n'));
    });

    test('writeAll [2026-02-10 06:37]', () {
      const source = '''
      main() {
        StringBuffer buffer = StringBuffer();
        buffer.writeAll(["hello", "world"], " ");
        return buffer.toString();
      }
      ''';
      expect(execute(source), equals('hello world'));
    });

    test('writeCharCode [2026-02-10 06:37]', () {
      const source = '''
      main() {
        StringBuffer buffer = StringBuffer();
        buffer.writeCharCode(104); // 'h'
        buffer.writeCharCode(101); // 'e'
        buffer.writeCharCode(108); // 'l'
        buffer.writeCharCode(108); // 'l'
        buffer.writeCharCode(111); // 'o'
        return buffer.toString();
      }
      ''';
      expect(execute(source), equals('hello'));
    });
  });
}
