import 'package:tom_d4rt_ast/runtime.dart';

/// Invokes a script-supplied callback from inside a native callback.
///
/// This is the single definition of a helper that used to be copy-pasted
/// privately into four stdlib files in two different shapes:
///
/// ```dart
/// T?          _runAction<T>(...)  // io/socket.dart, typed_data/uint8_list.dart
/// FutureOr<T> _runAction<T>(...)  // async/stream.dart, async/stream_controller.dart
/// ```
///
/// The two forms differ in exactly one case — a null [function] with a
/// non-nullable `T`, where the `FutureOr` form throws a cast error and the
/// nullable form yields null. No call site depended on that difference: all 84
/// of them either discard the result (`<void>`, `<dynamic>`), compare it
/// (`== true`), or cast it immediately (`as Stream`), and **none awaits it**, so
/// the `FutureOr` return bought nothing over `T?` while being strictly more
/// likely to throw. The merged helper takes the nullable form.
///
/// The copies also carried a `try { ... } catch (e) { rethrow; }` around the
/// call. That is a no-op — `rethrow` preserves the exception and its stack
/// trace, so the block is exactly equivalent to not having it — and it is
/// dropped here rather than reproduced four times.
///
/// Errors propagate. The interpreter's own machinery is what turns an
/// interpreted throw into a script-visible error, and swallowing anything here
/// would hide it from the adapter that knows what operation was in flight.
T? runAction<T>(
  InterpreterVisitor visitor,
  InterpretedFunction? function,
  List<Object?> args,
) =>
    function?.call(visitor, args) as T?;
