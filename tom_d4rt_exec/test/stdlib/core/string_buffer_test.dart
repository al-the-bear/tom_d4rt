import '../../interpreter_test.dart';
import 'package:test/test.dart';

/// `StringBuffer`'s write surface, as reached from interpreted code.
///
/// Despite the member names, none of this exercises a `StringSink` BRIDGE. A
/// script's `StringBuffer` resolves to `StringBufferCore`, and every `write` /
/// `writeln` / `writeAll` / `writeCharCode` lookup below lands there. The
/// `StringSink` bridge is never consulted, so nothing here would notice if it
/// changed, went missing, or were displaced by a second definition.
///
/// The two properties that DO depend on `StringSink` are pinned elsewhere, and
/// deliberately so:
///
///   * `test/stdlib/io/string_sink_collision_test.dart` — that exactly one
///     registrar owns the name, after the io registrar shipped a second,
///     strictly smaller definition that displaced the core one under last-wins.
///   * `test/stdlib/core/scc77_string_sink_reachability_test.dart` — that the
///     bridge is reachable at all: the `StringBuffer -> StringSink` and
///     `IOSink -> StreamSink, StringSink` supertype edges, member fall-through,
///     and `ClosableStringSink`, which is the only `StringSink` a script obtains
///     that is neither a `StringBuffer` nor an `IOSink`.
///
/// Keep that split in mind before adding a case here: a `StringSink` assertion
/// written against a bare `StringBuffer` pins `StringBufferCore` and reports
/// success for a bridge it never touched.

void main() {
  group('StringBuffer write surface', () {
    test('I-STRING-4: Write. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        StringBuffer buffer = StringBuffer();
        buffer.write("hello");
        return buffer.toString();
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('I-STRING-1: Writeln. [2026-02-10 06:37] (PASS)', () {
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

    test('I-STRING-2: WriteAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        StringBuffer buffer = StringBuffer();
        buffer.writeAll(["hello", "world"], " ");
        return buffer.toString();
      }
      ''';
      expect(execute(source), equals('hello world'));
    });

    test('I-STRING-3: WriteCharCode. [2026-02-10 06:37] (PASS)', () {
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
    test('I-STRING-40: StringBuffer.write. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        buffer.write('Hello');
        buffer.write(' ');
        buffer.write('World');
        return buffer.toString();
      }
      ''';
      final result = execute(source);
      expect(result, equals('Hello World'));
    });

    test('I-STRING-37: StringBuffer.writeln. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        buffer.writeln('Line 1');
        buffer.writeln('Line 2');
        buffer.write('Line 3');
        return buffer.toString();
      }
      ''';
      final result = execute(source);
      expect(result, equals('Line 1\nLine 2\nLine 3'));
    });

    test(
      'I-STRING-38: StringBuffer.writeln with no arguments. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        buffer.write('Before');
        buffer.writeln();
        buffer.write('After');
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        expect(result, equals('Before\nAfter'));
      },
    );

    test(
      'I-STRING-39: StringBuffer.writeAll with a list. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        var items = ['A', 'B', 'C', 'D'];
        buffer.writeAll(items);
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        expect(result, equals('ABCD'));
      },
    );

    test(
      'I-STRING-41: StringBuffer.writeAll with a separator. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        var items = ['Apple', 'Banana', 'Cherry'];
        buffer.writeAll(items, ', ');
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        expect(result, equals('Apple, Banana, Cherry'));
      },
    );

    test(
      'I-STRING-42: StringBuffer.writeCharCode. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        buffer.writeCharCode(72);  // 'H'
        buffer.writeCharCode(101); // 'e'
        buffer.writeCharCode(108); // 'l'
        buffer.writeCharCode(108); // 'l'
        buffer.writeCharCode(111); // 'o'
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        expect(result, equals('Hello'));
      },
    );

    test(
      'I-STRING-43: StringBuffer.write with different data types. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        buffer.write(42);
        buffer.write(' ');
        buffer.write(3.14);
        buffer.write(' ');
        buffer.write(true);
        buffer.write(' ');
        buffer.write(null);
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        expect(result, equals('42 3.14 true null'));
      },
    );

    test(
      'I-STRING-32: StringBuffer.writeAll with mixed types. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        var items = [1, 2.5, 'text', true, null];
        buffer.writeAll(items, '|');
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        expect(result, equals('1|2.5|text|true|null'));
      },
    );

    test(
      'I-STRING-33: StringBuffer, multiple operations in sequence. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        
        // Header
        buffer.writeln('=== Report ===');
        buffer.writeln();
        
        // Content
        buffer.write('Items: ');
        buffer.writeAll(['Item1', 'Item2', 'Item3'], ', ');
        buffer.writeln();
        
        // Numbers
        buffer.write('Numbers: ');
        for (int i = 1; i <= 3; i++) {
          if (i > 1) buffer.write(', ');
          buffer.write(i);
        }
        buffer.writeln();
        
        // Footer
        buffer.writeln();
        buffer.writeCharCode(45); // '-'
        buffer.writeCharCode(45); // '-'
        buffer.writeCharCode(45); // '-'
        buffer.writeln(' END');
        
        return buffer.toString();
      }
      ''';
        final result = execute(source);
        final expected =
            '=== Report ===\n\nItems: Item1, Item2, Item3\nNumbers: 1, 2, 3\n\n--- END\n';
        expect(result, equals(expected));
      },
    );

    test(
      'I-STRING-34: StringBuffer.isEmpty and .isNotEmpty. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        var empty1 = buffer.isEmpty;
        var notEmpty1 = buffer.isNotEmpty;
        
        buffer.write('content');
        var empty2 = buffer.isEmpty;
        var notEmpty2 = buffer.isNotEmpty;
        
        return [empty1, notEmpty1, empty2, notEmpty2];
      }
      ''';
        final result = execute(source);
        expect(result, equals([true, false, false, true]));
      },
    );

    test('I-STRING-35: StringBuffer.length. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        var len1 = buffer.length;
        
        buffer.write('Hello');
        var len2 = buffer.length;
        
        buffer.write(' World');
        var len3 = buffer.length;
        
        return [len1, len2, len3];
      }
      ''';
      final result = execute(source);
      expect(result, equals([0, 5, 11]));
    });

    test('I-STRING-36: StringBuffer.clear. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     import 'dart:core';
     main() {
        var buffer = StringBuffer();
        buffer.write('This will be cleared');
        
        var before = buffer.toString();
        buffer.clear();
        var after = buffer.toString();
        
        buffer.write('New content');
        var final_content = buffer.toString();
        
        return [before, after, final_content];
      }
      ''';
      final result = execute(source);
      expect(result, equals(['This will be cleared', '', 'New content']));
    });
  });
}
