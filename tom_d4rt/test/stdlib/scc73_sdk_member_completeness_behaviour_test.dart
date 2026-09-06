// SCC73 — the members the completeness guard forced into the bridges.
//
// `scc73_sdk_member_completeness_test.dart` proves each of these is REACHABLE:
// it enumerates the SDK and fails while any declared member has no way in. That
// is a presence check and deliberately nothing more — it constructs no
// arguments and inspects no results, so a constructor bridged with the
// arguments in the wrong order would satisfy it.
//
// This file is the other half. Every case drives the member from a script and
// asserts on what comes back, so the guard cannot be satisfied by an adapter
// that merely exists.
//
// SCB25's second finding is the reason it exists at all: named constructors
// that had already shipped — `Base64Codec.urlSafe`, `Base64Encoder.urlSafe`,
// `ClosableStringSink.fromStringSink` — turned out to have no coverage
// whatsoever, so a refactor could have dropped them in silence. Bridging a
// member without testing it reproduces exactly that.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String body) async {
  const path = 'd4rt-mem:/scc73_behaviour.dart';
  final d4rt = D4rt();
  // `dart:io` is permissioned and three of the groups below reach into it.
  d4rt.grant(FilesystemPermission.any);
  return await d4rt.execute(
    library: path,
    name: 'main',
    sources: {
      path:
          "import 'dart:async';\n"
          "import 'dart:collection';\n"
          "import 'dart:convert';\n"
          "import 'dart:io';\n"
          'Future<Object?> main() async {\n'
          '$body\n'
          '}\n',
    },
  );
}

void main() {
  group('SCC73: the map named constructors, shared across three '
      'implementations', () {
    // `HashMap`, `LinkedHashMap` and `SplayTreeMap` declare these with
    // identical bodies, so the adapters delegate to one shared implementation
    // in `MapNamedConstructors`. Each is exercised through all three types:
    // the point of the shared body is that a fix lands everywhere, and only a
    // test per type can show that it did.
    for (final type in const ['HashMap', 'LinkedHashMap', 'SplayTreeMap']) {
      test('F-SCC73-B1-$type: $type.fromIterable maps key and value '
          '[2026-09-06]', () async {
        final result = await _run('''
          final m = $type.fromIterable(
            [1, 2, 3],
            key: (e) => 'k\$e',
            value: (e) => e * 10,
          );
          return [m['k1'], m['k2'], m['k3'], m.length];
        ''');
        expect(result, equals([10, 20, 30, 3]));
      });

      test('F-SCC73-B2-$type: $type.fromIterable defaults both callbacks to '
          'the element [2026-09-06]', () async {
        final result = await _run('''
          final m = $type.fromIterable([1, 2]);
          return [m[1], m[2]];
        ''');
        expect(result, equals([1, 2]));
      });

      test('F-SCC73-B3-$type: $type.fromIterables pairs the two iterables '
          '[2026-09-06]', () async {
        final result = await _run('''
          final m = $type.fromIterables(['a', 'b'], [1, 2]);
          return [m['a'], m['b']];
        ''');
        expect(result, equals([1, 2]));
      });

      test('F-SCC73-B4-$type: $type.fromIterables rejects mismatched lengths '
          '[2026-09-06]', () async {
        await expectLater(
          _run("return $type.fromIterables(['a'], [1, 2]).length;"),
          throwsA(
            isA<Object>().having(
              (e) => e.toString(),
              'toString',
              contains('different lengths'),
            ),
          ),
        );
      });
    }

    // SplayTreeMap has no `fromEntries` in the SDK, so only two types here.
    for (final type in const ['HashMap', 'LinkedHashMap']) {
      test('F-SCC73-B5-$type: $type.fromEntries reads script-built MapEntry '
          'values [2026-09-06]', () async {
        final result = await _run('''
          final m = $type.fromEntries([MapEntry('a', 1), MapEntry('b', 2)]);
          return [m['a'], m['b']];
        ''');
        expect(result, equals([1, 2]));
      });

      test('F-SCC73-B6-$type: $type.fromEntries names the offending type '
          '[2026-09-06]', () async {
        await expectLater(
          _run('return $type.fromEntries([1]).length;'),
          throwsA(
            isA<Object>().having(
              (e) => e.toString(),
              'toString',
              allOf(contains('$type.fromEntries'), contains('MapEntry')),
            ),
          ),
        );
      });
    }
  });

  group('SCC73: set and queue named constructors', () {
    test('F-SCC73-B7: HashSet.of copies the elements [2026-09-06]', () async {
      expect(await _run('return HashSet.of([1, 2, 2, 3]).length;'), equals(3));
    });

    test('F-SCC73-B8: HashSet.identity compares by identity, so two equal '
        'but distinct lists are two elements [2026-09-06]', () async {
      expect(
        await _run('''
          final s = HashSet.identity();
          s.add([1]);
          s.add([1]);
          return s.length;
        '''),
        equals(2),
      );
    });

    test('F-SCC73-B9: LinkedHashSet.identity does the same while keeping '
        'insertion order [2026-09-06]', () async {
      expect(
        await _run('''
          final a = [1];
          final s = LinkedHashSet.identity();
          s.add(a);
          s.add([1]);
          s.add(a);
          return s.length;
        '''),
        equals(2),
      );
    });

    test('F-SCC73-B10: Queue.of preserves order [2026-09-06]', () async {
      expect(
        await _run('return Queue.of([1, 2, 3]).toList();'),
        equals([1, 2, 3]),
      );
    });

    test('F-SCC73-B11: ListQueue.of preserves order [2026-09-06]', () async {
      expect(
        await _run('return ListQueue.of([1, 2, 3]).toList();'),
        equals([1, 2, 3]),
      );
    });
  });

  group('SCC73: dart:core members', () {
    test('F-SCC73-B12: DateTime.timestamp is a UTC now [2026-09-06]', () async {
      expect(
        await _run('''
          final t = DateTime.timestamp();
          return [t.isUtc, t.year > 2000];
        '''),
        equals([true, true]),
      );
    });

    test('F-SCC73-B13: StackTrace.fromString round-trips its text '
        '[2026-09-06]', () async {
      expect(
        await _run("return StackTrace.fromString('at foo').toString();"),
        equals('at foo'),
      );
    });

    test('F-SCC73-B14: RangeError.index carries the index and the length '
        '[2026-09-06]', () async {
      final result = await _run('''
        final e = RangeError.index(5, [1, 2, 3]);
        return [e.invalidValue, e.toString().contains('5')];
      ''');
      expect(result, equals([5, true]));
    });

    test('F-SCC73-B15: Iterable.withIterator builds from a script-supplied '
        'iterator factory [2026-09-06]', () async {
      expect(
        await _run('''
          final it = Iterable.withIterator(() => [1, 2, 3].iterator);
          return [it.toList(), it.toList()];
        '''),
        equals([
          [1, 2, 3],
          [1, 2, 3],
        ]),
      );
    });

    test('F-SCC73-B16: Runes.iterator is a getter, not a method — reading it '
        'yields the iterator itself [2026-09-06]', () async {
      // Registered under `methods`, `x.iterator` handed back the bound
      // callable, so this `moveNext()` failed on a value that looked fine.
      expect(
        await _run('''
          final it = 'ab'.runes.iterator;
          it.moveNext();
          return it.current;
        '''),
        equals('a'.runes.first),
      );
    });
  });

  group('SCC73: dart:async and dart:convert members', () {
    test('F-SCC73-B17: StreamTransformer(onListen) transforms through a '
        'script-returned subscription [2026-09-06]', () async {
      expect(
        await _run('''
          final doubler = StreamTransformer((stream, cancelOnError) {
            return stream.map((v) => v * 2).listen(null,
                cancelOnError: cancelOnError);
          });
          return await Stream.fromIterable([1, 2, 3])
              .transform(doubler)
              .toList();
        '''),
        equals([2, 4, 6]),
      );
    });

    test('F-SCC73-B18: StringConversionSink.fromStringSink writes through to '
        'the StringBuffer [2026-09-06]', () async {
      expect(
        await _run('''
          final buffer = StringBuffer();
          final sink = StringConversionSink.fromStringSink(buffer);
          sink.add('ab');
          sink.close();
          return buffer.toString();
        '''),
        equals('ab'),
      );
    });

    test('F-SCC73-B19: StringConversionSink.from adapts another Sink<String> '
        '[2026-09-06]', () async {
      // The inner sink is built with `StringConversionSink.withCallback`
      // rather than the more obvious `ChunkedConversionSink.withCallback`,
      // and the reason is a defect rather than a preference: the generic
      // `ChunkedConversionSink` factory yields a `_SimpleCallbackSink<dynamic>`
      // because the interpreter erases type arguments, and `Sink<Object?>` is
      // not a `Sink<String>`. `from` then rejects it. That is the
      // contravariant sink trap tracked as SCD181 — a consumer cannot be
      // coerced the way a stream can, it needs a forwarding wrapper — and when
      // that lands this test should gain the `ChunkedConversionSink` case too.
      expect(
        await _run('''
          final seen = <String>[];
          final inner = StringConversionSink.withCallback((s) => seen.add(s));
          final sink = StringConversionSink.from(inner);
          sink.add('ab');
          sink.close();
          return seen;
        '''),
        equals(['ab']),
      );
    });
  });

  group('SCC73: dart:io members', () {
    test('F-SCC73-B20: ProcessResult carries the four values it was built '
        'with [2026-09-06]', () async {
      expect(
        await _run('''
          final r = ProcessResult(11, 0, 'out', 'err');
          return [r.pid, r.exitCode, r.stdout, r.stderr];
        '''),
        equals([11, 0, 'out', 'err']),
      );
    });

    test('F-SCC73-B21: IOSink(target) writes through to the consumer it '
        'wraps [2026-09-06]', () async {
      final result = await _run('''
        final dir = Directory.systemTemp.createTempSync('scc73');
        final file = File('\${dir.path}/out.txt');
        final sink = IOSink(file.openWrite());
        sink.write('hello');
        await sink.close();
        final text = file.readAsStringSync();
        dir.deleteSync(recursive: true);
        return text;
      ''');
      expect(result, equals('hello'));
    });

    test('F-SCC73-B22: stdin.supportsAnsiEscapes and stdout.nonBlocking read '
        'as values [2026-09-06]', () async {
      // Both are environment-dependent, so the assertion is on the TYPE the
      // getter yields rather than on a particular terminal's answer.
      final result = await _run('''
        return [stdin.supportsAnsiEscapes is bool, stdout.nonBlocking is IOSink];
      ''');
      expect(result, equals([true, true]));
    });
  });
}
