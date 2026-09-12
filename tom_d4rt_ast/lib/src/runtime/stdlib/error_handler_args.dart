import 'package:tom_d4rt_ast/runtime.dart';

/// Builds the argument list for invoking a script-supplied **error handler**.
///
/// The SDK accepts an error handler in either arity — `void Function(Object
/// error)` or `void Function(Object error, StackTrace stackTrace)` — and
/// inspects the callback to decide which to use (`_invokeErrorHandler` type
/// tests against `ZoneBinaryCallback`). Every d4rt adapter used to hardcode the
/// two-argument call, so the unary form died with "Too many positional
/// arguments. Expected at most 1, got 2." Routing the adapters through this
/// helper reproduces the platform's behaviour.
///
/// The selection uses [InterpretedFunction.maxPositionalArity], **not**
/// [InterpretedFunction.arity]: `arity` counts only required positional
/// parameters, so it reports 1 for `(e, [st])` — and native Dart passes both
/// arguments to that closure, because `Function(Object, [StackTrace])` is a
/// subtype of `Function(Object, StackTrace)`. Selecting on `arity` would
/// silently drop the stack trace for the optional form.
///
/// This returns the arguments rather than performing the call so that each
/// adapter keeps its own invocation semantics — `_runAction<T>` versus a direct
/// `call`, its return typing, and its `InternalInterpreterD4rtException`
/// unwrapping.
///
/// Deliberately **not** applicable to `StreamTransformer.fromHandlers`'
/// `handleError`, whose SDK signature is a fixed `(error, stackTrace, sink)`
/// three-argument shape with no arity variance.
List<Object?> errorHandlerArgs(
  Callable handler,
  Object? error,
  StackTrace? stackTrace,
) =>
    // SCD35: only an interpreted function can be asked how many positional
    // parameters it declares. A bridged or native callable carries no such
    // metadata -- `BridgedMethodCallable.arity` is a hardcoded 0 precisely
    // because the adapter validates arity itself -- so there is nothing to
    // introspect and guessing would be worse than choosing. The single-argument
    // form is the safe choice: `(error)` is the shape every SDK error handler
    // accepts, while supplying a second argument to a one-parameter bridged
    // tear-off fails inside the adapter.
    handler is InterpretedFunction && handler.maxPositionalArity >= 2
    ? [error, stackTrace]
    : [error];
