import 'dart:async';

import 'package:tom_d4rt/d4rt.dart';

import 'error_handler_args.dart';
import 'run_action.dart';

/// The one implementation of `Stream.listen` for every bridge that has one.
///
/// Nine adapters used to build this by hand — `async/stream.dart`, five in
/// `io/socket.dart`, `io/stdio.dart` and two in `io/http.dart`. They began as
/// copies and then drifted, so the same legal Dart expression `x.listen(null)`
/// produced three different results depending on which bridge `x` came from: it
/// worked on `Stream` and `Socket`, threw `type 'Null' is not a subtype of type
/// 'InterpretedFunction'` on the four socket-family bridges that cast to a
/// non-nullable function, and threw an invented
/// `RuntimeD4rtException('listen requires an onData callback.')` on `Stdin` and
/// `HttpServer`. `SCC25` pinned that in `scc25_listen_adapter_test.dart` before
/// collapsing them here.
///
/// The behaviour kept is the SDK's: `onData` is **optional and nullable**
/// (`Stream.listen` declares `void Function(T)?`), so a script may subscribe
/// for `onDone` / `onError` alone. The two stricter variants were not designed,
/// they were guessed, and no test pinned either of them.
///
/// [stream] is typed `Stream<Object?>` rather than `Stream<T>` because every
/// caller passes a differently-parameterised stream — `Stream<Uint8List>` from
/// `Socket`, `Stream<Socket>` from `ServerSocket`, `Stream<RawSocketEvent>` from
/// `RawSocket` — and `Stream` is covariant, so all of them already are one. The
/// returned `StreamSubscription` is the same object either way; only its static
/// parameter is widened, and the adapter boundary erases that anyway.
///
/// The `onError` wrapper goes through [errorHandlerArgs], which is what makes a
/// script's unary `(e)` handler work alongside the binary `(e, st)` form. That
/// was SCB9's fix and it had to be applied to fourteen sites by hand; routing
/// every `listen` through here is what stops the fifteenth from needing it.
StreamSubscription<Object?> bridgedStreamListen(
  InterpreterVisitor visitor,
  Stream<Object?> stream,
  List<Object?> positionalArgs,
  Map<String, Object?> namedArgs,
) {
  // Bounds-checked: `io/socket.dart` indexed `positionalArgs[0]` directly, so a
  // script writing `socket.listen()` got a RangeError out of the interpreter
  // rather than a diagnosable error. Reading it as absent-means-null matches
  // what passing an explicit null does.
  final onData = positionalArgs.isNotEmpty
      ? positionalArgs[0] as InterpretedFunction?
      : null;
  final onError = namedArgs['onError'] as InterpretedFunction?;
  final onDone = namedArgs['onDone'] as InterpretedFunction?;
  // Left as `bool?`: the SDK treats null as false, so the `?? false` that four
  // of the copies added was a no-op that only made them look different.
  final cancelOnError = namedArgs['cancelOnError'] as bool?;

  return stream.listen(
    onData == null
        ? null
        : (Object? event) => runAction<void>(visitor, onData, [event]),
    onError: onError == null
        ? null
        : (Object error, [StackTrace? stackTrace]) => runAction<void>(
            visitor, onError, errorHandlerArgs(onError, error, stackTrace)),
    onDone: onDone == null ? null : () => runAction<void>(visitor, onDone, []),
    cancelOnError: cancelOnError,
  );
}
