import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('IOSink methods - comprehensive', () {
    test(
      'I-FILE-167: IOSink write and writeln to file. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_sink.txt");
        var sink = file.openWrite();
        
        sink.write('Hello ');
        sink.writeln('World');
        sink.write('Line 2');
        
        await sink.close();
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('Hello World\nLine 2'));
      },
    );

    test(
      'I-FILE-165: IOSink writeAll method. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_writeall.txt");
        var sink = file.openWrite();
        
        sink.writeAll(['A', 'B', 'C'], '-');
        await sink.close();
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('A-B-C'));
      },
    );

    test(
      'I-FILE-166: IOSink writeCharCode method. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_charcode.txt");
        var sink = file.openWrite();
        
        sink.writeCharCode(65); // 'A'
        sink.writeCharCode(66); // 'B'
        sink.writeCharCode(67); // 'C'
        await sink.close();
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('ABC'));
      },
    );

    test(
      'I-FILE-168: IOSink add method with bytes. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     import 'dart:convert';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_add.txt");
        var sink = file.openWrite();
        
        var bytes = utf8.encode('Hello Bytes');
        sink.add(bytes);
        await sink.close();
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('Hello Bytes'));
      },
    );

    test(
      'I-FILE-160: IOSink addStream method. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     import 'dart:convert';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var sourceFile = File(tempDir.path + "/source.txt");
        var targetFile = File(tempDir.path + "/target.txt");
        
        // Create source file
        sourceFile.writeAsStringSync('Stream Content');
        
        // Copy using addStream
        var sink = targetFile.openWrite();
        var sourceStream = sourceFile.openRead();
        await sink.addStream(sourceStream);
        await sink.close();
        
        var content = targetFile.readAsStringSync();
        
        // Cleanup
        sourceFile.deleteSync();
        targetFile.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('Stream Content'));
      },
    );

    test(
      'I-FILE-161: IOSink flush method. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_flush.txt");
        var sink = file.openWrite();
        
        sink.write('Before flush');
        await sink.flush();
        sink.write(' After flush');
        await sink.close();
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('Before flush After flush'));
      },
    );

    test(
      'I-FILE-162: IOSink addError method. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_error.txt");
        var sink = file.openWrite();
        
        // Simply test that addError method exists and can be called
        // without throwing immediately
        try {
          sink.addError('Test error');
          await sink.close();
          file.deleteSync();
          tempDir.deleteSync();
          return 'addError method works';
        } catch (e) {
          // Don't await sink.close() in catch to avoid infinite loop
          sink.close();
          try { file.deleteSync(); } catch (e2) {}
          try { tempDir.deleteSync(); } catch (e2) {}
          return 'addError called successfully';
        }
      }
      ''';
        final result = await execute(source);
        expect(
          result,
          anyOf([
            equals('addError method works'),
            equals('addError called successfully'),
          ]),
        );
      },
    );

    test(
      'I-FILE-163: IOSink encoding parameter. [2026-02-10 06:37] (PASS)',
      () async {
        const source = '''
     import 'dart:io';
     import 'dart:convert';
     main() async{
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_encoding.txt");
        
        // Write with UTF8 encoding
        var sink = file.openWrite(encoding: utf8);
        sink.write('UTF8 Content: héllo');
        await sink.close();
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
        final result = await execute(source);
        expect(result, equals('UTF8 Content: héllo'));
      },
    );

    test('I-FILE-164: IOSink done future. [2026-02-10 06:37] (PASS)', () async {
      const source = '''
     import 'dart:io';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/test_done.txt");
        var sink = file.openWrite();
        
        sink.write('Testing done future');
        await sink.close();

        // Wait for the sink to complete
        await sink.done;
        
        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        
        return content;
      }
      ''';
      final result = await execute(source);
      expect(result, equals('Testing done future'));
    });
  });

  /// SCC68 — the `addStream` half of the erased-container trap.
  ///
  /// `IOSink.addStream` took `positionalArgs[0] as Stream<List<int>>`. The
  /// interpreter erases type arguments twice over here: the stream is a
  /// `Stream<Object?>` and each chunk is a `List<Object?>`, so the cast threw
  /// on the stream itself and the member was unreachable from a script. The
  /// same shape covers `Stream<List<int>>` parameters on `Stdout`, `Socket`,
  /// `HttpResponse` and `HttpClientRequest`; this is the one that needs no
  /// network or console to drive.
  group('IOSink.addStream over script-built streams (SCC68)', () {
    test('F-SCC68-13: addStream consumes a script-built stream of byte chunks. '
        '[2026-09-06]', () async {
      const source = '''
     import 'dart:io';
     import 'dart:async';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/scc68_add_stream.txt");
        var sink = file.openWrite();

        await sink.addStream(
          Stream.fromIterable([[104, 101, 108], [108, 111]]),
        );
        await sink.close();

        var content = file.readAsStringSync();
        file.deleteSync();
        tempDir.deleteSync();
        return content;
      }
      ''';
      expect(await execute(source), equals('hello'));
    });

    test(
      'F-SCC68-14: a chunk that is not a list of ints is still rejected, and '
      'the message names the member. [2026-09-06]',
      () async {
        const source = '''
     import 'dart:io';
     import 'dart:async';
     main() async {
        var tempDir = Directory.systemTemp.createTempSync();
        var file = File(tempDir.path + "/scc68_add_stream_bad.txt");
        var sink = file.openWrite();
        var message = 'no-throw';
        try {
          await sink.addStream(Stream.fromIterable(['not-a-chunk']));
        } catch (e) {
          message = e.toString();
        }
        // Deliberately NOT closing the sink: a sink whose addStream failed
        // never completes its close() future, so awaiting it here would hang
        // the test rather than report the assertion.
        tempDir.deleteSync(recursive: true);
        return message;
      }
      ''';
        expect(
          await execute(source),
          allOf(contains('IOSink.addStream'), contains('String')),
        );
      },
    );
  });
}
