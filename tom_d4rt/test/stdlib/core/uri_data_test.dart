// SC10: dart:core UriData must be bridged.
//
// UriData is what `Uri.dataFromString` / `Uri.dataFromBytes` actually return
// and what `Uri.data` hands back for a `data:` URI. Both Uri constructors were
// already bridged, so before this the interpreter could *produce* a value it
// could not then read — these tests close that loop, including the `Uri.data`
// accessor that makes a parsed data URI reachable at all.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('UriData tests', () {
    test('F-SC10-1: UriData.parse reads mime type and content [2026-07-27]',
        () {
      const source = '''
      main() {
        final d = UriData.parse('data:text/plain;charset=utf-8,Hello%20World');
        return [d.mimeType, d.contentAsString(), d.isBase64];
      }
      ''';
      expect(execute(source), equals(['text/plain', 'Hello World', false]));
    });

    test('F-SC10-2: UriData.fromString round-trips content [2026-07-27]', () {
      const source = '''
      main() {
        final d = UriData.fromString('hello there', mimeType: 'text/plain');
        return [d.contentAsString(), d.mimeType];
      }
      ''';
      expect(execute(source), equals(['hello there', 'text/plain']));
    });

    test('F-SC10-3: base64 encoding is flagged and round-trips [2026-07-27]',
        () {
      const source = '''
      main() {
        final d = UriData.fromString('payload', mimeType: 'text/plain', base64: true);
        return [d.isBase64, d.contentAsString()];
      }
      ''';
      expect(execute(source), equals([true, 'payload']));
    });

    test('F-SC10-4: fromBytes/contentAsBytes round-trip [2026-07-27]', () {
      const source = '''
      main() {
        final d = UriData.fromBytes([1, 2, 3, 250]);
        final bytes = d.contentAsBytes();
        return [bytes.length, bytes[0], bytes[3], d.mimeType];
      }
      ''';
      expect(
          execute(source), equals([4, 1, 250, 'application/octet-stream']));
    });

    test('F-SC10-5: charset and parameters are exposed [2026-07-27]', () {
      const source = '''
      main() {
        final d = UriData.parse('data:text/plain;charset=utf-8,x');
        return [d.charset, d.parameters['charset']];
      }
      ''';
      expect(execute(source), equals(['utf-8', 'utf-8']));
    });

    test('F-SC10-6: the uri getter returns a Uri and Uri.data returns UriData '
        '[2026-07-27]', () {
      // `Uri.data` is the only way to reach a UriData from a parsed URI, so it
      // has to be on the Uri bridge for this class to be usable at all.
      const source = '''
      main() {
        final d = UriData.fromString('abc', mimeType: 'text/plain');
        final u = d.uri;
        final parsed = Uri.parse('data:,round');
        final back = parsed.data;
        return [
          u is Uri,
          u.scheme,
          back is UriData,
          back.contentAsString(),
        ];
      }
      ''';
      expect(execute(source), equals([true, 'data', true, 'round']));
    });

    test('F-SC10-7: Uri.dataFromString produces a readable UriData '
        '[2026-07-27]', () {
      // Closes the produce-but-cannot-read gap directly.
      const source = '''
      main() {
        final u = Uri.dataFromString('made-by-uri', mimeType: 'text/plain');
        final d = u.data;
        return [d is UriData, d.contentAsString(), d.mimeType];
      }
      ''';
      expect(execute(source),
          equals([true, 'made-by-uri', 'text/plain']));
    });

    test('F-SC10-8: UriData works as a declared type and field [2026-07-27]',
        () {
      const source = '''
      class Holder {
        UriData payload = UriData.fromString('held', mimeType: 'text/plain');
        String read() => payload.contentAsString();
      }
      main() {
        UriData local = UriData.parse('data:,local');
        final h = Holder();
        return [local is UriData, local.contentAsString(), h.read()];
      }
      ''';
      expect(execute(source), equals([true, 'local', 'held']));
    });

    test('F-SC10-9: toString returns the data URI text [2026-07-27]', () {
      const source = '''
      main() {
        final d = UriData.parse('data:,plain');
        return d.toString();
      }
      ''';
      expect(execute(source), equals('data:,plain'));
    });
  });
}
