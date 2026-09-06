import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Named constructors on the `dart:convert` bridges (SCB25).
///
/// The defect this file guards against is narrow and invisible to any audit
/// that counts classes: the bridge exists and is registered, so the class is
/// "covered" — only its member list is short. `JsonEncoder.withIndent` was
/// missing for exactly that reason, which left pretty-printing reachable only
/// via `JsonUtf8Encoder(indent)` plus a byte decode.
///
/// The already-present named constructors (`Base64Codec.urlSafe`,
/// `Base64Encoder.urlSafe`, `ClosableStringSink.fromStringSink`) are exercised
/// here too. They were shipped untested, which is the same blind spot one step
/// earlier: nothing would have failed had they been dropped in a refactor.
void main() {
  const String testLibPath = 'd4rt-mem:/json_named_constructors_test.dart';

  dynamic run(String scriptBody) {
    final fullScript =
        '''
      import 'dart:convert';
      main() {
        $scriptBody
      }
    ''';
    return D4rt().execute(
      library: testLibPath,
      name: 'main',
      sources: {testLibPath: fullScript},
    );
  }

  group('JsonEncoder.withIndent (SCB25)', () {
    test('F-SCB25-1: withIndent produces pretty output. [2026-09-03]', () {
      final result = run(r'''
        return JsonEncoder.withIndent('  ').convert({'a': 1})
            .replaceAll('\n', '|');
      ''');
      expect(result, '{|  "a": 1|}');
    });

    test('F-SCB25-2: a null indent selects compact output — so the argument '
        'must be read by position, not by presence. [2026-09-03]', () {
      final result = run('''
        return JsonEncoder.withIndent(null).convert({'a': 1});
      ''');
      expect(result, '{"a":1}');
    });

    test('F-SCB25-3: the optional positional toEncodable is invoked for '
        'unsupported values. [2026-09-03]', () {
      final result = run('''
        final e = JsonEncoder.withIndent(null, (o) => o.toString());
        return e.convert([Duration(seconds: 1)]);
      ''');
      expect(result, '["0:00:01.000000"]');
    });

    test(
      'F-SCB25-4: withIndent indent is exposed as a getter. [2026-09-03]',
      () {
        final result = run(r'''
        return [
          JsonEncoder.withIndent('\t').indent,
          JsonEncoder.withIndent(null).indent,
          JsonEncoder().indent,
        ];
      ''');
        expect(result, ['\t', null, null]);
      },
    );

    test('F-SCB25-5: a non-String indent is rejected. [2026-09-03]', () {
      expect(
        () => run('return JsonEncoder.withIndent(42).convert({});'),
        throwsA(
          predicate(
            (e) => e.toString().contains('indent must be a String or null'),
            'reports that indent must be a String or null',
          ),
        ),
      );
    });

    test('F-SCB25-6: a non-Function toEncodable is rejected. [2026-09-03]', () {
      expect(
        () => run("return JsonEncoder.withIndent(null, 42).convert({});"),
        throwsA(
          predicate(
            (e) =>
                e.toString().contains('toEncodable must be a Function or null'),
            'reports that toEncodable must be a Function or null',
          ),
        ),
      );
    });

    test('F-SCB25-7: withIndent requires the indent argument, matching the '
        'SDK where it is positionally required. [2026-09-03]', () {
      expect(
        () => run('return JsonEncoder.withIndent().convert({});'),
        throwsA(
          predicate(
            (e) => e.toString().contains('requires the indent argument'),
            'reports the missing indent argument',
          ),
        ),
      );
    });
  });

  group('JsonCodec.withReviver (SCB25)', () {
    test('F-SCB25-8: withReviver revives values on decode. [2026-09-03]', () {
      final result = run('''
        final codec = JsonCodec.withReviver((key, value) {
          if (key == "n") return (value as int) * 2;
          return value;
        });
        return codec.decode('{"n":21}');
      ''');
      expect(result, {'n': 42});
    });

    test('F-SCB25-9: withReviver still encodes normally. [2026-09-03]', () {
      final result = run('''
        final codec = JsonCodec.withReviver((key, value) => value);
        return codec.encode({'a': 1});
      ''');
      expect(result, '{"a":1}');
    });

    test(
      'F-SCB25-10: withReviver requires a function argument. [2026-09-03]',
      () {
        expect(
          () => run("return JsonCodec.withReviver(42).decode('1');"),
          throwsA(
            predicate(
              (e) => e.toString().contains('reviver must be a Function'),
              'reports that reviver must be a Function',
            ),
          ),
        );
      },
    );
  });

  group(
    'Already-shipped convert named constructors (SCB25 regression net)',
    () {
      test('F-SCB25-11: Base64Codec.urlSafe uses the URL-safe alphabet. '
          '[2026-09-03]', () {
        // 0xFB 0xFF encodes to "-_8=" url-safe and "+/8=" standard, so the two
        // alphabets are distinguishable from the output alone.
        final result = run('''
        return [
          Base64Codec.urlSafe().encode([251, 255]),
          Base64Codec().encode([251, 255]),
        ];
      ''');
        expect(result, ['-_8=', '+/8=']);
      });

      test('F-SCB25-12: Base64Encoder.urlSafe uses the URL-safe alphabet. '
          '[2026-09-03]', () {
        final result = run('''
        return [
          Base64Encoder.urlSafe().convert([251, 255]),
          Base64Encoder().convert([251, 255]),
        ];
      ''');
        expect(result, ['-_8=', '+/8=']);
      });

      test('F-SCB25-13: ClosableStringSink.fromStringSink wraps a StringSink. '
          '[2026-09-03]', () {
        final result = run('''
        final buffer = StringBuffer();
        final sink = ClosableStringSink.fromStringSink(buffer, () {});
        sink.write('ab');
        sink.writeln('c');
        sink.close();
        return buffer.toString();
      ''');
        expect(result, 'abc\n');
      });
    },
  );
}
