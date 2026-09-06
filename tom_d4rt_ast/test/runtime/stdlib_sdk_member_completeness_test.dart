import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// SCC73 mirror coverage for `tom_d4rt_ast` — the members the SDK declares and
/// the bridges were missing.
///
/// The guard that FOUND these lives only in `tom_d4rt`
/// (`test/scc73_sdk_member_completeness_test.dart`): it reads the SDK source
/// with the `analyzer` package, and this package is analyzer-free by
/// construction. The script-level behaviour twin lives there too
/// (`test/stdlib/scc73_sdk_member_completeness_behaviour_test.dart`), because
/// this package has no parser and `tom_d4rt_exec` — the only runner that could
/// execute a script against this tree — resolves it from pub.dev rather than by
/// path, so it cannot see unpublished edits.
///
/// What is left for this tree is the registration level, and it is not a
/// consolation prize: the mirror rule says the two stdlibs are copies of one
/// another, and a copy that dropped an adapter on the way across would be
/// caught here and nowhere else. Every case below invokes the adapter lambda
/// the interpreter would invoke.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    Stdlib(env).register();
    CollectionStdlib.register(env);
    ConvertStdlib.register(env);
    IoStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass bridge(String name) {
    final found = env.findBridgedClassByName(name);
    expect(found, isNotNull, reason: '$name must be a registered bridge');
    return found!;
  }

  /// Invoke a bridged constructor the way the interpreter would.
  Object? construct(
    String bridgeName,
    String constructorName, [
    List<Object?> positional = const [],
    Map<String, Object?> named = const {},
  ]) {
    final adapter = bridge(bridgeName).constructors[constructorName];
    expect(
      adapter,
      isNotNull,
      reason: '$bridgeName.$constructorName must be bridged',
    );
    return adapter!(visitor, positional, named);
  }

  /// Invoke a bridged static member the way the interpreter would.
  Object? callStatic(
    String bridgeName,
    String memberName, [
    List<Object?> positional = const [],
  ]) {
    final adapter = bridge(bridgeName).staticMethods[memberName];
    expect(
      adapter,
      isNotNull,
      reason: '$bridgeName.$memberName must be bridged',
    );
    return adapter!(visitor, positional, const {}, null);
  }

  group('SCC73: the map named constructors, shared across three '
      'implementations', () {
    // The adapters delegate to one shared `MapNamedConstructors` body, so each
    // is exercised through all three types — the point of sharing is that a fix
    // lands everywhere, and only a case per type shows that it did.
    for (final type in const ['HashMap', 'LinkedHashMap', 'SplayTreeMap']) {
      test('F-SCC73-AST-1-$type: $type.fromIterable defaults both callbacks to '
          'the element [2026-09-06]', () {
        final map =
            construct(type, 'fromIterable', [
                  <Object?>[1, 2],
                ])
                as Map;
        expect(map, equals({1: 1, 2: 2}));
      });

      test('F-SCC73-AST-2-$type: $type.fromIterables pairs the two iterables '
          '[2026-09-06]', () {
        final map =
            construct(type, 'fromIterables', [
                  <Object?>['a', 'b'],
                  <Object?>[1, 2],
                ])
                as Map;
        expect(map, equals({'a': 1, 'b': 2}));
      });

      test('F-SCC73-AST-3-$type: $type.fromIterables rejects mismatched '
          'lengths [2026-09-06]', () {
        expect(
          () => construct(type, 'fromIterables', [
            <Object?>['a'],
            <Object?>[1, 2],
          ]),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.toString(),
              'toString',
              contains('different lengths'),
            ),
          ),
        );
      });
    }

    // The SDK declares no `fromEntries` on SplayTreeMap, so only two here.
    for (final type in const ['HashMap', 'LinkedHashMap']) {
      test('F-SCC73-AST-4-$type: $type.fromEntries reads MapEntry values '
          '[2026-09-06]', () {
        final map =
            construct(type, 'fromEntries', [
                  <Object?>[const MapEntry('a', 1), const MapEntry('b', 2)],
                ])
                as Map;
        expect(map, equals({'a': 1, 'b': 2}));
      });

      test('F-SCC73-AST-5-$type: $type.fromEntries names the offending type '
          '[2026-09-06]', () {
        expect(
          () => construct(type, 'fromEntries', [
            <Object?>[1],
          ]),
          throwsA(
            isA<RuntimeD4rtException>().having(
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
    test('F-SCC73-AST-6: HashSet.of copies the elements [2026-09-06]', () {
      expect(
        construct('HashSet', 'of', [
          <Object?>[1, 2, 2, 3],
        ]),
        isA<HashSet<dynamic>>().having((s) => s.length, 'length', 3),
      );
    });

    test(
      'F-SCC73-AST-7: HashSet.identity compares by identity [2026-09-06]',
      () {
        final set = construct('HashSet', 'identity') as HashSet;
        set.add(<int>[1]);
        set.add(<int>[1]);
        expect(set.length, equals(2));
      },
    );

    test(
      'F-SCC73-AST-8: LinkedHashSet.identity does the same [2026-09-06]',
      () {
        final shared = <int>[1];
        final set = construct('LinkedHashSet', 'identity') as LinkedHashSet;
        set.add(shared);
        set.add(<int>[1]);
        set.add(shared);
        expect(set.length, equals(2));
      },
    );

    test('F-SCC73-AST-9: Queue.of preserves order [2026-09-06]', () {
      expect(
        (construct('Queue', 'of', [
                  <Object?>[1, 2, 3],
                ])
                as Queue)
            .toList(),
        equals([1, 2, 3]),
      );
    });

    test('F-SCC73-AST-10: ListQueue.of preserves order [2026-09-06]', () {
      expect(
        (construct('ListQueue', 'of', [
                  <Object?>[1, 2, 3],
                ])
                as ListQueue)
            .toList(),
        equals([1, 2, 3]),
      );
    });
  });

  group('SCC73: dart:core members', () {
    test('F-SCC73-AST-11: DateTime.timestamp is a UTC now [2026-09-06]', () {
      final now = construct('DateTime', 'timestamp') as DateTime;
      expect(now.isUtc, isTrue);
      expect(now.year, greaterThan(2000));
    });

    test('F-SCC73-AST-12: StackTrace.fromString round-trips its text '
        '[2026-09-06]', () {
      expect(
        construct('StackTrace', 'fromString', ['at foo']).toString(),
        equals('at foo'),
      );
    });

    test('F-SCC73-AST-13: RangeError.index carries the index [2026-09-06]', () {
      final error =
          construct('RangeError', 'index', [
                5,
                <Object?>[1, 2, 3],
              ])
              as RangeError;
      expect(error.invalidValue, equals(5));
    });

    test('F-SCC73-AST-14: Iterable.withIterator builds from a supplied '
        'iterator factory [2026-09-06]', () {
      // The bridge takes an interpreted function, which this level cannot
      // construct — so the assertion is that the adapter is registered and
      // rejects a non-function rather than silently accepting it. The
      // behaviour twin in `tom_d4rt` drives the real callback.
      expect(
        () => construct('Iterable', 'withIterator', const [42]),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCC73-AST-15: Runes.iterator is a getter, not a method '
        '[2026-09-06]', () {
      // Registered under `methods`, reading `x.iterator` handed back the bound
      // callable instead of the iterator.
      final runes = bridge('Runes');
      expect(runes.getters['iterator'], isNotNull);
      expect(runes.methods['iterator'], isNull);
      final iterator =
          runes.getters['iterator']!(visitor, 'ab'.runes) as RuneIterator;
      expect(iterator.moveNext(), isTrue);
      expect(iterator.current, equals('a'.runes.first));
    });
  });

  group('SCC73: dart:async and dart:convert members', () {
    test('F-SCC73-AST-16: StreamTransformer(onListen) is registered and '
        'rejects a non-function [2026-09-06]', () {
      expect(
        () => construct('StreamTransformer', '', const [42]),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCC73-AST-17: StringConversionSink.fromStringSink writes through '
        'to the StringSink [2026-09-06]', () {
      final buffer = StringBuffer();
      final sink =
          callStatic('StringConversionSink', 'fromStringSink', [buffer])
              as StringConversionSink;
      sink.add('ab');
      sink.close();
      expect(buffer.toString(), equals('ab'));
    });

    test('F-SCC73-AST-18: StringConversionSink.from adapts another '
        'Sink<String> [2026-09-06]', () {
      final seen = <String>[];
      final inner = StringConversionSink.withCallback(seen.add);
      final sink =
          callStatic('StringConversionSink', 'from', [inner])
              as StringConversionSink;
      sink.add('ab');
      sink.close();
      expect(seen, equals(['ab']));
    });
  });

  group('SCC73: dart:io members', () {
    test('F-SCC73-AST-19: ProcessResult carries the four values it was built '
        'with [2026-09-06]', () {
      final result =
          construct('ProcessResult', '', const [11, 0, 'out', 'err'])
              as ProcessResult;
      expect([
        result.pid,
        result.exitCode,
        result.stdout,
        result.stderr,
      ], equals([11, 0, 'out', 'err']));
    });

    test('F-SCC73-AST-20: IOSink(target) writes through to the consumer it '
        'wraps [2026-09-06]', () async {
      final dir = Directory.systemTemp.createTempSync('scc73_ast');
      addTearDown(() => dir.deleteSync(recursive: true));
      final file = File('${dir.path}/out.txt');
      final sink = construct('IOSink', '', [file.openWrite()]) as IOSink;
      sink.write('hello');
      await sink.close();
      expect(file.readAsStringSync(), equals('hello'));
    });

    test('F-SCC73-AST-21: stdin.supportsAnsiEscapes and stdout.nonBlocking are '
        'exposed as getters [2026-09-06]', () {
      expect(
        bridge('Stdin').getters['supportsAnsiEscapes']!(visitor, stdin),
        isA<bool>(),
      );
      expect(
        bridge('Stdout').getters['nonBlocking']!(visitor, stdout),
        isA<IOSink>(),
      );
    });
  });
}
