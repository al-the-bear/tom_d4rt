import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
// `BridgedLinkedListEntry` is the concrete entry the bridge constructs; the
// SDK's own `LinkedListEntry` is abstract, so a probe needs this one.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_list.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// SCC74 mirror coverage for `tom_d4rt_ast` — the members the method/static
/// axis of the coverage audit reported unreachable.
///
/// The audit itself (`tom_d4rt/tool/stdlib_member_diff.dart`) drives real
/// scripts through the analyzer-based interpreter and cannot run here; the
/// script-level behaviour twin is
/// `tom_d4rt/test/stdlib/scc74_member_axis_gaps_test.dart`. What this tree can
/// check is that the adapters crossed the mirror, which is the failure it is
/// actually exposed to and which nothing else would catch.
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

  Object? invoke(
    String bridgeName,
    String method,
    Object target, [
    List<Object?> positional = const [],
  ]) {
    final adapter = bridge(bridgeName).methods[method];
    expect(adapter, isNotNull, reason: '$bridgeName.$method must be bridged');
    return adapter!(visitor, target, positional, const {}, null);
  }

  group('SCC74: dart:collection', () {
    test('F-SCC74-AST-1: LinkedListEntry.insertAfter orders the list '
        '[2026-09-06]', () {
      final list = LinkedList<BridgedLinkedListEntry>();
      final a = BridgedLinkedListEntry('a');
      final c = BridgedLinkedListEntry('c');
      list.addAll([a, c]);
      invoke('LinkedListEntry', 'insertAfter', a, [
        BridgedLinkedListEntry('b'),
      ]);
      expect(list.map((e) => e.value), equals(['a', 'b', 'c']));
    });

    test('F-SCC74-AST-2: LinkedListEntry.insertBefore orders the list '
        '[2026-09-06]', () {
      final list = LinkedList<BridgedLinkedListEntry>();
      final a = BridgedLinkedListEntry('a');
      final c = BridgedLinkedListEntry('c');
      list.addAll([a, c]);
      invoke('LinkedListEntry', 'insertBefore', c, [
        BridgedLinkedListEntry('b'),
      ]);
      expect(list.map((e) => e.value), equals(['a', 'b', 'c']));
    });

    test('F-SCC74-AST-3: insertAfter names itself when given a non-entry '
        '[2026-09-06]', () {
      final list = LinkedList<BridgedLinkedListEntry>();
      final a = BridgedLinkedListEntry('a');
      list.add(a);
      expect(
        () => invoke('LinkedListEntry', 'insertAfter', a, ['not an entry']),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            contains('LinkedListEntry.insertAfter'),
          ),
        ),
      );
    });
  });

  group('SCC74: dart:core and dart:convert', () {
    test('F-SCC74-AST-4: Object.noSuchMethod throws for an unhandled '
        'Invocation [2026-09-06]', () {
      expect(
        () => invoke('Object', 'noSuchMethod', Object(), [
          Invocation.method(#absent, const []),
        ]),
        throwsA(isA<NoSuchMethodError>()),
      );
    });

    test('F-SCC74-AST-5: Object.noSuchMethod rejects a non-Invocation '
        '[2026-09-06]', () {
      expect(
        () => invoke('Object', 'noSuchMethod', Object(), ['nope']),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            contains('Invocation'),
          ),
        ),
      );
    });

    test('F-SCC74-AST-6: StringConversionSink.asUtf8Sink decodes the bytes it '
        'is fed [2026-09-06]', () {
      final seen = <String>[];
      final sink = StringConversionSink.withCallback(seen.add);
      final bytes =
          invoke('StringConversionSink', 'asUtf8Sink', sink, const [false])
              as ByteConversionSink;
      bytes.add(const [104, 105]);
      bytes.close();
      expect(seen, equals(['hi']));
    });
  });

  group('SCC74: dart:io', () {
    test('F-SCC74-AST-7: Stdout.lineTerminator is exposed both ways '
        '[2026-09-06]', () {
      // Read only, and written back to what it already was: this is the real
      // process stdout, and leaving it changed would alter how every later
      // suite in the run prints.
      final current = bridge('Stdout').getters['lineTerminator']!(
        visitor,
        stdout,
      );
      expect(current, anyOf(equals('\n'), equals('\r\n')));
      bridge('Stdout').setters['lineTerminator']!(visitor, stdout, current);
      expect(stdout.lineTerminator, equals(current));
    });

    test('F-SCC74-AST-8: Stdout.lineTerminator rejects an illegal value '
        '[2026-09-06]', () {
      expect(
        () => bridge('Stdout').setters['lineTerminator']!(visitor, stdout, 'x'),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCC74-AST-9: the HttpClient callback setters accept null and '
        'reject a non-function [2026-09-06]', () {
      final client = HttpClient();
      addTearDown(() => client.close(force: true));
      for (final name in const ['authenticateProxy', 'connectionFactory']) {
        final setter = bridge('HttpClient').setters[name];
        expect(setter, isNotNull, reason: 'HttpClient.$name must be bridged');
        setter!(visitor, client, null);
        expect(
          () => setter(visitor, client, 42),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.toString(),
              'toString',
              contains(name),
            ),
          ),
        );
      }
    });

    test('F-SCC74-AST-10: WebSocketTransformer.cast yields a transformer '
        '[2026-09-06]', () {
      final transformer = WebSocketTransformer();
      expect(
        invoke('WebSocketTransformer', 'cast', transformer),
        isA<StreamTransformer<HttpRequest, WebSocket>>(),
      );
    });
  });
}
