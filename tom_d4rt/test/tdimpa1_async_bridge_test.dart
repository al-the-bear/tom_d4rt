// TDIMPA1 + DASY1 — async in any context.
//
// DASY1: the async entry points `executeAsync`, `executeAsAsync<T>` and
// `executeProgramAsync` run a script whose entry point returns a Future and
// hand the host the settled, native value; the typed variant unwraps with the
// visitor of ITS run, even when another run on the same interpreter started
// in between.
//
// TDIMPA1: a bridged method or top-level function that returns a native
// Future is awaitable from an async script. The awaited value is wrapped like
// a sync result (a bridged type comes back as a bridged instance the script
// can use), and the Future's error is a catchable script exception.
import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A host service whose calls complete later, as a database or a network
/// client would.
class AsyncService {
  Future<int> doubleLater(int value) =>
      Future<int>.delayed(const Duration(milliseconds: 5), () => value * 2);

  Future<Item> itemLater(int value) =>
      Future<Item>.delayed(const Duration(milliseconds: 5), () => Item(value));

  Future<int> failLater(String message) => Future<int>.delayed(
    const Duration(milliseconds: 5),
    () => throw StateError(message),
  );
}

class Item {
  Item(this.value);
  final int value;
}

/// A bridged interface a script implements; the host gets a proxy for it.
abstract class Greeter {
  String greet();
}

class _GreeterProxy implements Greeter {
  _GreeterProxy(this.visitor, this.instance);
  final InterpreterVisitor visitor;
  final InterpretedInstance instance;
  @override
  String greet() => 'proxy';
}

const _library = 'package:test/async_service.dart';

D4rt _interpreter() {
  final d4rt = D4rt();
  d4rt.registerBridgedClass(
    BridgedClass(
      nativeType: AsyncService,
      name: 'AsyncService',
      constructors: {'': (visitor, positional, named) => AsyncService()},
      methods: {
        'doubleLater': (visitor, target, positional, named, _) =>
            (target as AsyncService).doubleLater(positional[0] as int),
        'itemLater': (visitor, target, positional, named, _) =>
            (target as AsyncService).itemLater(positional[0] as int),
        'failLater': (visitor, target, positional, named, _) =>
            (target as AsyncService).failLater(positional[0] as String),
      },
    ),
    _library,
  );
  d4rt.registerBridgedClass(
    BridgedClass(
      nativeType: Item,
      name: 'Item',
      constructors: {
        '': (visitor, positional, named) => Item(positional[0] as int),
      },
      getters: {'value': (visitor, target) => (target as Item).value},
    ),
    _library,
  );
  d4rt.registerBridgedClass(
    BridgedClass(nativeType: Greeter, name: 'Greeter', isAbstract: true),
    _library,
  );
  d4rt.registertopLevelFunction(
    'tripleLater',
    (visitor, positional, named, typeArgs) => Future<int>.delayed(
      const Duration(milliseconds: 5),
      () => (positional[0] as int) * 3,
    ),
    _library,
  );
  return d4rt;
}

void main() {
  group('DASY1: async entry points', () {
    test(
      'DASY1-1: executeAsync settles an async main to its native value [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source:
              '''
            import '$_library';
            Future<int> main() async {
              await Future.delayed(Duration(milliseconds: 5));
              return 41 + 1;
            }
          ''',
        );
        expect(result, 42);
      },
    );

    test(
      'DASY1-2: executeAsync returns a sync main\'s value unchanged [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source: 'int main() => 7;',
        );
        expect(result, 7);
      },
    );

    test(
      'DASY1-3: an async main that throws fails the Future with the script\'s error [2026-11-06]',
      () async {
        await expectLater(
          _interpreter().executeAsync(
            source: '''
              Future<int> main() async {
                await Future.delayed(Duration(milliseconds: 5));
                throw StateError('boom');
              }
            ''',
          ),
          throwsA(
            isA<StateError>().having((e) => e.message, 'message', 'boom'),
          ),
        );
      },
    );

    test(
      'DASY1-4: executeAsAsync<T> unwraps a bridged result to its native type [2026-11-06]',
      () async {
        final item = await _interpreter().executeAsAsync<Item>(
          source:
              '''
            import '$_library';
            Future<Item> main() async {
              await Future.delayed(Duration(milliseconds: 5));
              return Item(9);
            }
          ''',
        );
        expect(item, isA<Item>());
        expect(item.value, 9);
      },
    );

    test(
      'DASY1-5: executeProgramAsync runs a parsed program\'s async main [2026-11-06]',
      () async {
        final d4rt = _interpreter();
        final program = d4rt.parse('''
          import '$_library';
          Future<String> main(String name) async {
            await Future.delayed(Duration(milliseconds: 5));
            return 'hello \$name';
          }
        ''');
        final result = await d4rt.executeProgramAsync(
          program,
          positionalArgs: ['host'],
        );
        expect(result, 'hello host');
      },
    );

    test(
      'DASY1-6: two interleaved async runs on one interpreter each unwrap with their own visitor [2026-11-06]',
      () async {
        final seen = <InterpreterVisitor>[];
        D4.registerInterfaceProxy('Greeter', (visitor, instance) {
          seen.add(visitor);
          return _GreeterProxy(visitor, instance);
        });
        final d4rt = _interpreter();
        const source =
            '''
          import '$_library';
          class Hello implements Greeter {
            String greet() => 'hello';
          }
          Future<Hello> main(int delay) async {
            await Future.delayed(Duration(milliseconds: delay));
            return Hello();
          }
        ''';
        final first = d4rt.executeAsAsync<Greeter>(
          source: source,
          positionalArgs: [40],
        );
        final firstVisitor = d4rt.visitor;
        final second = d4rt.executeAsAsync<Greeter>(
          source: source,
          positionalArgs: [1],
        );
        final secondVisitor = d4rt.visitor;
        expect(identical(firstVisitor, secondVisitor), isFalse);

        final secondProxy = await second as _GreeterProxy;
        final firstProxy = await first as _GreeterProxy;
        expect(identical(secondProxy.visitor, secondVisitor), isTrue);
        expect(
          identical(firstProxy.visitor, firstVisitor),
          isTrue,
          reason:
              'the first run finished after the second started; it must '
              'still unwrap with the visitor it ran on',
        );
        expect(seen, hasLength(2));
      },
    );
  });

  group('TDIMPA1: awaiting a host Future from a script', () {
    test(
      'TDIMPA1-1: await on a bridged method returning Future<int> gives the value [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source:
              '''
            import '$_library';
            Future<int> main() async {
              final service = AsyncService();
              final doubled = await service.doubleLater(21);
              return doubled + 0;
            }
          ''',
        );
        expect(result, 42);
      },
    );

    test(
      'TDIMPA1-2: an awaited bridged value is wrapped like a sync result [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source:
              '''
            import '$_library';
            Future<List<Object?>> main() async {
              final item = await AsyncService().itemLater(5);
              return [item.value, item is Item, item];
            }
          ''',
        );
        expect(result, isA<List<Object?>>());
        final list = result as List<Object?>;
        expect(list[0], 5);
        expect(list[1], isTrue);
        expect(list[2], isA<Item>(), reason: 'the host gets the native object');
      },
    );

    test(
      'TDIMPA1-3: a failing host Future is a catchable script exception [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source:
              '''
            import '$_library';
            Future<String> main() async {
              try {
                await AsyncService().failLater('no row');
                return 'not reached';
              } on StateError catch (e) {
                return 'caught: \${e.message}';
              }
            }
          ''',
        );
        expect(result, 'caught: no row');
      },
    );

    test(
      'TDIMPA1-4: an uncaught host Future error fails the run with that error [2026-11-06]',
      () async {
        await expectLater(
          _interpreter().executeAsync(
            source:
                '''
              import '$_library';
              Future<int> main() async => await AsyncService().failLater('lost');
            ''',
          ),
          throwsA(
            isA<StateError>().having((e) => e.message, 'message', 'lost'),
          ),
        );
      },
    );

    test(
      'TDIMPA1-5: a bridged top-level function returning a Future is awaitable [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source:
              '''
            import '$_library';
            Future<int> main() async {
              final values = <int>[];
              for (final n in [1, 2, 3]) {
                values.add(await tripleLater(n));
              }
              return values.fold<int>(0, (a, b) => a + b);
            }
          ''',
        );
        expect(result, 18);
      },
    );

    test(
      'TDIMPA1-6: Future.wait over host Futures settles all of them [2026-11-06]',
      () async {
        final result = await _interpreter().executeAsync(
          source:
              '''
            import '$_library';
            Future<List<int>> main() async {
              final service = AsyncService();
              return await Future.wait([
                service.doubleLater(1),
                service.doubleLater(2),
                tripleLater(3),
              ]);
            }
          ''',
        );
        expect(result, [2, 4, 9]);
      },
    );
  });
}
