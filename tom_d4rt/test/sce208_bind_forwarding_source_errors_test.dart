/// SCE208 — `D4.bindForwardingSourceErrors` routes a source error past a
/// native consumer that drops it.
///
/// `D4.coerceStream` is lazy: a wrongly typed element becomes an ERROR EVENT
/// on the mapped stream. That reaches the script through every consumer that
/// forwards source errors — and measured 2026-09-28, eleven of the twelve
/// bridged consumers of a coerced stream do. `WebSocketTransformer.bind` does
/// not: the SDK listens to its source with no `onError`, so the error went to
/// the zone and the bound stream hung. The script-level reproduction is
/// F-SCE208-1/2 in `stdlib/io/websocket_test.dart`; this file pins the helper
/// natively; the AST twin carries it verbatim modulo the import.
///
/// The error-dropping consumer below is written the way the SDK transformer
/// is: it listens eagerly and passes no `onError`.
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Listens to [source] with no `onError`, as `_WebSocketTransformerImpl` does.
Stream<String> _errorDroppingBind(Stream<int> source) {
  final out = StreamController<String>();
  source.listen((v) => out.add('v$v'), onDone: out.close);
  return out.stream;
}

Stream<Object?> _mixed() => Stream<Object?>.fromIterable([1, 'two', 3]);

void main() {
  group('SCE208: bindForwardingSourceErrors', () {
    test('F-SCE208-3: the coercion error reaches the bound stream through a '
        'consumer that drops source errors [2026-09-28]', () async {
      final events = <Object>[];
      final done = Completer<void>();
      // Guarded so the CONTROL below can prove the error would otherwise have
      // escaped to the zone instead of reaching the listener.
      final escaped = <Object>[];
      runZonedGuarded(() {
        D4
            .bindForwardingSourceErrors<int, String>(
              D4.coerceStream<int>(_mixed(), 'p'),
              _errorDroppingBind,
            )
            .listen(
              events.add,
              onError: (Object e) => events.add('error: $e'),
              onDone: done.complete,
            );
      }, (e, _) => escaped.add(e));
      await done.future;

      expect(events, [
        'v1',
        allOf(startsWith('error: '), contains('but an element was String')),
        'v3',
      ]);
      expect(escaped, isEmpty);
    });

    test('F-SCE208-4: CONTROL — without the helper the same error escapes to '
        'the zone and the listener never sees it [2026-09-28]', () async {
      final events = <Object>[];
      final escaped = <Object>[];
      final done = Completer<void>();
      runZonedGuarded(() {
        _errorDroppingBind(D4.coerceStream<int>(_mixed(), 'p')).listen(
          events.add,
          onError: (Object e) => events.add('error: $e'),
          onDone: done.complete,
        );
      }, (e, _) => escaped.add(e));
      await done.future;

      expect(events, ['v1', 'v3']);
      expect(escaped, [isA<ArgumentD4rtException>()]);
    });

    test('F-SCE208-5: a correctly typed source passes through, and cancelling '
        'the result cancels the bound subscription [2026-09-28]', () async {
      var sourceCancelled = false;
      final source = StreamController<Object?>(
        onCancel: () => sourceCancelled = true,
      );
      final result = D4.bindForwardingSourceErrors<int, String>(
        D4.coerceStream<int>(source.stream, 'p'),
        (s) => s.map((v) => 'v$v'),
      );
      source
        ..add(1)
        ..add(2);
      expect(await result.take(2).toList(), ['v1', 'v2']);
      expect(sourceCancelled, isTrue);
    });
  });
}
