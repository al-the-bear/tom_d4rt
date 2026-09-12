/// SCD35: a method torn off a bridged instance must be usable wherever a
/// function is expected.
///
/// The reproduction is one line of idiomatic Dart:
///
/// ```dart
/// final seen = <int>[]; stream.listen(seen.add);
/// ```
///
/// `seen.add` tears off a method from a bridged `List`, producing a
/// `BridgedMethodCallable`. Sixty-two stdlib bridge files then cast their
/// callback argument to `InterpretedFunction`, which a bridged callable is not
/// a subtype of, so the cast threw — `type 'BridgedMethodCallable' is not a
/// subtype of type 'InterpretedFunction?'`. Adapters that guarded with
/// `is! InterpretedFunction` instead reported `requires a Function`, which is
/// the same defect wearing a more confusing message: the argument *is* a
/// function.
///
/// `Callable` is the supertype both kinds already implement, and two files
/// (`core/list.dart`'s Bug-95 fix, `collection/unmodifiable_list_view.dart`)
/// had converged on it independently. The fix finishes that job across the
/// stdlib rather than adding a third case at each site.
///
/// ## Every case here is the BARE tear-off, on purpose
///
/// The SCC11 tests that first hit this worked around it by wrapping —
/// `stream.listen((v) => seen.add(v))` — and a wrapped call passes just as
/// well with the defect present as without it. An assertion written that way
/// measures nothing. The wrapped form appears exactly once below, labelled as
/// a control, to show the workaround still works and is no longer needed.
///
/// F-SCD35-9 is the ratchet: the surface of this bug grew with the bridge
/// corpus, because every newly bridged member is another tear-off and every
/// newly written adapter is another chance to narrow to `InterpretedFunction`.
/// A behavioural test covers the members it names; the scan covers the ones
/// nobody has written yet.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _libUri = 'package:scd35/scd35.dart';

/// A bridged class with a method that takes a callback, so the "passed to a
/// bridged-function parameter" half does not depend on which stdlib member
/// happens to be wired up today.
class Relay {
  Relay();
  final List<Object?> received = [];
}

D4rt _interpreter() {
  final interpreter = D4rt();
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Relay,
      name: 'Relay',
      constructors: {'': (visitor, positional, named) => Relay()},
      methods: {
        // Takes a callback and invokes it. The adapter accepts any Callable,
        // which is the contract this todo establishes for bridge authors.
        'pump': (visitor, target, positional, named, typeArgs) {
          final callback = positional[0] as Callable;
          for (final v in [1, 2, 3]) {
            callback.call(visitor, [v], const {});
          }
          return null;
        },
      },
      getters: {'received': (visitor, target) => (target as Relay).received},
    ),
    _libUri,
    sourceUri: _libUri,
  );
  return interpreter;
}

/// Runs [source] and returns its result, awaiting it when the script is async.
Future<Object?> _run(String source, {bool withRelay = false}) async {
  final interpreter = withRelay ? _interpreter() : D4rt();
  final result = interpreter.execute(
    source: withRelay ? "import '$_libUri';\n\n$source" : source,
  );
  return result is Future ? await result : result;
}

/// Every `InterpretedFunction` type test or cast in a tree's stdlib, which
/// after SCD35 should be none: the stdlib coerces script-supplied callbacks,
/// and a callback is a `Callable`.
List<String> _narrowingSites(String stdlibRoot) {
  final narrowing = RegExp(r'\b(?:as|is|is!)\s+InterpretedFunction\b');
  final hits = <String>[];
  for (final entity in Directory(stdlibRoot).listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final lines = entity.readAsStringSync().split('\n');
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trimLeft();
      if (trimmed.startsWith('//')) continue; // prose may name the class
      // `errorHandlerArgs` probes for the one capability only an interpreted
      // function has -- how many positional parameters it declares -- to decide
      // whether an error handler takes a stack trace. That is a capability
      // probe, not a coercion gate: the argument is already typed `Callable`
      // and a bridged callable takes the other branch rather than being
      // rejected. Exempted by shape rather than by file, so a plain narrowing
      // cast added to that same file still fails this case.
      if (line.contains('maxPositionalArity')) continue;
      if (narrowing.hasMatch(line)) {
        hits.add('${entity.path.split('/stdlib/').last}:${i + 1}');
      }
    }
  }
  hits.sort();
  return hits;
}

void main() {
  group('SCD35: a bridged tear-off is accepted wherever a function is', () {
    group('passed to a bridged-function parameter', () {
      test('F-SCD35-1: `stream.listen(seen.add)` — the reported case '
          '[2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Stream.fromIterable([1, 2, 3]).listen(seen.add).asFuture();
  return seen.join(',');
}
'''),
          '1,2,3',
        );
      });

      test('F-SCD35-2: `future.then(seen.add)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Future.value(7).then(seen.add);
  return seen.join(',');
}
'''),
          '7',
        );
      });

      test('F-SCD35-3: `stream.map(buffer.write)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final b = StringBuffer();
  await Stream.fromIterable([1, 2]).map(b.write).toList();
  return b.toString();
}
'''),
          '12',
        );
      });

      test('F-SCD35-4: `stream.where(seen.contains)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final allowed = <int>{1, 3};
  final r = await Stream.fromIterable([1, 2, 3]).where(allowed.contains).toList();
  return r.join(',');
}
'''),
          '1,3',
        );
      });

      test('F-SCD35-5: a tear-off reaches a bridged method on a class the '
          'stdlib knows nothing about [2026-09-12]', () async {
        // Independent of which stdlib members happen to be wired up: this is
        // the contract a bridge author writing `as Callable` gets.
        expect(
          await _run('''
main() {
  final seen = <int>[];
  Relay().pump(seen.add);
  return seen.join(',');
}
''', withRelay: true),
          '1,2,3',
        );
      });
    });

    group('passed to an interpreted-function parameter', () {
      test('F-SCD35-6: a declared `void Function(int)` parameter '
          '[2026-09-12]', () async {
        expect(
          await _run('''
void apply(void Function(int) f) {
  f(1);
  f(2);
}

main() {
  final seen = <int>[];
  apply(seen.add);
  return seen.join(',');
}
'''),
          '1,2',
        );
      });

      test(
        'F-SCD35-7: stored in a typed local, then called [2026-09-12]',
        () async {
          expect(
            await _run('''
main() {
  final seen = <int>[];
  void Function(int) f = seen.add;
  f(9);
  return seen.join(',');
}
'''),
            '9',
          );
        },
      );
    });

    group('error handlers, where the widening had to make a choice', () {
      // `errorHandlerArgs` decides whether to hand a handler the stack trace by
      // reading `maxPositionalArity`, which only an interpreted function can
      // answer. Widening its parameter to `Callable` meant deciding what a
      // bridged callable gets. These three cases pin that decision.
      const controller = """
  final got = <Object?>[];
  final c = StreamController();
  c.addError(StateError('x'));
  c.close();
""";

      test('F-SCD35-10: an interpreted `(e, st)` handler still receives the '
          'trace [2026-09-12]', () async {
        // The regression guard on the introspection. Losing this would make
        // every two-parameter error handler silently trace-less.
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: (e, st) {
    got.add(st == null ? 'no-trace' : 'trace');
  });
  await Future.delayed(Duration(milliseconds: 50));
  return got.join(',');
}
"""),
          'trace',
        );
      });

      test('F-SCD35-11: an interpreted `(e)` handler still receives one '
          'argument [2026-09-12]', () async {
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: (e) { got.add('one'); });
  await Future.delayed(Duration(milliseconds: 50));
  return got.join(',');
}
"""),
          'one',
        );
      });

      test('F-SCD35-12: a bridged tear-off as `onError` is called with the '
          'error alone [2026-09-12]', () async {
        // A bridged callable carries no parameter metadata to introspect --
        // `BridgedMethodCallable.arity` is a hardcoded 0 because the adapter
        // validates arity itself. The single-argument form is chosen because
        // `(error)` is the shape every SDK error handler accepts, whereas
        // passing a second argument to a one-parameter tear-off such as
        // `got.add` fails inside the adapter.
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: got.add);
  await Future.delayed(Duration(milliseconds: 50));
  return got.length;
}
"""),
          1,
        );
      });
    });

    test(
      'F-SCD35-8: CONTROL — the wrapped form still works [2026-09-12]',
      () async {
        // The SCC11 workaround. It passed before the fix too, which is exactly
        // why no other case in this file is written this way.
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Stream.fromIterable([1, 2, 3]).listen((v) => seen.add(v)).asFuture();
  return seen.join(',');
}
'''),
          '1,2,3',
        );
      },
    );

    test('F-SCD35-9: no stdlib bridge narrows a callback argument to '
        '`InterpretedFunction`, in either twin [2026-09-12]', () {
      final d4rtRoot = Directory.current.path.endsWith('tom_d4rt')
          ? Directory.current.path
          : '${Directory.current.path}/tom_d4rt';
      final roots = {
        'tom_d4rt': '$d4rtRoot/lib/src/stdlib',
        'tom_d4rt_ast': Directory(
          '$d4rtRoot/../tom_d4rt_ast/lib/src/runtime/stdlib',
        ).absolute.path,
      };

      for (final entry in roots.entries) {
        expect(
          Directory(entry.value).existsSync(),
          isTrue,
          reason:
              '${entry.value} does not exist, so this case would pass having '
              'scanned nothing. Fix the path, not the assertion.',
        );
        expect(
          _narrowingSites(entry.value),
          isEmpty,
          reason:
              'A stdlib bridge coercing a script-supplied callback must accept '
              '`Callable`. Narrowing to `InterpretedFunction` rejects a bridged '
              'tear-off such as `seen.add`, which is a function the script is '
              'entitled to pass. Found in ${entry.key}.',
        );
      }
    });
  });
}
